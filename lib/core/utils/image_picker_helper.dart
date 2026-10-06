import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Universal image reference.
///
/// Either a data URL (`data:image/jpeg;base64,...`) on web,
/// or a relative filesystem path (`challenge_icons/xxx.jpg`) on native.
/// Both are stored in the same DB column.
class ImagePickerHelper {
  ImagePickerHelper._();

  static const _uuid = Uuid();

  /// True if the reference is a data URL.
  static bool isDataUrl(String ref) => ref.startsWith('data:');

  /// Pick a challenge icon. Returns a universal reference string.
  static Future<String?> pickAndSaveChallengeIcon() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked == null) return null;

    if (kIsWeb) {
      final bytes = await picked.readAsBytes();
      final b64 = base64Encode(bytes);
      return 'data:image/jpeg;base64,$b64';
    }

    final dir = await getApplicationDocumentsDirectory();
    final iconDir = Directory(p.join(dir.path, 'challenge_icons'));
    if (!await iconDir.exists()) await iconDir.create(recursive: true);

    final filename = '${_uuid.v4()}.jpg';
    final dest = File(p.join(iconDir.path, filename));
    await File(picked.path).copy(dest.path);
    return 'challenge_icons/$filename';
  }

  /// Pick a proof image for a check-in. Returns a universal reference string.
  static Future<String?> pickAndSaveProofImage(String challengeId) async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (picked == null) return null;

    if (kIsWeb) {
      final bytes = await picked.readAsBytes();
      final b64 = base64Encode(bytes);
      return 'data:image/jpeg;base64,$b64';
    }

    final dir = await getApplicationDocumentsDirectory();
    final proofDir = Directory(p.join(dir.path, 'proofs', challengeId));
    if (!await proofDir.exists()) await proofDir.create(recursive: true);

    final ts = DateTime.now().millisecondsSinceEpoch;
    final filename = '${_uuid.v4()}_$ts.jpg';
    final dest = File(p.join(proofDir.path, filename));
    await File(picked.path).copy(dest.path);
    return 'proofs/$challengeId/$filename';
  }

  /// Delete a proof. No-op on web (data URLs die with the DB row).
  static Future<void> deleteProof(String ref) async {
    if (kIsWeb || isDataUrl(ref)) return;
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, ref));
    if (await file.exists()) await file.delete();
  }

  /// Resolve a native relative path to absolute. Returns null on web.
  static Future<String?> resolveAbsolute(String ref) async {
    if (kIsWeb || isDataUrl(ref)) return null;
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, ref);
  }
}

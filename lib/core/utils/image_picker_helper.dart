import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ImagePickerHelper {
  ImagePickerHelper._();

  static const _uuid = Uuid();

  /// Pick an image from gallery, save it to app documents, return
  /// relative path (e.g. "challenge_icons/abc.jpg"). Null if canceled.
  static Future<String?> pickAndSaveChallengeIcon() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked == null) return null;

    final dir = await getApplicationDocumentsDirectory();
    final iconDir = Directory(p.join(dir.path, 'challenge_icons'));
    if (!await iconDir.exists()) {
      await iconDir.create(recursive: true);
    }

    final filename = '${_uuid.v4()}.jpg';
    final dest = File(p.join(iconDir.path, filename));
    await File(picked.path).copy(dest.path);

    return 'challenge_icons/$filename';
  }

  /// Resolve a relative icon path to an absolute path.
  static Future<String> resolveAbsolute(String relativePath) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, relativePath);
  }
}

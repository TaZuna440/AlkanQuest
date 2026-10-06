import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class CheckinDraft {
  final String challengeId;
  final int? amountCents;
  final String? note;
  final String? proofPath;
  final DateTime savedAt;

  const CheckinDraft({
    required this.challengeId,
    this.amountCents,
    this.note,
    this.proofPath,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() => {
        'challengeId': challengeId,
        'amountCents': amountCents,
        'note': note,
        'proofPath': proofPath,
        'savedAt': savedAt.toIso8601String(),
      };

  factory CheckinDraft.fromJson(Map<String, dynamic> j) => CheckinDraft(
        challengeId: j['challengeId'] as String,
        amountCents: j['amountCents'] as int?,
        note: j['note'] as String?,
        proofPath: j['proofPath'] as String?,
        savedAt: DateTime.parse(j['savedAt'] as String),
      );

  bool get isEmpty =>
      (amountCents == null || amountCents == 0) &&
      (note == null || note!.isEmpty) &&
      (proofPath == null || proofPath!.isEmpty);
}

class DraftService {
  DraftService._();

  static Future<Directory> _draftDir() async {
    final root = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(root.path, 'drafts'));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  static Future<File> _fileFor(String challengeId) async {
    final dir = await _draftDir();
    return File(p.join(dir.path, 'checkin_$challengeId.json'));
  }

  static Future<void> save(CheckinDraft draft) async {
    final file = await _fileFor(draft.challengeId);
    await file.writeAsString(jsonEncode(draft.toJson()));
  }

  static Future<CheckinDraft?> load(String challengeId) async {
    final file = await _fileFor(challengeId);
    if (!await file.exists()) return null;
    try {
      final raw = await file.readAsString();
      return CheckinDraft.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Corrupt draft — delete and continue.
      await file.delete();
      return null;
    }
  }

  static Future<void> clear(String challengeId) async {
    final file = await _fileFor(challengeId);
    if (await file.exists()) await file.delete();
  }

  /// Delete drafts older than 7 days (Section I8 cleanup).
  static Future<void> cleanupOld() async {
    final dir = await _draftDir();
    final now = DateTime.now();
    await for (final entity in dir.list()) {
      if (entity is! File) continue;
      try {
        final raw = await entity.readAsString();
        final draft =
            CheckinDraft.fromJson(jsonDecode(raw) as Map<String, dynamic>);
        if (now.difference(draft.savedAt).inDays > 7) {
          await entity.delete();
        }
      } catch (_) {
        // Ignore — cleanup shouldn't crash the app.
      }
    }
  }
}

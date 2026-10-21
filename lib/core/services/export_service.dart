import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/database/app_database.dart';

/// CSV export of quest + check-in history via the platform share sheet
/// (Phase 11). Money is exported as plain centavos integers plus a
/// human-readable pesos column; dates are ISO-8601.
class ExportService {
  ExportService._();

  static Future<void> exportQuestsCsv(List<Challenge> challenges) async {
    final rows = <String>[
      'id,name,status,frequency,target_cents,saved_cents,remaining_cents,'
          'start_date,target_date,created_at,completed_at',
    ];
    for (final c in challenges) {
      final remaining =
          (c.targetAmountCents - c.currentAmountCents).clamp(0, 1 << 62);
      rows.add([
        c.id,
        _esc(c.name),
        c.status,
        c.frequency,
        c.targetAmountCents,
        c.currentAmountCents,
        remaining,
        _iso(c.startDate),
        _iso(c.targetDate),
        _iso(c.createdAt),
        c.completedAt == null ? '' : _iso(c.completedAt!),
      ].join(','));
    }
    await _shareCsv('ipon_quests.csv', rows.join('\n'), 'Ipon System quest history');
  }

  static Future<void> exportCheckinsCsv(
    List<SavingsRecord> records,
    Map<String, String> questNames,
  ) async {
    final rows = <String>[
      'id,quest_name,date,amount_cents,amount_pesos,note,has_proof',
    ];
    for (final r in records) {
      rows.add([
        r.id,
        _esc(questNames[r.challengeId] ?? r.challengeId),
        _iso(r.date),
        r.amountCents,
        (r.amountCents / 100).toStringAsFixed(2),
        _esc(r.note ?? ''),
        (r.proofPath != null && r.proofPath!.isNotEmpty) ? 'yes' : 'no',
      ].join(','));
    }
    await _shareCsv(
        'ipon_checkins.csv', rows.join('\n'), 'Ipon System check-in history');
  }

  // ------------------------------------------------------------ internals

  static String _esc(String s) => '"${s.replaceAll('"', '""')}"';

  static String _iso(DateTime d) => d.toUtc().toIso8601String();

  static Future<void> _shareCsv(
      String filename, String content, String subject) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsString(content);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'text/csv')],
        text: subject,
        subject: subject,
      ),
    );
  }
}

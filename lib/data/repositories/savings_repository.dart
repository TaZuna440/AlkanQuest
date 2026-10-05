import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';

class SavingsRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  SavingsRepository(this._db);

  Stream<List<SavingsRecord>> watchByChallenge(String challengeId) =>
      (_db.select(_db.savingsRecords)
            ..where((t) => t.challengeId.equals(challengeId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<List<SavingsRecord>> getAllByChallenge(String challengeId) =>
      (_db.select(_db.savingsRecords)
            ..where((t) => t.challengeId.equals(challengeId)))
          .get();

  Future<String> create({
    required String challengeId,
    required int amountCents,
    String? note,
    String? proofPath,
    int? proofWidth,
    int? proofHeight,
    DateTime? date,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    await _db.transaction(() async {
      await _db.into(_db.savingsRecords).insert(
            SavingsRecordsCompanion.insert(
              id: id,
              challengeId: challengeId,
              amountCents: amountCents,
              date: (date ?? now).toUtc(),
              note: Value(note),
              proofPath: Value(proofPath),
              proofWidth: Value(proofWidth),
              proofHeight: Value(proofHeight),
              createdAt: now,
            ),
          );
      await _recomputeChallenge(challengeId);
    });
    return id;
  }

  Future<void> delete(String id) async {
    final record = await (_db.select(_db.savingsRecords)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (record == null) return;
    await _db.transaction(() async {
      await (_db.delete(_db.savingsRecords)..where((t) => t.id.equals(id))).go();
      await _recomputeChallenge(record.challengeId);
    });
  }

  Future<void> _recomputeChallenge(String challengeId) async {
    final records = await getAllByChallenge(challengeId);
    final total = records.fold<int>(0, (sum, r) => sum + r.amountCents);

    final challenge = await (_db.select(_db.challenges)
          ..where((t) => t.id.equals(challengeId)))
        .getSingleOrNull();
    if (challenge == null) return;

    var status = challenge.status;
    DateTime? completedAt = challenge.completedAt;

    if (status == 'active' && total >= challenge.targetAmountCents) {
      status = 'completed';
      completedAt = DateTime.now().toUtc();
    } else if (status == 'completed' && total < challenge.targetAmountCents) {
      status = 'active';
      completedAt = null;
    }

    await (_db.update(_db.challenges)..where((t) => t.id.equals(challengeId)))
        .write(
      ChallengesCompanion(
        currentAmountCents: Value(total),
        status: Value(status),
        completedAt: Value(completedAt),
      ),
    );
  }
}

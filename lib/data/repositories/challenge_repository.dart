import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';

class ChallengeRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  ChallengeRepository(this._db);

  Stream<List<Challenge>> watchAll() =>
      (_db.select(_db.challenges)..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Stream<List<Challenge>> watchByStatus(String status) =>
      (_db.select(_db.challenges)
            ..where((t) => t.status.equals(status))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Future<Challenge?> getById(String id) =>
      (_db.select(_db.challenges)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<String> create({
    required String name,
    String? description,
    required int targetAmountCents,
    required DateTime targetDate,
    required String frequency,
    int startingAmountCents = 0,
    String colorHex = '#B026FF',
    String iconId = 'piggy_bank',
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    await _db.into(_db.challenges).insert(
          ChallengesCompanion.insert(
            id: id,
            name: name,
            description: Value(description),
            targetAmountCents: targetAmountCents,
            currentAmountCents: Value(startingAmountCents),
            startDate: now,
            targetDate: targetDate.toUtc(),
            frequency: frequency,
            colorHex: Value(colorHex),
            iconId: Value(iconId),
            createdAt: now,
          ),
        );
    return id;
  }

  Future<void> update(Challenge challenge) =>
      _db.update(_db.challenges).replace(challenge);

  Future<void> delete(String id) =>
      (_db.delete(_db.challenges)..where((t) => t.id.equals(id))).go();
}

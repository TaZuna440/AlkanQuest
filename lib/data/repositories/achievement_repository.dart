import '../database/app_database.dart';
import '../database/seeds/achievements_seed.dart';

class AchievementRepository {
  final AppDatabase _db;

  AchievementRepository(this._db);

  Stream<List<Achievement>> watchAll() =>
      _db.select(_db.achievements).watch();

  Future<List<Achievement>> getAll() =>
      _db.select(_db.achievements).get();

  Future<void> seedDefaultsIfEmpty() async {
    final existing = await getAll();
    if (existing.isNotEmpty) return;
    await _db.batch((b) {
      b.insertAll(_db.achievements, defaultAchievementsSeed);
    });
  }
}

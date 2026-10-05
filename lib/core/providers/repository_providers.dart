import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/challenge_repository.dart';
import '../../data/repositories/savings_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/achievement_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final challengeRepositoryProvider = Provider<ChallengeRepository>(
  (ref) => ChallengeRepository(ref.watch(appDatabaseProvider)),
);

final savingsRepositoryProvider = Provider<SavingsRepository>(
  (ref) => SavingsRepository(ref.watch(appDatabaseProvider)),
);

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(appDatabaseProvider)),
);

final achievementRepositoryProvider = Provider<AchievementRepository>(
  (ref) => AchievementRepository(ref.watch(appDatabaseProvider)),
);

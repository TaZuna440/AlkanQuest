import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/models/user_stats.dart';
import '../../../domain/services/streak_service.dart';
import '../../../domain/services/xp_service.dart';
import '../../../domain/services/xp_timeline_builder.dart';
import '../../challenges/providers/challenge_providers.dart';

/// Aggregated stats, recomputed whenever any watched stream emits.
/// Null while any source is still loading.
final userStatsProvider = Provider<UserStats?>((ref) {
  final profile = ref.watch(profileProvider).value;
  final records = ref.watch(allRecordsProvider).value;
  final active = ref.watch(activeChallengesProvider).value;
  final completed = ref.watch(completedChallengesProvider).value;
  final cancelled = ref.watch(cancelledChallengesProvider).value;
  if (profile == null ||
      records == null ||
      active == null ||
      completed == null ||
      cancelled == null) {
    return null;
  }

  final totalXp = profile.totalXp;
  final band = XpService.rankFor(totalXp);
  final progress = XpService.rankProgress(totalXp);
  final dates = records.map((r) => r.date);

  return UserStats(
    totalXp: totalXp,
    level: profile.level,
    rank: profile.rank,
    rankTitle: band.title,
    xpIntoBand: progress.intoBand,
    bandSize: progress.bandSize,
    xpToNextRank: XpService.xpToNextRank(totalXp),
    totalSavedCents: records.fold<int>(0, (s, r) => s + r.amountCents),
    totalCheckins: records.length,
    activeQuests: active.length,
    completedQuests: completed.length,
    cancelledQuests: cancelled.length,
    dailyStreak: StreakService.dailySaverStreak(checkinDates: dates),
    longestDailyStreak: StreakService.longestDailyStreak(checkinDates: dates),
    clearedInARow: profile.currentStreak,
    longestClearedStreak: profile.longestStreak,
  );
});

/// XP timeline, newest first (capped at 100 entries).
///
/// Derived from real data — no XP ledger table needed. See
/// [XpTimelineBuilder] for the derivation rules.
final xpTimelineProvider = FutureProvider<List<XpTimelineEntry>>((ref) async {
  final records = ref.watch(allRecordsProvider).value ?? const <SavingsRecord>[];
  final completed = ref.watch(completedChallengesProvider).value ?? const <Challenge>[];
  final active = ref.watch(activeChallengesProvider).value ?? const <Challenge>[];
  final cancelled = ref.watch(cancelledChallengesProvider).value ?? const <Challenge>[];
  final profile = ref.watch(profileProvider).value;
  final unlocked =
      profile?.unlockedAchievementIds.split(',').where((s) => s.isNotEmpty).toSet() ??
          const <String>{};

  final seed = await ref.watch(achievementRepositoryProvider).getAll();

  return XpTimelineBuilder.build(
    records: records,
    completedChallenges: completed,
    questNames: {
      for (final c in [...active, ...completed, ...cancelled]) c.id: c.name,
    },
    unlockedAchievementIds: unlocked,
    achievementRewards: {for (final a in seed) a.id: a.xpReward},
    achievementNames: {for (final a in seed) a.id: a.nameEn},
  );
});

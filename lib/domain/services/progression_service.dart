import 'dart:math' as math;

import '../../data/database/app_database.dart';
import '../../data/repositories/achievement_repository.dart';
import '../../data/repositories/challenge_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/savings_repository.dart';
import 'streak_service.dart';
import 'xp_service.dart';

/// Everything that happens when a check-in is recorded, in one place.
///
/// Phase 05's check-in screen only inserted a [SavingsRecord]. This service
/// wires the game loop on top of the existing repositories (spec A2/A3/B9):
///
/// * first qualifying check-in of the day per quest → +50 XP
/// * quest completion → +500 XP, completion streak +1, milestone flags
/// * achievements evaluated on every write → seed XP rewards
/// * cancelling a quest → completion streak resets to 0 (spec A1)
///
/// Money stays integer centavos everywhere; this service never formats.
class ProgressionService {
  final ChallengeRepository challenges;
  final SavingsRepository savings;
  final ProfileRepository profiles;
  final AchievementRepository achievements;

  ProgressionService({
    required this.challenges,
    required this.savings,
    required this.profiles,
    required this.achievements,
  });

  /// Records a check-in and applies the full progression loop.
  ///
  /// Throws [StateError] when the quest does not exist or is not active.
  /// [at] backdates the record (used by tests; defaults to now).
  Future<CheckinOutcome> recordCheckin({
    required String challengeId,
    required int amountCents,
    String? note,
    String? proofPath,
    DateTime? at,
  }) async {
    if (amountCents <= 0) {
      throw StateError('AMOUNT MUST BE GREATER THAN ₱0.');
    }
    final challenge = await challenges.getById(challengeId);
    if (challenge == null) throw StateError('QUEST NOT FOUND.');
    if (challenge.status != 'active') {
      throw StateError('QUEST IS NO LONGER ACTIVE.');
    }

    await achievements.seedDefaultsIfEmpty();

    final now = at ?? DateTime.now();
    final beforeRecords =
        await savings.getAllByChallenge(challengeId);
    final firstToday = !StreakService.hasQualifyingCheckinToday(
      beforeRecords.map((r) => r.date),
      now: now,
    );

    final allBefore = await savings.getAll();
    final totalBefore = allBefore.fold<int>(0, (s, r) => s + r.amountCents);
    final isFirstEver = allBefore.isEmpty;

    final recordId = await savings.create(
      challengeId: challengeId,
      amountCents: amountCents,
      note: note,
      proofPath: proofPath,
      date: now,
    );

    // savings.create() recomputes the challenge and may complete it.
    var updated = (await challenges.getById(challengeId))!;
    final questCompleted = updated.status == 'completed';

    // Milestone flags (spec: notification service reads these in Phase 10).
    final milestones = _milestonesCrossed(updated);
    if (milestones.isNotEmpty) {
      updated = updated.copyWith(
        milestone25Notified:
            updated.milestone25Notified || milestones.contains(0.25),
        milestone50Notified:
            updated.milestone50Notified || milestones.contains(0.5),
        milestone75Notified:
            updated.milestone75Notified || milestones.contains(0.75),
        nearCompletionNotified:
            updated.nearCompletionNotified || milestones.contains(0.9),
        completionNotified:
            updated.completionNotified || milestones.contains(1.0),
      );
      await challenges.update(updated);
    }

    // ---- XP & achievements ----
    var profile = await profiles.getOrCreate();
    final oldLevel = profile.level;
    final oldRank = profile.rank;

    var xpGained = 0;
    if (firstToday) xpGained += XpService.checkinXp;

    var completionStreak = profile.currentStreak;
    if (questCompleted) {
      xpGained += XpService.completionXp;
      completionStreak += 1;
    }

    final newlyUnlocked = <Achievement>[];
    var unlockedIds =
        profile.unlockedAchievementIds.split(',').where((s) => s.isNotEmpty).toSet();

    Future<void> unlock(String id) async {
      if (unlockedIds.contains(id)) return;
      final all = await achievements.getAll();
      final ach = all.firstWhere((a) => a.id == id);
      unlockedIds = {...unlockedIds, id};
      xpGained += ach.xpReward;
      newlyUnlocked.add(ach);
      profile =
          profile.copyWith(unlockedAchievementIds: unlockedIds.join(','));
    }

    if (isFirstEver) await unlock('first_ipon');
    final totalAfter = totalBefore + amountCents;
    if (totalBefore < 100000 && totalAfter >= 100000) {
      await unlock('first_1000'); // ₱1,000 lifetime
    }
    if (totalBefore < 1000000 && totalAfter >= 1000000) {
      await unlock('saver_10k'); // ₱10,000 lifetime
    }
    if (questCompleted) {
      // NOTE: completion XP (+500, A3) and the FIRST QUEST achievement
      // (+500 seed reward) intentionally stack on the first completion —
      // a deliberate celebration bonus for clearing your first quest.
      await unlock('first_challenge');
      if (completionStreak == 7) await unlock('streak_7');
      if (completionStreak == 30) await unlock('streak_30');
    }

    final newTotalXp = profile.totalXp + xpGained;
    profile = profile.copyWith(
      totalXp: newTotalXp,
      level: XpService.levelFor(newTotalXp),
      rank: XpService.rankFor(newTotalXp).rank,
      currentStreak: completionStreak,
      longestStreak: math.max(profile.longestStreak, completionStreak),
    );
    await profiles.save(profile);

    return CheckinOutcome(
      recordId: recordId,
      firstQualifyingToday: firstToday,
      xpGained: xpGained,
      oldLevel: oldLevel,
      newLevel: profile.level,
      oldRank: oldRank,
      newRank: profile.rank,
      questCompleted: questCompleted,
      newlyUnlocked: newlyUnlocked,
      milestonesCrossed: milestones,
    );
  }

  /// Cancels an active quest. Records are preserved (spec B3); the
  /// quest-completion streak resets to 0 (spec A1).
  Future<void> cancelChallenge(String id) async {
    final c = await challenges.getById(id);
    if (c == null || c.status != 'active') {
      throw StateError('ONLY ACTIVE QUESTS CAN BE CANCELLED.');
    }
    await challenges.update(c.copyWith(status: 'cancelled'));
    final profile = await profiles.getOrCreate();
    await profiles.save(profile.copyWith(currentStreak: 0));
  }

  /// Milestone thresholds newly crossed by [challenge]'s current progress.
  List<double> _milestonesCrossed(Challenge challenge) {
    final target = challenge.targetAmountCents;
    if (target <= 0) return const [];
    final progress = challenge.currentAmountCents / target;
    final out = <double>[];
    if (progress >= 0.25 && !challenge.milestone25Notified) out.add(0.25);
    if (progress >= 0.5 && !challenge.milestone50Notified) out.add(0.5);
    if (progress >= 0.75 && !challenge.milestone75Notified) out.add(0.75);
    if (progress >= 0.9 && !challenge.nearCompletionNotified) out.add(0.9);
    if (progress >= 1.0 && !challenge.completionNotified) out.add(1.0);
    return out;
  }
}

/// What happened as a result of one check-in — everything the UI needs
/// to report back to the player (result dialog, celebrations, notifications).
class CheckinOutcome {
  final String recordId;
  final bool firstQualifyingToday;
  final int xpGained;
  final int oldLevel;
  final int newLevel;
  final String oldRank;
  final String newRank;
  final bool questCompleted;
  final List<Achievement> newlyUnlocked;
  final List<double> milestonesCrossed;

  const CheckinOutcome({
    required this.recordId,
    required this.firstQualifyingToday,
    required this.xpGained,
    required this.oldLevel,
    required this.newLevel,
    required this.oldRank,
    required this.newRank,
    required this.questCompleted,
    required this.newlyUnlocked,
    required this.milestonesCrossed,
  });

  bool get leveledUp => newLevel > oldLevel;
  bool get rankedUp => oldRank != newRank;
}

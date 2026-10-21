import '../../data/database/app_database.dart';
import '../models/user_stats.dart';
import 'xp_service.dart';

/// Pure derivation of the XP timeline from stored data.
///
/// There is no XP ledger table; every entry is reconstructed:
/// * +50 for the first check-in of each day per quest (spec A3)
/// * +500 for each completed quest (spec A3), dated at completion
/// * achievement rewards, dated at the event that unlocked them
///   (first check-in, first completion, savings milestones).
/// Streak achievements are excluded — their unlock moment is not reliably
/// derivable from records alone.
class XpTimelineBuilder {
  XpTimelineBuilder._();

  static List<XpTimelineEntry> build({
    required List<SavingsRecord> records,
    required List<Challenge> completedChallenges,
    required Map<String, String> questNames,
    required Set<String> unlockedAchievementIds,
    required Map<String, int> achievementRewards,
    required Map<String, String> achievementNames,
    int limit = 100,
  }) {
    final entries = <XpTimelineEntry>[];
    final byDate = [...records]..sort((a, b) => a.date.compareTo(b.date));

    // Check-in XP: first record of each (quest, local day).
    final seenDays = <String>{};
    for (final r in byDate) {
      final local = r.date.toLocal();
      final key =
          '${r.challengeId}|${local.year}-${local.month}-${local.day}';
      if (seenDays.add(key)) {
        entries.add(XpTimelineEntry(
          date: local,
          label: 'CHECK-IN · ${(questNames[r.challengeId] ?? 'QUEST').toUpperCase()}',
          xp: XpService.checkinXp,
          kind: XpEventKind.checkin,
        ));
      }
    }

    // Completion XP.
    for (final c in completedChallenges) {
      entries.add(XpTimelineEntry(
        date: (c.completedAt ?? c.createdAt).toLocal(),
        label: 'QUEST COMPLETE · ${c.name.toUpperCase()}',
        xp: XpService.completionXp,
        kind: XpEventKind.completion,
      ));
    }

    // Achievements with derivable unlock moments.
    if (unlockedAchievementIds.isNotEmpty) {
      void add(String id, DateTime date) {
        final reward = achievementRewards[id];
        if (!unlockedAchievementIds.contains(id) || reward == null) return;
        entries.add(XpTimelineEntry(
          date: date.toLocal(),
          label:
              'ACHIEVEMENT · ${(achievementNames[id] ?? id).toUpperCase()}',
          xp: reward,
          kind: XpEventKind.achievement,
        ));
      }

      if (byDate.isNotEmpty) add('first_ipon', byDate.first.date);
      if (completedChallenges.isNotEmpty) {
        final firstDone = [...completedChallenges]
          ..sort((a, b) => (a.completedAt ?? a.createdAt)
              .compareTo(b.completedAt ?? b.createdAt));
        final c = firstDone.first;
        add('first_challenge', c.completedAt ?? c.createdAt);
      }
      final crossed = _firstCrossing(byDate, 100000);
      if (crossed != null) add('first_1000', crossed);
      final crossed10k = _firstCrossing(byDate, 1000000);
      if (crossed10k != null) add('saver_10k', crossed10k);
    }

    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries.take(limit).toList();
  }

  /// Date of the record at which cumulative savings first reached [targetCents].
  static DateTime? _firstCrossing(
      List<SavingsRecord> byDateAsc, int targetCents) {
    var running = 0;
    for (final r in byDateAsc) {
      running += r.amountCents;
      if (running >= targetCents) return r.date;
    }
    return null;
  }
}

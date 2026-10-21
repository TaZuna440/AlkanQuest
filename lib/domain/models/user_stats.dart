/// Aggregated player statistics for the Status screen (Phase 08).
///
/// All money is integer centavos. All streaks are plain counts.
class UserStats {
  final int totalXp;
  final int level;
  final String rank;
  final String rankTitle;
  final int xpIntoBand;
  final int bandSize; // -1 = uncapped (rank S)
  final int? xpToNextRank;

  final int totalSavedCents;
  final int totalCheckins;
  final int activeQuests;
  final int completedQuests;
  final int cancelledQuests;

  final int dailyStreak;
  final int longestDailyStreak;
  final int clearedInARow;
  final int longestClearedStreak;

  const UserStats({
    required this.totalXp,
    required this.level,
    required this.rank,
    required this.rankTitle,
    required this.xpIntoBand,
    required this.bandSize,
    required this.xpToNextRank,
    required this.totalSavedCents,
    required this.totalCheckins,
    required this.activeQuests,
    required this.completedQuests,
    required this.cancelledQuests,
    required this.dailyStreak,
    required this.longestDailyStreak,
    required this.clearedInARow,
    required this.longestClearedStreak,
  });
}

/// One row of the XP timeline: where XP came from and when.
class XpTimelineEntry {
  final DateTime date; // local time
  final String label;
  final int xp;
  final XpEventKind kind;

  const XpTimelineEntry({
    required this.date,
    required this.label,
    required this.xp,
    required this.kind,
  });
}

enum XpEventKind { checkin, completion, achievement }

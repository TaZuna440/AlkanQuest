/// Streak calculations. All inputs are treated as local time; all outputs
/// are plain counts so they stay easy to test and display.
///
/// Two streak concepts exist (kept separate on purpose):
/// * **Quest period streak** — consecutive qualifying periods (days for
///   daily/flexible quests, weeks for weekly, months for monthly) in which the
///   quest got at least one qualifying check-in. Advances on the first
///   qualifying check-in of the period (spec A2 anti-abuse rule).
/// * **Daily saver streak** — consecutive calendar days on which the user
///   logged at least one qualifying check-in on *any* quest.
/// * **Quest-completion streak** ("N quests cleared in a row", spec A1) is
///   stored on the profile and maintained by [ProgressionService], not here.
class StreakService {
  StreakService._();

  /// True when two timestamps fall on the same local calendar day.
  static bool isSameLocalDay(DateTime a, DateTime b) {
    final al = a.toLocal();
    final bl = b.toLocal();
    return al.year == bl.year && al.month == bl.month && al.day == bl.day;
  }

  /// True when [records] already contains a qualifying check-in today.
  static bool hasQualifyingCheckinToday(
    Iterable<DateTime> recordDates, {
    DateTime? now,
  }) {
    final ref = now ?? DateTime.now();
    return recordDates.any((d) => isSameLocalDay(d, ref));
  }

  /// Consecutive qualifying periods ending at the current period.
  ///
  /// The current period gets a grace: if it has no check-in yet, the streak
  /// is counted through the previous period instead of resetting to zero.
  static int questStreak({
    required String frequency,
    required Iterable<DateTime> checkinDates,
    DateTime? now,
  }) {
    final days = _localDays(checkinDates);
    if (days.isEmpty) return 0;
    final ref = _localDay(now ?? DateTime.now());

    switch (frequency) {
      case 'weekly':
        return _consecutivePeriods(
          days,
          _weekStart(ref),
          (d) => d.subtract(const Duration(days: 7)),
          _weekStart,
        );
      case 'monthly':
        return _consecutivePeriods(
          days,
          DateTime(ref.year, ref.month),
          (d) => DateTime(d.year, d.month - 1),
          (d) => DateTime(d.year, d.month),
        );
      default:
        // 'daily' and 'flexible' both streak on consecutive days.
        return _consecutiveDays(days, ref);
    }
  }

  /// Consecutive calendar days with at least one check-in, ending today.
  /// Today gets a grace: with no check-in yet today, counts through yesterday.
  static int dailySaverStreak({
    required Iterable<DateTime> checkinDates,
    DateTime? now,
  }) {
    final days = _localDays(checkinDates);
    if (days.isEmpty) return 0;
    return _consecutiveDays(days, _localDay(now ?? DateTime.now()));
  }

  /// Longest daily-saver streak anywhere in the history.
  static int longestDailyStreak({
    required Iterable<DateTime> checkinDates,
    DateTime? now,
  }) {
    final days = _localDays(checkinDates).toList()..sort();
    if (days.isEmpty) return 0;
    var best = 1;
    var run = 1;
    for (var i = 1; i < days.length; i++) {
      final gap = days[i].difference(days[i - 1]).inDays;
      if (gap == 1) {
        run++;
        if (run > best) best = run;
      } else if (gap > 1) {
        run = 1;
      }
      // gap == 0 cannot happen: days are a set.
    }
    return best;
  }

  // ------------------------------------------------------------------ internals

  static Set<DateTime> _localDays(Iterable<DateTime> dates) => dates
      .map((d) => d.toLocal())
      .map((d) => DateTime(d.year, d.month, d.day))
      .toSet();

  static DateTime _localDay(DateTime dt) {
    final l = dt.toLocal();
    return DateTime(l.year, l.month, l.day);
  }

  /// Monday (00:00) of the week containing [day].
  static DateTime _weekStart(DateTime day) =>
      day.subtract(Duration(days: day.weekday - 1));

  static int _consecutiveDays(Set<DateTime> days, DateTime ref) {
    var cursor = days.contains(ref)
        ? ref
        : ref.subtract(const Duration(days: 1)); // grace for today
    var streak = 0;
    while (days.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  static int _consecutivePeriods(
    Set<DateTime> days,
    DateTime currentKey,
    DateTime Function(DateTime) previous,
    DateTime Function(DateTime) keyOf,
  ) {
    final keys = days.map(keyOf).toSet();
    var cursor = keys.contains(currentKey) ? currentKey : previous(currentKey);
    var streak = 0;
    while (keys.contains(cursor)) {
      streak++;
      cursor = previous(cursor);
    }
    return streak;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ipon_system/domain/services/streak_service.dart';

void main() {
  // Fixed "now": Wednesday 2026-10-14, 12:00 local.
  final now = DateTime(2026, 10, 14, 12, 0);

  List<DateTime> daysAgo(List<int> offsets) =>
      offsets.map((o) => now.subtract(Duration(days: o))).toList();

  group('isSameLocalDay', () {
    test('same day different times', () {
      expect(
        StreakService.isSameLocalDay(
          DateTime(2026, 10, 14, 8),
          DateTime(2026, 10, 14, 23, 59),
        ),
        isTrue,
      );
      expect(
        StreakService.isSameLocalDay(
          DateTime(2026, 10, 14),
          DateTime(2026, 10, 13, 23, 59),
        ),
        isFalse,
      );
    });
  });

  group('questStreak daily', () {
    test('consecutive days incl. today', () {
      expect(
        StreakService.questStreak(
          frequency: 'daily',
          checkinDates: daysAgo([0, 1, 2]),
          now: now,
        ),
        3,
      );
    });

    test('grace: no check-in yet today counts through yesterday', () {
      expect(
        StreakService.questStreak(
          frequency: 'daily',
          checkinDates: daysAgo([1, 2, 3]),
          now: now,
        ),
        3,
      );
    });

    test('gap breaks the streak', () {
      expect(
        StreakService.questStreak(
          frequency: 'daily',
          checkinDates: daysAgo([0, 1, 3]),
          now: now,
        ),
        2,
      );
    });

    test('stale history without recent check-in gives 0', () {
      expect(
        StreakService.questStreak(
          frequency: 'daily',
          checkinDates: daysAgo([5, 6]),
          now: now,
        ),
        0,
      );
    });

    test('flexible behaves like daily', () {
      expect(
        StreakService.questStreak(
          frequency: 'flexible',
          checkinDates: daysAgo([0, 1]),
          now: now,
        ),
        2,
      );
    });
  });

  group('questStreak weekly', () {
    test('consecutive weeks', () {
      // 2026-10-14 is a Wednesday; weeks start Monday.
      expect(
        StreakService.questStreak(
          frequency: 'weekly',
          checkinDates: daysAgo([0, 8, 15]),
          now: now,
        ),
        3,
      );
    });

    test('missing current week still counts (grace)', () {
      expect(
        StreakService.questStreak(
          frequency: 'weekly',
          checkinDates: daysAgo([8, 15]),
          now: now,
        ),
        2,
      );
    });
  });

  group('questStreak monthly', () {
    test('consecutive months', () {
      expect(
        StreakService.questStreak(
          frequency: 'monthly',
          checkinDates: [
            DateTime(2026, 10, 5),
            DateTime(2026, 9, 10),
            DateTime(2026, 8, 20),
          ],
          now: now,
        ),
        3,
      );
    });
  });

  group('dailySaverStreak', () {
    test('counts consecutive days across quests', () {
      expect(
        StreakService.dailySaverStreak(
          checkinDates: daysAgo([0, 1, 2, 3]),
          now: now,
        ),
        4,
      );
    });

    test('longest streak finds the best run', () {
      expect(
        StreakService.longestDailyStreak(
          checkinDates: daysAgo([0, 1, 10, 11, 12]),
          now: now,
        ),
        3,
      );
    });
  });

  group('hasQualifyingCheckinToday', () {
    test('detects a check-in today', () {
      expect(
        StreakService.hasQualifyingCheckinToday(daysAgo([0]), now: now),
        isTrue,
      );
      expect(
        StreakService.hasQualifyingCheckinToday(daysAgo([1]), now: now),
        isFalse,
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ipon_system/data/database/app_database.dart';
import 'package:ipon_system/domain/models/user_stats.dart';
import 'package:ipon_system/domain/services/xp_timeline_builder.dart';

void main() {
  SavingsRecord rec(String id, String quest, int cents, DateTime date) =>
      SavingsRecord(
        id: id,
        challengeId: quest,
        amountCents: cents,
        date: date,
        createdAt: date,
      );

  Challenge quest(String id, String name, DateTime completedAt) => Challenge(
        id: id,
        name: name,
        description: null,
        targetAmountCents: 10000,
        currentAmountCents: 10000,
        startDate: DateTime(2026, 1, 1),
        targetDate: DateTime(2026, 12, 31),
        frequency: 'daily',
        status: 'completed',
        colorHex: '#B026FF',
        iconId: 'savings',
        iconPath: null,
        milestone25Notified: true,
        milestone50Notified: true,
        milestone75Notified: true,
        nearCompletionNotified: true,
        completionNotified: true,
        createdAt: DateTime(2026, 1, 1),
        completedAt: completedAt,
      );

  const rewards = {
    'first_ipon': 100,
    'first_1000': 250,
    'first_challenge': 500,
    'saver_10k': 1500,
  };
  const names = {
    'first_ipon': 'FIRST IPON',
    'first_1000': 'FIRST 1,000',
    'first_challenge': 'FIRST QUEST',
    'saver_10k': 'TEN THOUSAND',
  };

  test('one +50 entry per quest per day, newest first', () {
    final entries = XpTimelineBuilder.build(
      records: [
        rec('r1', 'q1', 5000, DateTime(2026, 10, 12, 9)),
        rec('r2', 'q1', 5000, DateTime(2026, 10, 12, 18)), // same day, same quest
        rec('r3', 'q1', 5000, DateTime(2026, 10, 13, 9)),
        rec('r4', 'q2', 5000, DateTime(2026, 10, 12, 10)), // same day, other quest
      ],
      completedChallenges: const [],
      questNames: const {'q1': 'Emergency', 'q2': 'Travel'},
      unlockedAchievementIds: const {'first_ipon'},
      achievementRewards: rewards,
      achievementNames: names,
    );

    final checkins =
        entries.where((e) => e.kind == XpEventKind.checkin).toList();
    expect(checkins.length, 3); // q1×2 days + q2×1 day
    expect(checkins.every((e) => e.xp == 50), isTrue);
    // Newest first.
    for (var i = 1; i < entries.length; i++) {
      expect(
        entries[i - 1].date.isAfter(entries[i].date) ||
            entries[i - 1].date.isAtSameMomentAs(entries[i].date),
        isTrue,
      );
    }
    // first_ipon dated at the earliest record.
    final ach = entries
        .where((e) => e.kind == XpEventKind.achievement)
        .toList();
    expect(ach.length, 1);
    expect(ach.first.xp, 100);
    expect(ach.first.date.day, 12);
  });

  test('completion and savings milestones appear with right XP', () {
    final entries = XpTimelineBuilder.build(
      records: [
        rec('r1', 'q1', 60000, DateTime(2026, 10, 10, 9)),
        rec('r2', 'q1', 50000, DateTime(2026, 10, 11, 9)), // crosses ₱1,000
      ],
      completedChallenges: [quest('q1', 'Emergency', DateTime(2026, 10, 11, 10))],
      questNames: const {'q1': 'Emergency'},
      unlockedAchievementIds: const {
        'first_ipon',
        'first_challenge',
        'first_1000'
      },
      achievementRewards: rewards,
      achievementNames: names,
    );

    final byKind = <XpEventKind, List<XpTimelineEntry>>{};
    for (final e in entries) {
      byKind.putIfAbsent(e.kind, () => []).add(e);
    }
    expect(byKind[XpEventKind.completion]!.single.xp, 500);
    final achXp =
        byKind[XpEventKind.achievement]!.map((e) => e.xp).toList()..sort();
    expect(achXp, [100, 250, 500]);
    // first_1000 dated at the crossing record (Oct 11).
    final first1000 = byKind[XpEventKind.achievement]!
        .firstWhere((e) => e.xp == 250);
    expect(first1000.date.day, 11);
  });

  test('empty vault gives an empty timeline', () {
    expect(
      XpTimelineBuilder.build(
        records: const [],
        completedChallenges: const [],
        questNames: const {},
        unlockedAchievementIds: const {},
        achievementRewards: rewards,
        achievementNames: names,
      ),
      isEmpty,
    );
  });
}

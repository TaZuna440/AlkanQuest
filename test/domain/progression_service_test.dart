import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipon_system/data/database/app_database.dart';
import 'package:ipon_system/data/repositories/achievement_repository.dart';
import 'package:ipon_system/data/repositories/challenge_repository.dart';
import 'package:ipon_system/data/repositories/profile_repository.dart';
import 'package:ipon_system/data/repositories/savings_repository.dart';
import 'package:ipon_system/domain/services/progression_service.dart';

void main() {
  late AppDatabase db;
  late ProgressionService progression;
  late ProfileRepository profiles;
  late ChallengeRepository challenges;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    challenges = ChallengeRepository(db);
    profiles = ProfileRepository(db);
    progression = ProgressionService(
      challenges: challenges,
      savings: SavingsRepository(db),
      profiles: profiles,
      achievements: AchievementRepository(db),
    );
  });

  tearDown(() async {
    await db.close();
  });

  Future<String> makeQuest({int targetCents = 100000}) {
    return challenges.create(
      name: 'Quest',
      targetAmountCents: targetCents,
      targetDate: DateTime.now().toUtc().add(const Duration(days: 30)),
      frequency: 'daily',
    );
  }

  test('first check-in of the day grants +50 XP', () async {
    final id = await makeQuest();
    final outcome = await progression.recordCheckin(
      challengeId: id,
      amountCents: 5000,
    );

    expect(outcome.firstQualifyingToday, isTrue);
    // +50 first check-in of the day, +100 FIRST IPON achievement.
    // (₱50 total < ₱1,000, so no savings-milestone achievement yet.)
    expect(outcome.xpGained, 50 + 100);
    expect(outcome.newlyUnlocked.map((a) => a.id), contains('first_ipon'));

    final profile = await profiles.getOrCreate();
    expect(profile.totalXp, 150);
    expect(profile.rank, 'E');
  });

  test('second check-in same day grants no XP', () async {
    final id = await makeQuest();
    await progression.recordCheckin(challengeId: id, amountCents: 5000);
    final outcome = await progression.recordCheckin(
      challengeId: id,
      amountCents: 5000,
    );

    expect(outcome.firstQualifyingToday, isFalse);
    expect(outcome.xpGained, 0);
  });

  test('completing a quest grants +500 XP and completion streak', () async {
    final id = await makeQuest(targetCents: 10000);
    await progression.recordCheckin(challengeId: id, amountCents: 4000);
    final outcome = await progression.recordCheckin(
      challengeId: id,
      amountCents: 6000,
    );

    expect(outcome.questCompleted, isTrue);
    // second check-in same day: no +50; +500 completion; +500 FIRST QUEST
    expect(outcome.xpGained, 1000);
    expect(outcome.newlyUnlocked.map((a) => a.id), contains('first_challenge'));

    final quest = await challenges.getById(id);
    expect(quest!.status, 'completed');

    final profile = await profiles.getOrCreate();
    expect(profile.currentStreak, 1);
    expect(profile.longestStreak, 1);
  });

  test('milestone flags are set as progress crosses thresholds', () async {
    final id = await makeQuest(targetCents: 10000);
    await progression.recordCheckin(challengeId: id, amountCents: 3000);
    var quest = await challenges.getById(id);
    expect(quest!.milestone25Notified, isTrue);
    expect(quest.milestone50Notified, isFalse);

    await progression.recordCheckin(challengeId: id, amountCents: 3000);
    quest = await challenges.getById(id);
    expect(quest!.milestone50Notified, isTrue);
    expect(quest.milestone75Notified, isFalse);
  });

  test('cancelling resets the completion streak and keeps records', () async {
    // Build a completion streak of 1 first.
    final doneId = await makeQuest(targetCents: 10000);
    await progression.recordCheckin(challengeId: doneId, amountCents: 10000);
    var profile = await profiles.getOrCreate();
    expect(profile.currentStreak, 1);

    // Cancel a different ACTIVE quest: streak resets, records stay (spec B3).
    final activeId = await makeQuest();
    final recordId = await progression.recordCheckin(
      challengeId: activeId,
      amountCents: 5000,
    );
    await progression.cancelChallenge(activeId);

    final quest = await challenges.getById(activeId);
    expect(quest!.status, 'cancelled');

    profile = await profiles.getOrCreate();
    expect(profile.currentStreak, 0);
    expect(profile.longestStreak, 1);

    final records = await SavingsRepository(db).getAllByChallenge(activeId);
    expect(records.map((r) => r.id), contains(recordId.recordId));
  });

  test('check-in on inactive quest throws', () async {
    final id = await makeQuest(targetCents: 10000);
    await progression.recordCheckin(challengeId: id, amountCents: 10000);
    expect(
      () => progression.recordCheckin(challengeId: id, amountCents: 100),
      throwsStateError,
    );
  });

  test('rank climbs with XP (D at 500)', () async {
    final id = await makeQuest(targetCents: 100000000);
    // 10 check-ins on different days: 10 * (50 + 100 first_ipon once + ...)
    for (var i = 9; i >= 0; i--) {
      await progression.recordCheckin(
        challengeId: id,
        amountCents: 20000, // ₱200 each → ₱2,000 total → first_1000 + saver? no
        at: DateTime.now().subtract(Duration(days: i)),
      );
    }
    final profile = await profiles.getOrCreate();
    // 10*50 + 100 (first_ipon) + 250 (first_1000) = 850 → rank D
    expect(profile.totalXp, 850);
    expect(profile.rank, 'D');
    expect(profile.level, 1);
  });
}

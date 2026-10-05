import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ipon_system/data/database/app_database.dart';
import 'package:ipon_system/data/repositories/challenge_repository.dart';
import 'package:ipon_system/data/repositories/savings_repository.dart';

void main() {
  late AppDatabase db;
  late ChallengeRepository challenges;
  late SavingsRepository savings;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    challenges = ChallengeRepository(db);
    savings = SavingsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('create challenge returns id and inserts row', () async {
    final id = await challenges.create(
      name: 'Emergency Fund',
      targetAmountCents: 1000000,
      targetDate: DateTime.utc(2026, 12, 31),
      frequency: 'weekly',
    );
    final challenge = await challenges.getById(id);
    expect(challenge, isNotNull);
    expect(challenge!.name, 'Emergency Fund');
    expect(challenge.targetAmountCents, 1000000);
    expect(challenge.status, 'active');
  });

  test('savings records update challenge currentAmountCents', () async {
    final id = await challenges.create(
      name: 'Test',
      targetAmountCents: 10000,
      targetDate: DateTime.utc(2026, 12, 31),
      frequency: 'daily',
    );
    await savings.create(challengeId: id, amountCents: 2500);
    await savings.create(challengeId: id, amountCents: 1500);
    final challenge = await challenges.getById(id);
    expect(challenge!.currentAmountCents, 4000);
  });

  test('challenge auto-completes when target reached', () async {
    final id = await challenges.create(
      name: 'Test',
      targetAmountCents: 1000,
      targetDate: DateTime.utc(2026, 12, 31),
      frequency: 'daily',
    );
    await savings.create(challengeId: id, amountCents: 1000);
    final challenge = await challenges.getById(id);
    expect(challenge!.status, 'completed');
    expect(challenge.completedAt, isNotNull);
  });

  test('deleting record reverts completed challenge back to active', () async {
    final id = await challenges.create(
      name: 'Test',
      targetAmountCents: 1000,
      targetDate: DateTime.utc(2026, 12, 31),
      frequency: 'daily',
    );
    final recordId = await savings.create(challengeId: id, amountCents: 1000);
    var challenge = await challenges.getById(id);
    expect(challenge!.status, 'completed');

    await savings.delete(recordId);
    challenge = await challenges.getById(id);
    expect(challenge!.status, 'active');
    expect(challenge.currentAmountCents, 0);
    expect(challenge.completedAt, isNull);
  });
}

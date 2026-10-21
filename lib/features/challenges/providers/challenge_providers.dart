import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/database/app_database.dart';

final activeChallengesProvider = StreamProvider<List<Challenge>>((ref) {
  return ref.watch(challengeRepositoryProvider).watchByStatus('active');
});

final completedChallengesProvider = StreamProvider<List<Challenge>>((ref) {
  return ref.watch(challengeRepositoryProvider).watchByStatus('completed');
});

final cancelledChallengesProvider = StreamProvider<List<Challenge>>((ref) {
  return ref.watch(challengeRepositoryProvider).watchByStatus('cancelled');
});

/// Live profile stream — re-emits on every profile update (XP, streaks, ...).
final profileProvider = StreamProvider<UserProfile?>((ref) {
  return ref.watch(profileRepositoryProvider).watch();
});

/// Live stream of a single challenge by id.
final challengeByIdProvider =
    StreamProvider.family<Challenge?, String>((ref, id) {
  return ref.watch(challengeRepositoryProvider).watchById(id);
});

/// Check-in history of one challenge, newest first.
final challengeRecordsProvider =
    StreamProvider.family<List<SavingsRecord>, String>((ref, id) {
  return ref.watch(savingsRepositoryProvider).watchByChallenge(id);
});

/// Every savings record in the vault, newest first.
final allRecordsProvider = StreamProvider<List<SavingsRecord>>((ref) {
  return ref.watch(savingsRepositoryProvider).watchAll();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/database/app_database.dart';

final activeChallengesProvider = StreamProvider<List<Challenge>>((ref) {
  return ref.watch(challengeRepositoryProvider).watchByStatus('active');
});

final completedChallengesProvider = StreamProvider<List<Challenge>>((ref) {
  return ref.watch(challengeRepositoryProvider).watchByStatus('completed');
});

final profileProvider = StreamProvider<UserProfile?>((ref) async* {
  final repo = ref.watch(profileRepositoryProvider);
  yield await repo.getOrCreate();
});

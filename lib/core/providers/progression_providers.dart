import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/repository_providers.dart';
import '../../domain/services/progression_service.dart';

/// The game-loop orchestrator (XP, streaks, achievements, milestones).
///
/// UI calls [ProgressionService.recordCheckin] / [cancelChallenge] instead
/// of touching the savings/challenge repositories directly, so the loop
/// can never be skipped by a screen.
final progressionServiceProvider = Provider<ProgressionService>((ref) {
  return ProgressionService(
    challenges: ref.watch(challengeRepositoryProvider),
    savings: ref.watch(savingsRepositoryProvider),
    profiles: ref.watch(profileRepositoryProvider),
    achievements: ref.watch(achievementRepositoryProvider),
  );
});

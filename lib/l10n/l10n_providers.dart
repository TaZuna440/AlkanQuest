import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/challenges/providers/challenge_providers.dart';

/// Current UI locale ('en' | 'fil'), from the player profile.
final localeProvider = Provider<String>((ref) {
  return ref.watch(profileProvider).value?.locale ?? 'en';
});

/// Whether the dramatic System voice is enabled, from the player profile.
final systemVoiceProvider = Provider<bool>((ref) {
  return ref.watch(profileProvider).value?.systemVoiceEnabled ?? true;
});

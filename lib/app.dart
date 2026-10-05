import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/repository_providers.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/onboarding/presentation/awakening_screen.dart';
import 'features/onboarding/presentation/briefing_screen.dart';
import 'features/onboarding/presentation/first_quest_screen.dart';
import 'features/onboarding/presentation/registration_screen.dart';
import 'features/onboarding/presentation/splash_screen.dart';
import 'features/onboarding/providers/onboarding_providers.dart';

class IponApp extends StatelessWidget {
  const IponApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ipon System',
      debugShowCheckedModeBanner: false,
      theme: buildIponTheme(),
      home: const AppRoot(),
    );
  }
}

class AppRoot extends ConsumerStatefulWidget {
  const AppRoot({super.key});

  @override
  ConsumerState<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends ConsumerState<AppRoot> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final profileRepo = ref.read(profileRepositoryProvider);
    final profile = await profileRepo.getOrCreate();
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (profile.onboardingComplete) {
        ref.read(onboardingStepProvider.notifier).complete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const SplashScreen();

    final step = ref.watch(onboardingStepProvider);
    switch (step) {
      case OnboardingStep.awakening:
        return const AwakeningScreen();
      case OnboardingStep.registration:
        return const RegistrationScreen();
      case OnboardingStep.firstQuest:
        return const FirstQuestScreen();
      case OnboardingStep.briefing:
        return const BriefingScreen();
      case OnboardingStep.complete:
        return const HomeScreen();
    }
  }
}

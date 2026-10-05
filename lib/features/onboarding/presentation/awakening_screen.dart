import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/system_button.dart';
import '../providers/onboarding_providers.dart';

class AwakeningScreen extends ConsumerWidget {
  const AwakeningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: SystemWindowFrame(
                title: 'SYSTEM MESSAGE',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'YOU HAVE BEEN SELECTED\nAS A SAVINGS HUNTER.',
                      style: IponTypography.header,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'COMPLETE QUESTS.\nEARN XP. RANK UP.\nBUILD YOUR IPON.',
                      style: IponTypography.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    SystemButton(
                      label: 'ACCEPT',
                      onPressed: () => ref
                          .read(onboardingStepProvider.notifier)
                          .goToRegistration(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

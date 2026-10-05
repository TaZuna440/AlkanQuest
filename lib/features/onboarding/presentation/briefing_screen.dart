import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/repository_providers.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/system_button.dart';
import '../providers/onboarding_providers.dart';

class BriefingScreen extends ConsumerStatefulWidget {
  const BriefingScreen({super.key});

  @override
  ConsumerState<BriefingScreen> createState() => _BriefingScreenState();
}

class _BriefingScreenState extends ConsumerState<BriefingScreen> {
  bool _finishing = false;

  Future<void> _enter() async {
    if (_finishing) return;
    setState(() => _finishing = true);

    final data = ref.read(onboardingDataProvider);
    final profileRepo = ref.read(profileRepositoryProvider);

    await profileRepo.updateDisplayName(data.displayName);
    await profileRepo.markOnboardingComplete();

    if (!mounted) return;
    ref.read(onboardingStepProvider.notifier).complete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: SystemWindowFrame(
                title: 'SYSTEM BRIEFING',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _bullet('\u25C6 SAVE', 'LOG YOUR SAVINGS'),
                    _bullet('\u25C6 EARN', 'GAIN XP AND RANK UP'),
                    _bullet('\u25C6 CLEAR', 'COMPLETE YOUR QUESTS'),
                    _bullet('\u25C6 STREAK', 'CLEAR QUESTS IN A ROW'),
                    const SizedBox(height: 20),
                    const Text(
                      'FAILURE TO COMPLETE DAILY QUESTS\nDOES NOT RESULT IN PENALTY.\nALL HUNTERS PROGRESS AT THEIR OWN PACE.',
                      style: IponTypography.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    SystemButton(
                      label: _finishing ? 'ENTERING...' : 'ENTER SYSTEM',
                      onPressed: _finishing ? null : _enter,
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

  Widget _bullet(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: IponTypography.header),
          ),
          Expanded(
            child: Text(desc, style: IponTypography.body),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/repository_providers.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/system_button.dart';
import '../providers/onboarding_providers.dart';

class _Template {
  final String id;
  final String name;
  final String desc;
  final String reward;
  final int targetCents;
  final int daysFromNow;
  final String frequency;
  final String iconId;
  final String colorHex;

  const _Template({
    required this.id,
    required this.name,
    required this.desc,
    required this.reward,
    required this.targetCents,
    required this.daysFromNow,
    required this.frequency,
    required this.iconId,
    required this.colorHex,
  });
}

const _templates = [
  _Template(
    id: 'p50_daily',
    name: 'P50/DAY CHALLENGE',
    desc: 'SAVE P50 DAILY FOR 30 DAYS',
    reward: '500 XP',
    targetCents: 150000,
    daysFromNow: 30,
    frequency: 'daily',
    iconId: 'coin_stack',
    colorHex: '#B026FF',
  ),
  _Template(
    id: 'week_52',
    name: '52-WEEK CHALLENGE',
    desc: 'SAVE WEEKLY FOR 52 WEEKS',
    reward: '1000 XP',
    targetCents: 520000,
    daysFromNow: 364,
    frequency: 'weekly',
    iconId: 'trophy',
    colorHex: '#FFD24A',
  ),
  _Template(
    id: 'custom',
    name: 'CUSTOM QUEST',
    desc: 'SET YOUR OWN GOAL',
    reward: '',
    targetCents: 0,
    daysFromNow: 0,
    frequency: 'daily',
    iconId: 'flag',
    colorHex: '#39FF88',
  ),
];

class FirstQuestScreen extends ConsumerWidget {
  const FirstQuestScreen({super.key});

  Future<void> _onTemplateTap(
    WidgetRef ref,
    _Template template,
  ) async {
    // Capture notifiers BEFORE any await — Riverpod 3 requires this.
    final onboardingDataNotifier = ref.read(onboardingDataProvider.notifier);
    final onboardingStepNotifier =
        ref.read(onboardingStepProvider.notifier);

    if (template.id == 'custom') {
      onboardingDataNotifier.setTemplate(null);
      onboardingStepNotifier.goToBriefing();
      return;
    }

    final challengeRepo = ref.read(challengeRepositoryProvider);
    await challengeRepo.create(
      name: template.name,
      description: template.desc,
      targetAmountCents: template.targetCents,
      targetDate:
          DateTime.now().toUtc().add(Duration(days: template.daysFromNow)),
      frequency: template.frequency,
      iconId: template.iconId,
      colorHex: template.colorHex,
    );

    onboardingDataNotifier.setTemplate(template.id);
    onboardingStepNotifier.goToBriefing();
  }

  void _skip(WidgetRef ref) {
    ref.read(onboardingDataProvider.notifier).setTemplate(null);
    ref.read(onboardingStepProvider.notifier).goToBriefing();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: SystemWindowFrame(
              title: 'FIRST QUEST',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('ACCEPT A STARTER QUEST:',
                      style: IponTypography.label),
                  const SizedBox(height: 16),
                  for (final t in _templates) ...[
                    _TemplateCard(
                      template: t,
                      onTap: () => _onTemplateTap(ref, t),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 8),
                  SystemButton(
                    label: 'SKIP FOR NOW',
                    onPressed: () => _skip(ref),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final _Template template;
  final VoidCallback onTap;

  const _TemplateCard({required this.template, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final accent = _parseHex(template.colorHex);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: accent.withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('\u25C6 ',
                      style: IponTypography.header.copyWith(color: accent)),
                  Expanded(
                    child: Text(template.name,
                        style: IponTypography.header),
                  ),
                  if (template.reward.isNotEmpty)
                    Text(template.reward,
                        style: IponTypography.label
                            .copyWith(color: IponColors.gold)),
                ],
              ),
              const SizedBox(height: 6),
              Text(template.desc, style: IponTypography.body),
            ],
          ),
        ),
      ),
    );
  }

  Color _parseHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}

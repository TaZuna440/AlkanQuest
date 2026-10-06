import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../core/widgets/challenge_icon.dart';
import '../../../data/database/app_database.dart';
import '../../challenges/presentation/create_challenge_screen.dart';
import '../../challenges/providers/challenge_providers.dart';
import '../../checkin/presentation/checkin_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final challengesAsync = ref.watch(activeChallengesProvider);

    final displayName = profileAsync.maybeWhen(
      data: (p) => p?.displayName ?? 'HUNTER',
      orElse: () => 'HUNTER',
    );

    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SystemWindowFrame(
              title: 'STATUS',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text('WELCOME BACK, $displayName',
                      style: IponTypography.header),
                  const SizedBox(height: 8),
                  const Text('\u25C6 STREAK: 0 QUESTS CLEARED',
                      style: IponTypography.label),
                  const SizedBox(height: 24),
                  challengesAsync.when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text('LOADING...',
                            style: IponTypography.label),
                      ),
                    ),
                    error: (e, _) => Text('ERROR: $e',
                        style: IponTypography.body
                            .copyWith(color: IponColors.danger)),
                    data: (challenges) {
                      if (challenges.isEmpty) {
                        return _buildEmptyQuestCard(context);
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final c in challenges) ...[
                            _ChallengeCard(challenge: c),
                            const SizedBox(height: 12),
                          ],
                          const SizedBox(height: 8),
                          _buildCreateButton(context, label: '+ NEW QUEST'),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyQuestCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border:
            Border.all(color: IponColors.frameOuter.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('NO ACTIVE QUESTS', style: IponTypography.header),
          const SizedBox(height: 12),
          const Text(
            'Accept your first quest to begin your Ipon journey.',
            style: IponTypography.body,
          ),
          const SizedBox(height: 16),
          _buildCreateButton(context, label: '+ CREATE QUEST'),
        ],
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context, {required String label}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateChallengeScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: IponColors.frameOuter),
            boxShadow: [
              BoxShadow(
                color: IponColors.frameOuter.withValues(alpha: 0.4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Center(
            child: Text(label, style: IponTypography.header),
          ),
        ),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final targetCents = challenge.targetAmountCents;
    final currentCents = challenge.currentAmountCents;
    final progress = targetCents == 0
        ? 0.0
        : (currentCents / targetCents).clamp(0.0, 1.0);
    final percent = (progress * 100).round();
    final remaining = (targetCents - currentCents).clamp(0, targetCents);
    final color = _parseHex(challenge.colorHex);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ChallengeIcon(
                  iconPath: challenge.iconPath, color: color, size: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Text('\u25C6 ${challenge.name}',
                    style: IponTypography.header),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _progressBar(progress, color),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${MoneyFormatter.format(currentCents)} / ${MoneyFormatter.format(targetCents)}',
                style: IponTypography.value,
              ),
              Text('$percent%',
                  style: IponTypography.value.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: 4),
          Text('${MoneyFormatter.format(remaining)} REMAINING',
              style: IponTypography.label),
          const SizedBox(height: 14),
          _savedItButton(context, color),
        ],
      ),
    );
  }

  Widget _savedItButton(BuildContext context, Color color) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CheckinScreen(challenge: challenge),
            ),
          );
          // Home refreshes automatically via activeChallengesProvider stream.
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: color),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '+ I SAVED IT',
              style: IponTypography.header.copyWith(color: color),
            ),
          ),
        ),
      ),
    );
  }

  Widget _progressBar(double value, Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final filled = constraints.maxWidth * value;
        return Container(
          height: 8,
          decoration: BoxDecoration(
            color: IponColors.bgPlum,
            border: Border.all(
              color: IponColors.frameInner.withValues(alpha: 0.2),
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: filled,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, IponColors.textPrimary],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _parseHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}

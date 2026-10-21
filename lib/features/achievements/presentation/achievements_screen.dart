import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/models/user_stats.dart';
import '../../../l10n/app_strings.dart';
import '../../../l10n/l10n_providers.dart';
import '../../challenges/providers/challenge_providers.dart';
import '../../status/providers/status_providers.dart';
import 'achievement_celebration_dialog.dart';

/// Phase 09 — Achievements gallery: every achievement from the seed,
/// unlocked (gold) or locked (dim), with names in the player's locale
/// and a progress hint toward each locked one.
class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync =
        ref.watch(achievementRepositoryProvider).watchAll();
    final profile = ref.watch(profileProvider).value;
    final stats = ref.watch(userStatsProvider);

    final locale = ref.watch(localeProvider);
    String t(String key) => AppStrings.of(key, locale);

    final unlocked =
        profile?.unlockedAchievementIds.split(',').where((s) => s.isNotEmpty).toSet() ??
            const <String>{};

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SystemWindowFrame(
            title: t(AppStrings.achievementsTitle),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${unlocked.length} / 6 UNLOCKED',
                  style: IponTypography.label,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                StreamBuilder<List<Achievement>>(
                  stream: achievementsAsync,
                  builder: (context, snap) {
                    if (!snap.hasData) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text('LOADING...',
                              style: IponTypography.label),
                        ),
                      );
                    }
                    final list = snap.data!;
                    return Column(
                      children: [
                        for (final a in list) ...[
                          _AchievementCard(
                            achievement: a,
                            unlocked: unlocked.contains(a.id),
                            locale: locale,
                            stats: stats,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final bool unlocked;
  final String locale;
  final UserStats? stats;

  const _AchievementCard({
    required this.achievement,
    required this.unlocked,
    required this.locale,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final accent = unlocked ? IponColors.gold : IponColors.textDim;
    final name =
        locale == 'fil' ? achievement.nameFil : achievement.nameEn;
    final desc = locale == 'fil'
        ? achievement.descriptionFil
        : achievement.descriptionEn;

    return Opacity(
      opacity: unlocked ? 1.0 : 0.55,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: accent.withValues(alpha: 0.7)),
          boxShadow: unlocked
              ? [
                  BoxShadow(
                    color: IponColors.gold.withValues(alpha: 0.25),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: accent, width: 2),
              ),
              child: Icon(
                AchievementIcons.forId(achievement.icon),
                color: accent,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: IponTypography.header
                          .copyWith(color: accent, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(desc,
                      style: IponTypography.body.copyWith(fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(
                    unlocked
                        ? 'UNLOCKED · +${achievement.xpReward} XP'
                        : _progressHint(),
                    style: IponTypography.label.copyWith(
                      fontSize: 10,
                      color: unlocked ? IponColors.success : IponColors.textDim,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Human-readable progress toward a locked achievement.
  String _progressHint() {
    if (stats == null) return 'LOCKED · +${achievement.xpReward} XP';
    switch (achievement.id) {
      case 'first_ipon':
        return 'LOCKED · LOG YOUR FIRST CHECK-IN · +${achievement.xpReward} XP';
      case 'first_1000':
        return 'LOCKED · ${MoneyFormatter.format(stats!.totalSavedCents)} / ₱1,000 SAVED · +${achievement.xpReward} XP';
      case 'saver_10k':
        return 'LOCKED · ${MoneyFormatter.format(stats!.totalSavedCents)} / ₱10,000 SAVED · +${achievement.xpReward} XP';
      case 'streak_7':
        return 'LOCKED · ${stats!.clearedInARow} / 7 QUESTS IN A ROW · +${achievement.xpReward} XP';
      case 'streak_30':
        return 'LOCKED · ${stats!.clearedInARow} / 30 QUESTS IN A ROW · +${achievement.xpReward} XP';
      case 'first_challenge':
        return 'LOCKED · COMPLETE YOUR FIRST QUEST · +${achievement.xpReward} XP';
      default:
        return 'LOCKED · +${achievement.xpReward} XP';
    }
  }
}

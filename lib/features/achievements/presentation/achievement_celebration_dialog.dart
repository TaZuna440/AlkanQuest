import 'package:flutter/material.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/system_button.dart';
import '../../../data/database/app_database.dart';
import '../../../l10n/system_voice.dart';

/// The in-app celebration moment: a dramatic full System Window announcing
/// an unlocked achievement. Shown after the check-in result dialog.
class AchievementCelebrationDialog extends StatelessWidget {
  final Achievement achievement;
  final String locale;
  final bool dramatic;

  const AchievementCelebrationDialog({
    super.key,
    required this.achievement,
    required this.locale,
    this.dramatic = true,
  });

  static Future<void> show(
    BuildContext context, {
    required Achievement achievement,
    required String locale,
    bool dramatic = true,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AchievementCelebrationDialog(
        achievement: achievement,
        locale: locale,
        dramatic: dramatic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = locale == 'fil' ? achievement.nameFil : achievement.nameEn;
    final desc = locale == 'fil'
        ? achievement.descriptionFil
        : achievement.descriptionEn;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          color: IponColors.bgIndigo.withValues(alpha: 0.97),
          border: Border.all(color: IponColors.gold, width: 3),
          boxShadow: [
            BoxShadow(
              color: IponColors.gold.withValues(alpha: 0.6),
              blurRadius: 32,
              spreadRadius: 3,
            ),
          ],
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '\u25C6 \u25C6 \u25C6',
              style: TextStyle(color: IponColors.gold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              SystemVoice.achievementTitle(
                  dramatic: dramatic, locale: locale),
              style: IponTypography.windowTitle.copyWith(
                color: IponColors.gold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Icon(
              AchievementIcons.forId(achievement.icon),
              color: IponColors.gold,
              size: 56,
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: IponTypography.header.copyWith(
                color: IponColors.textPrimary,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: IponTypography.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '+${achievement.xpReward} XP',
              style: IponTypography.bigNumber.copyWith(
                color: IponColors.gold,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SystemButton(
              label: 'CLAIM',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Maps the seed's icon ids to Material icons.
class AchievementIcons {
  AchievementIcons._();

  static IconData forId(String id) => switch (id) {
        'coin_stack' => Icons.savings_outlined,
        'vault' => Icons.lock_outline,
        'trophy' => Icons.emoji_events_outlined,
        'crown' => Icons.workspace_premium_outlined,
        'flag' => Icons.flag_outlined,
        'diamond' => Icons.diamond_outlined,
        _ => Icons.star_outline,
      };
}

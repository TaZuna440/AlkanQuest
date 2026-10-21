import 'package:flutter/material.dart';

import '../theme/color_palette.dart';
import '../theme/typography.dart';
import 'system_button.dart';

/// A System-Window-styled notice dialog: quest results, level-ups,
/// achievements, warnings. One accent color, a list of lines, one button.
class SystemNoticeDialog extends StatelessWidget {
  final String title;
  final List<String> lines;
  final Color accent;
  final String buttonLabel;

  const SystemNoticeDialog({
    super.key,
    required this.title,
    required this.lines,
    this.accent = IponColors.frameOuter,
    this.buttonLabel = 'CONFIRM',
  });

  /// Shows the dialog and completes when the player confirms.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required List<String> lines,
    Color accent = IponColors.frameOuter,
    String buttonLabel = 'CONFIRM',
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => SystemNoticeDialog(
        title: title,
        lines: lines,
        accent: accent,
        buttonLabel: buttonLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          color: IponColors.bgIndigo.withValues(alpha: 0.97),
          border: Border.all(color: accent, width: 2),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.5),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: IponColors.frameInner.withValues(alpha: 0.7),
                  ),
                ),
                child: Text(
                  title,
                  style: IponTypography.windowTitle
                      .copyWith(color: accent, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            for (final line in lines) ...[
              Text(
                line,
                style: IponTypography.body.copyWith(
                  color: IponColors.textPrimary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 12),
            SystemButton(
              label: buttonLabel,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

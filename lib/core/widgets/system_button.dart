import 'package:flutter/material.dart';
import '../theme/color_palette.dart';
import '../theme/typography.dart';

class SystemButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const SystemButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: enabled ? IponColors.frameOuter : IponColors.textDim,
            ),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: IponColors.frameOuter.withValues(alpha: 0.4),
                      blurRadius: 12,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: enabled
                  ? IponTypography.header
                  : IponTypography.header.copyWith(color: IponColors.textDim),
            ),
          ),
        ),
      ),
    );
  }
}

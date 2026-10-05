import 'package:flutter/material.dart';
import 'color_palette.dart';
import 'typography.dart';

class SystemWindowFrame extends StatelessWidget {
  final String title;
  final Widget child;

  const SystemWindowFrame({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: IponColors.bgIndigo.withValues(alpha: 0.5),
        border: Border.all(color: IponColors.frameOuter, width: 2),
        boxShadow: [
          BoxShadow(
            color: IponColors.frameOuter.withValues(alpha: 0.4),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: IponColors.panelFill,
            border: Border.all(
              color: IponColors.frameInner.withValues(alpha: 0.5),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: IponColors.frameInner, width: 1),
                  ),
                  child: Text(title, style: IponTypography.windowTitle),
                ),
              ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

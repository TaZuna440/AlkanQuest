import 'package:flutter/material.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/typography.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: IponColors.frameInner, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: IponColors.frameOuter.withValues(alpha: 0.4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Text('IPON SYSTEM',
                  style: IponTypography.windowTitle),
            ),
            const SizedBox(height: 32),
            const Text('INITIALIZING...', style: IponTypography.label),
          ],
        ),
      ),
    );
  }
}

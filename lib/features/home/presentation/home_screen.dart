import 'package:flutter/material.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SystemWindowFrame(
            title: 'STATUS',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'WELCOME BACK, HUNTER',
                  style: IponTypography.header,
                ),
                const SizedBox(height: 8),
                const Text(
                  '\u25C6 STREAK: 0 QUESTS CLEARED',
                  style: IponTypography.label,
                ),
                const SizedBox(height: 24),
                _buildEmptyQuestCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyQuestCard() {
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
          Container(
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
            child: const Center(
              child: Text('+ CREATE QUEST', style: IponTypography.header),
            ),
          ),
        ],
      ),
    );
  }
}

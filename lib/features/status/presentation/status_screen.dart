import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../domain/models/user_stats.dart';
import '../../../l10n/app_strings.dart';
import '../../../l10n/l10n_providers.dart';
import '../providers/status_providers.dart';

/// Phase 08 — Status: rank/level/XP deep view, aggregate stats, XP timeline.
class StatusScreen extends ConsumerWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(userStatsProvider);
    final timelineAsync = ref.watch(xpTimelineProvider);
    final locale = ref.watch(localeProvider);
    String t(String key) => AppStrings.of(key, locale);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SystemWindowFrame(
            title: t(AppStrings.statusTitle),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (stats == null)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child:
                          Text('LOADING...', style: IponTypography.label),
                    ),
                  )
                else ...[
                  _RankCard(stats: stats),
                  const SizedBox(height: 20),
                  Text(t(AppStrings.lifetimeStats),
                      style: IponTypography.label),
                  const SizedBox(height: 8),
                  _StatsGrid(stats: stats),
                  const SizedBox(height: 20),
                  Text(t(AppStrings.xpTimeline),
                      style: IponTypography.label),
                  const SizedBox(height: 8),
                  timelineAsync.when(
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text('LOADING...',
                            style: IponTypography.label),
                      ),
                    ),
                    error: (e, _) => Text('ERROR: $e',
                        style: IponTypography.body
                            .copyWith(color: IponColors.danger)),
                    data: (entries) => entries.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'NO XP YET. LOG YOUR FIRST CHECK-IN TO BEGIN.',
                              style: IponTypography.body,
                            ),
                          )
                        : Column(
                            children: [
                              for (final e in entries) ...[
                                _TimelineRow(entry: e),
                                const SizedBox(height: 6),
                              ],
                            ],
                          ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RankCard extends StatelessWidget {
  final UserStats stats;
  const _RankCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final barValue = stats.bandSize < 0
        ? 1.0
        : (stats.xpIntoBand / stats.bandSize).clamp(0.0, 1.0);
    final progressText = stats.bandSize < 0
        ? '${_fmt(stats.xpIntoBand)} XP BEYOND RANK S'
        : '${_fmt(stats.xpIntoBand)} / ${_fmt(stats.bandSize)} XP'
            '${stats.xpToNextRank == null ? '' : ' — ${_fmt(stats.xpToNextRank!)} TO RANK ${_nextRank()}'}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: IponColors.gold, width: 2),
        boxShadow: [
          BoxShadow(
            color: IponColors.gold.withValues(alpha: 0.3),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'RANK ${stats.rank}',
            style: IponTypography.windowTitle
                .copyWith(color: IponColors.gold, fontSize: 28),
          ),
          const SizedBox(height: 4),
          Text(
            stats.rankTitle.toUpperCase(),
            style: IponTypography.header
                .copyWith(color: IponColors.textSecondary),
          ),
          const SizedBox(height: 12),
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: IponColors.bgPlum,
              border: Border.all(
                color: IponColors.frameInner.withValues(alpha: 0.25),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: barValue,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [IponColors.frameOuter, IponColors.gold],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'LV ${stats.level} · ${_fmt(stats.totalXp)} XP',
            style: IponTypography.value.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            progressText,
            style: IponTypography.label
                .copyWith(fontSize: 10, color: IponColors.textDim),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _nextRank() {
    const order = ['E', 'D', 'C', 'B', 'A', 'S'];
    final idx = order.indexOf(stats.rank);
    if (idx < 0 || idx >= order.length - 1) return '';
    return order[idx + 1];
  }

  String _fmt(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _StatsGrid extends StatelessWidget {
  final UserStats stats;
  const _StatsGrid({required this.stats});

  @override
  Widget build(BuildContext context) {
    final cells = <(String, String)>[
      ('TOTAL SAVED', MoneyFormatter.format(stats.totalSavedCents)),
      ('CHECK-INS', '${stats.totalCheckins}'),
      ('ACTIVE QUESTS', '${stats.activeQuests}'),
      ('COMPLETED', '${stats.completedQuests}'),
      ('CANCELLED', '${stats.cancelledQuests}'),
      (
        'DAILY STREAK',
        '${stats.dailyStreak} ${stats.dailyStreak == 1 ? 'DAY' : 'DAYS'}'
      ),
      ('LONGEST DAILY', '${stats.longestDailyStreak} DAYS'),
      ('CLEARED IN A ROW', '${stats.clearedInARow}'),
      ('LONGEST CLEARED', '${stats.longestClearedStreak}'),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.05,
      ),
      itemCount: cells.length,
      itemBuilder: (_, i) {
        final (label, value) = cells[i];
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: IponColors.frameInner.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: IponTypography.value.copyWith(fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: IponTypography.label
                    .copyWith(fontSize: 8, color: IponColors.textDim),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final XpTimelineEntry entry;
  const _TimelineRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (entry.kind) {
      XpEventKind.checkin => (Icons.add_circle_outline, IponColors.success),
      XpEventKind.completion =>
        (Icons.emoji_events_outlined, IponColors.gold),
      XpEventKind.achievement => (Icons.star_outline, IponColors.frameOuter),
    };
    final dateFmt = DateFormat('MMM d, yyyy');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: IponColors.frameInner.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.label,
                  style: IponTypography.value.copyWith(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  dateFmt.format(entry.date),
                  style: IponTypography.label
                      .copyWith(fontSize: 9, color: IponColors.textDim),
                ),
              ],
            ),
          ),
          Text(
            '+${entry.xp} XP',
            style:
                IponTypography.value.copyWith(color: color, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

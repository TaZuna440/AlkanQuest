import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../core/utils/savings_calculator.dart';
import '../../../core/widgets/challenge_icon.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/services/streak_service.dart';
import '../../../domain/services/xp_service.dart';
import '../../../l10n/app_strings.dart';
import '../../../l10n/l10n_providers.dart';
import '../../challenges/presentation/challenge_detail_screen.dart';
import '../../challenges/presentation/create_challenge_screen.dart';
import '../../challenges/providers/challenge_providers.dart';
import '../../checkin/presentation/checkin_screen.dart';

/// Phase 06 dashboard (+ Phase 11 localization): the System "Status Window"
/// with live data — XP, level, rank, streaks, and active quest cards with
/// progress, suggested per-period amounts, and remaining amounts.
class DashboardTab extends ConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final challengesAsync = ref.watch(activeChallengesProvider);
    final recordsAsync = ref.watch(allRecordsProvider);
    final locale = ref.watch(localeProvider);
    String t(String key) => AppStrings.of(key, locale);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SystemWindowFrame(
            title: t(AppStrings.navDashboard),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _StatusHeader(
                  profileAsync: profileAsync,
                  recordsAsync: recordsAsync,
                  locale: locale,
                ),
                const SizedBox(height: 24),
                Text(t(AppStrings.dashboardActiveQuests),
                    style: IponTypography.label),
                const SizedBox(height: 12),
                challengesAsync.when(
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text('LOADING...', style: IponTypography.label),
                    ),
                  ),
                  error: (e, _) => Text('ERROR: $e',
                      style: IponTypography.body
                          .copyWith(color: IponColors.danger)),
                  data: (challenges) {
                    if (challenges.isEmpty) {
                      return _EmptyQuestCard(
                        onCreate: () => _openCreate(context),
                        locale: locale,
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final c in challenges) ...[
                          _QuestCard(challenge: c, locale: locale),
                          const SizedBox(height: 12),
                        ],
                        const SizedBox(height: 8),
                        _CreateButton(
                          label: t(AppStrings.logSavings),
                          onTap: () =>
                              _openCheckin(context, challenges, locale),
                        ),
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

  Future<void> _openCreate(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CreateChallengeScreen()),
    );
  }

  Future<void> _openCheckin(
    BuildContext context,
    List<Challenge> challenges,
    String locale,
  ) async {
    final challenge = challenges.length == 1
        ? challenges.single
        : await showDialog<Challenge>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              backgroundColor: IponColors.bgIndigo,
              title: Text(
                AppStrings.of(AppStrings.selectQuest, locale),
                style: IponTypography.header,
              ),
              content: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 360),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final quest in challenges)
                        ListTile(
                          title: Text(quest.name, style: IponTypography.body),
                          onTap: () => Navigator.of(dialogContext).pop(quest),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );

    if (challenge == null || !context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CheckinScreen(challenge: challenge)),
    );
  }
}

/// Player header: name, level, rank, XP-to-next-rank bar, totals, streaks.
class _StatusHeader extends StatelessWidget {
  final AsyncValue<UserProfile?> profileAsync;
  final AsyncValue<List<SavingsRecord>> recordsAsync;
  final String locale;

  const _StatusHeader({
    required this.profileAsync,
    required this.recordsAsync,
    required this.locale,
  });

  String _t(String key) => AppStrings.of(key, locale);

  @override
  Widget build(BuildContext context) {
    final profile = profileAsync.value;
    final records = recordsAsync.value ?? const <SavingsRecord>[];

    final name = profile?.displayName ?? 'HUNTER';
    final totalXp = profile?.totalXp ?? 0;
    final level = profile?.level ?? XpService.levelFor(totalXp);
    final band = XpService.rankFor(totalXp);
    final progress = XpService.rankProgress(totalXp);
    final xpToNext = XpService.xpToNextRank(totalXp);
    final barValue = progress.bandSize < 0
        ? 1.0
        : (progress.intoBand / progress.bandSize).clamp(0.0, 1.0);

    final totalSaved = records.fold<int>(0, (s, r) => s + r.amountCents);
    final dailyStreak = StreakService.dailySaverStreak(
      checkinDates: records.map((r) => r.date),
    );
    final clearedInARow = profile?.currentStreak ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${_t(AppStrings.welcomeBack)}, $name',
            style: IponTypography.header),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: IponColors.gold, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: IponColors.gold.withValues(alpha: 0.35),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Text(
                'RANK ${band.rank}',
                style: IponTypography.header.copyWith(color: IponColors.gold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LV $level \u2014 ${band.title.toUpperCase()}',
                      style: IponTypography.value.copyWith(fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(
                    xpToNext == null
                        ? 'MAX RANK REACHED'
                        : '$xpToNext XP TO RANK ${_nextRank(band)}',
                    style: IponTypography.label.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _XpBar(value: barValue),
        const SizedBox(height: 6),
        Text(
          '${_fmtNum(totalXp)} XP',
          style: IponTypography.label
              .copyWith(fontSize: 11, color: IponColors.textSecondary),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _StatBox(
                label: _t(AppStrings.totalSaved),
                value: MoneyFormatter.format(totalSaved),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatBox(
                label: _t(AppStrings.dailyStreak),
                value: '$dailyStreak',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatBox(
                label: _t(AppStrings.questsCleared),
                value: '$clearedInARow',
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _nextRank(RankBand band) {
    final idx = XpService.ranks.indexOf(band);
    if (idx < 0 || idx >= XpService.ranks.length - 1) return '';
    return XpService.ranks[idx + 1].rank;
  }

  String _fmtNum(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _XpBar extends StatelessWidget {
  final double value;
  const _XpBar({required this.value});

  @override
  Widget build(BuildContext context) {
    final isEmpty = value <= 0;
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: IponColors.bgPlum,
        border: Border.all(
          color: isEmpty
              ? IponColors.frameOuter.withValues(alpha: 0.65)
              : IponColors.frameInner.withValues(alpha: 0.25),
        ),
        boxShadow: isEmpty
            ? [
                BoxShadow(
                  color: IponColors.frameOuter.withValues(alpha: 0.2),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: value.clamp(0.0, 1.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [IponColors.frameOuter, IponColors.gold],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: IponColors.frameInner.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
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
                .copyWith(fontSize: 9, color: IponColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// One active quest: progress, amounts, suggested per-period, streak.
class _QuestCard extends ConsumerWidget {
  final Challenge challenge;
  final String locale;
  const _QuestCard({required this.challenge, required this.locale});

  String _t(String key) => AppStrings.of(key, locale);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetCents = challenge.targetAmountCents;
    final currentCents = challenge.currentAmountCents;
    final progress = targetCents == 0
        ? 0.0
        : (currentCents / targetCents).clamp(0.0, 1.0);
    final percent = (progress * 100).round();
    final remaining = (targetCents - currentCents).clamp(0, targetCents);
    final color = _parseHex(challenge.colorHex);

    final recordsAsync = ref.watch(challengeRecordsProvider(challenge.id));
    final streak = recordsAsync.maybeWhen(
      data: (records) => StreakService.questStreak(
        frequency: challenge.frequency,
        checkinDates: records.map((r) => r.date),
      ),
      orElse: () => 0,
    );

    final plan = SavingsCalculator.compute(
      targetCents: targetCents,
      startingCents: currentCents,
      targetDate: challenge.targetDate,
      frequency: challenge.frequency,
    );
    final suggested = plan == null
        ? null
        : SavingsCalculator.roundUpPerPeriod(
            plan.requiredPerPeriodCents, challenge.frequency);

    return InkWell(
      onTap: () => _openDetail(context),
      child: Container(
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
                if (streak > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: IponColors.warning),
                    ),
                    child: Text(
                      '\uD83D\uDD25 $streak',
                      style: IponTypography.label.copyWith(
                        color: IponColors.warning,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _ProgressBar(progress: progress, color: color),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${MoneyFormatter.format(currentCents)} / ${MoneyFormatter.format(targetCents)}',
                  style: IponTypography.value.copyWith(fontSize: 14),
                ),
                Text('$percent%',
                    style:
                        IponTypography.value.copyWith(color: color, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
                '${MoneyFormatter.format(remaining)} ${_t(AppStrings.remaining)}',
                style: IponTypography.label.copyWith(fontSize: 11)),
            if (suggested != null && suggested > 0) ...[
              const SizedBox(height: 4),
              Text(
                '${_t(AppStrings.suggested)}: ${MoneyFormatter.format(suggested)} / ${_periodLabel(challenge.frequency)}',
                style: IponTypography.label.copyWith(
                  fontSize: 11,
                  color: IponColors.success,
                ),
              ),
            ],
            const SizedBox(height: 14),
            _CheckinButton(
              label: _t(AppStrings.iSavedIt),
              color: color,
              onTap: () => _openCheckin(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openDetail(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChallengeDetailScreen(challengeId: challenge.id),
      ),
    );
  }

  Future<void> _openCheckin(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CheckinScreen(challenge: challenge)),
    );
  }

  String _periodLabel(String frequency) => switch (frequency) {
        'daily' => 'DAY',
        'weekly' => 'WEEK',
        'monthly' => 'MONTH',
        _ => 'DAY',
      };

  Color _parseHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  final Color color;
  const _ProgressBar({required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final filled = constraints.maxWidth * progress.clamp(0.0, 1.0);
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
}

class _CheckinButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _CheckinButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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
              label,
              style: IponTypography.header.copyWith(color: color),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyQuestCard extends StatelessWidget {
  final VoidCallback onCreate;
  final String locale;
  const _EmptyQuestCard({required this.onCreate, required this.locale});

  String _t(String key) => AppStrings.of(key, locale);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: IponColors.frameOuter.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_t(AppStrings.dashboardNoQuests),
              style: IponTypography.header),
          const SizedBox(height: 12),
          Text(
            _t(AppStrings.dashboardNoQuestsBody),
            style: IponTypography.body,
          ),
          const SizedBox(height: 16),
          _CreateButton(label: _t(AppStrings.createQuest), onTap: onCreate),
        ],
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _CreateButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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

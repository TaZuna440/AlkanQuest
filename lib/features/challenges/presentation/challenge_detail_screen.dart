import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/providers/progression_providers.dart';
import '../../../core/providers/repository_providers.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../core/utils/savings_calculator.dart';
import '../../../core/widgets/challenge_icon.dart';
import '../../../core/widgets/image_ref_view.dart';
import '../../../core/widgets/system_button.dart';
import '../../../core/widgets/system_confirm_dialog.dart';
import '../../../core/widgets/system_notice_dialog.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/services/streak_service.dart';
import '../../../l10n/app_strings.dart';
import '../../../l10n/l10n_providers.dart';
import '../../../l10n/system_voice.dart';
import '../../checkin/presentation/checkin_screen.dart';
import '../providers/challenge_providers.dart';
import 'edit_challenge_screen.dart';

/// Phase 07 — Quest detail: progress, stats, check-in history, and
/// quest management (edit / cancel / delete).
///
/// Spec guardrails: cancelled quests keep their records (B3); completed
/// quests cannot be reopened and cancelled quests cannot be reactivated
/// (B4/B5) — so management actions only exist while active.
class ChallengeDetailScreen extends ConsumerWidget {
  final String challengeId;
  const ChallengeDetailScreen({super.key, required this.challengeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengeAsync = ref.watch(challengeByIdProvider(challengeId));

    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: IponColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: challengeAsync.when(
          loading: () => const Center(
            child: Text('LOADING...', style: IponTypography.label),
          ),
          error: (e, _) => Center(
            child: Text('ERROR: $e',
                style: IponTypography.body.copyWith(color: IponColors.danger)),
          ),
          data: (challenge) {
            if (challenge == null) {
              return const Center(
                child: Text('QUEST NOT FOUND.', style: IponTypography.label),
              );
            }
            return _DetailBody(challenge: challenge);
          },
        ),
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  final Challenge challenge;
  const _DetailBody({required this.challenge});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(challengeRecordsProvider(challenge.id));
    final locale = ref.watch(localeProvider);
    final dramatic = ref.watch(systemVoiceProvider);
    String t(String key) => AppStrings.of(key, locale);
    final color = _parseHex(challenge.colorHex);
    final isActive = challenge.status == 'active';

    final targetCents = challenge.targetAmountCents;
    final currentCents = challenge.currentAmountCents;
    final progress = targetCents == 0
        ? 0.0
        : (currentCents / targetCents).clamp(0.0, 1.0);
    final percent = (progress * 100).round();
    final remaining = (targetCents - currentCents).clamp(0, targetCents);

    final now = DateTime.now();
    final daysLeft = SavingsCalculator.daysUntil(challenge.targetDate, now: now);
    final overdue = isActive && daysLeft <= 0 && remaining > 0;

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
        ? 0
        : SavingsCalculator.roundUpPerPeriod(
            plan.requiredPerPeriodCents, challenge.frequency);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SingleChildScrollView(
        child: SystemWindowFrame(
          title: t(AppStrings.questDetail),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(color, overdue),
              const SizedBox(height: 16),
              _progressSection(color, progress, percent),
              const SizedBox(height: 16),
              _statGrid(
                currentCents: currentCents,
                targetCents: targetCents,
                remaining: remaining,
                suggested: suggested,
                streak: streak,
                daysLeft: daysLeft,
                overdue: overdue,
              ),
              const SizedBox(height: 20),
              Text(t(AppStrings.checkinHistory),
                  style: IponTypography.label),
              const SizedBox(height: 8),
              recordsAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                      child: Text('LOADING...', style: IponTypography.label)),
                ),
                error: (e, _) => Text('ERROR: $e',
                    style: IponTypography.body
                        .copyWith(color: IponColors.danger)),
                data: (records) => records.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('NO CHECK-INS YET.',
                            style: IponTypography.body),
                      )
                    : Column(
                        children: [
                          for (final r in records) ...[
                            _HistoryRow(record: r),
                            const SizedBox(height: 8),
                          ],
                        ],
                      ),
              ),
              const SizedBox(height: 20),
              _actions(context, ref, isActive, t, dramatic: dramatic, locale: locale),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(Color color, bool overdue) {
    return Row(
      children: [
        ChallengeIcon(iconPath: challenge.iconPath, color: color, size: 48),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('\u25C6 ${challenge.name}', style: IponTypography.header),
              const SizedBox(height: 6),
              Row(
                children: [
                  _StatusBadge(status: challenge.status),
                  if (overdue) ...[
                    const SizedBox(width: 8),
                    _StatusBadge(status: 'OVERDUE', danger: true),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _progressSection(Color color, double progress, int percent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, IponColors.textPrimary],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${MoneyFormatter.format(challenge.currentAmountCents)} / ${MoneyFormatter.format(challenge.targetAmountCents)}',
              style: IponTypography.value.copyWith(fontSize: 14),
            ),
            Text('$percent%',
                style: IponTypography.value
                    .copyWith(color: color, fontSize: 14)),
          ],
        ),
        if (challenge.description != null &&
            challenge.description!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(challenge.description!, style: IponTypography.body),
        ],
      ],
    );
  }

  Widget _statGrid({
    required int currentCents,
    required int targetCents,
    required int remaining,
    required int suggested,
    required int streak,
    required int daysLeft,
    required bool overdue,
  }) {
    final dateFmt = DateFormat('MMM d, yyyy');
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _miniStat('REMAINING', MoneyFormatter.format(remaining)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _miniStat(
                'SUGGESTED / ${_periodLabel(challenge.frequency)}',
                suggested > 0 ? MoneyFormatter.format(suggested) : '—',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _miniStat('STREAK',
                  '$streak ${_periodWord(challenge.frequency, streak)}'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _miniStat(
                'TARGET DATE',
                dateFmt.format(challenge.targetDate.toLocal()),
                sub: overdue
                    ? 'OVERDUE'
                    : daysLeft > 0
                        ? '$daysLeft ${daysLeft == 1 ? 'DAY' : 'DAYS'} LEFT'
                        : 'DUE TODAY',
                subDanger: overdue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _miniStat(String label, String value, {String? sub, bool subDanger = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: IponColors.frameInner.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: IponTypography.value.copyWith(fontSize: 14)),
          const SizedBox(height: 2),
          Text(label,
              style: IponTypography.label
                  .copyWith(fontSize: 9, color: IponColors.textDim)),
          if (sub != null) ...[
            const SizedBox(height: 2),
            Text(
              sub,
              style: IponTypography.label.copyWith(
                fontSize: 9,
                color: subDanger ? IponColors.danger : IponColors.warning,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _actions(
    BuildContext context,
    WidgetRef ref,
    bool isActive,
    String Function(String) t, {
    required bool dramatic,
    required String locale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isActive) ...[
          SystemButton(
            label: t(AppStrings.iSavedIt),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CheckinScreen(challenge: challenge),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SystemButton(
            label: t(AppStrings.editQuest),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditChallengeScreen(challenge: challenge),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SystemButton(
            label: t(AppStrings.cancelQuest),
            onPressed: () => _confirmCancel(context, ref,
                dramatic: dramatic, locale: locale),
          ),
          const SizedBox(height: 12),
        ],
        SystemButton(
          label: t(AppStrings.deleteQuest),
          onPressed: () => _confirmDelete(context, ref),
        ),
        if (!isActive) ...[
          const SizedBox(height: 12),
          Text(
            challenge.status == 'completed'
                ? 'CLEARED QUESTS STAY IN HISTORY FOREVER.'
                : 'CANCELLED QUESTS KEEP THEIR RECORDS.',
            style: IponTypography.label
                .copyWith(fontSize: 10, color: IponColors.textDim),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Future<void> _confirmCancel(
    BuildContext context,
    WidgetRef ref, {
    required bool dramatic,
    required String locale,
  }) async {
    final yes = await SystemConfirmDialog.show(
      context,
      title: SystemVoice.questCancelTitle(
          dramatic: dramatic, locale: locale),
      message: dramatic
          ? 'Abandon "${challenge.name}"?\n\nIts records stay in history, but your quests-cleared streak resets to 0.'
          : 'Cancel "${challenge.name}"? Its records stay in history, but your cleared streak resets to 0.',
      confirmLabel: dramatic ? 'ABANDON QUEST' : 'Cancel quest',
      accent: IponColors.danger,
    );
    if (!yes || !context.mounted) return;
    try {
      await ref.read(progressionServiceProvider).cancelChallenge(challenge.id);
      if (!context.mounted) return;
      await SystemNoticeDialog.show(
        context,
        title: 'QUEST CANCELLED',
        lines: const [
          'THE SYSTEM HAS RECORDED YOUR DECISION.',
          'YOUR CLEARED-STREAK RESETS TO 0.',
        ],
        accent: IponColors.warning,
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e', style: IponTypography.label),
          backgroundColor: IponColors.danger,
        ),
      );
    }
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final yes = await SystemConfirmDialog.show(
      context,
      title: 'DELETE QUEST',
      message:
          'Permanently delete "${challenge.name}" and ALL its check-in records? This cannot be undone.',
      confirmLabel: 'DELETE FOREVER',
      accent: IponColors.danger,
    );
    if (!yes || !context.mounted) return;
    await ref.read(challengeRepositoryProvider).delete(challenge.id);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  String _periodLabel(String frequency) => switch (frequency) {
        'daily' => 'DAY',
        'weekly' => 'WEEK',
        'monthly' => 'MONTH',
        _ => 'DAY',
      };

  String _periodWord(String frequency, int n) {
    final one = n == 1;
    return switch (frequency) {
      'weekly' => one ? 'WEEK' : 'WEEKS',
      'monthly' => one ? 'MONTH' : 'MONTHS',
      _ => one ? 'DAY' : 'DAYS',
    };
  }

  Color _parseHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final bool danger;
  const _StatusBadge({required this.status, this.danger = false});

  @override
  Widget build(BuildContext context) {
    final color = danger
        ? IponColors.danger
        : switch (status) {
            'active' => IponColors.success,
            'completed' => IponColors.gold,
            'cancelled' => IponColors.textDim,
            _ => IponColors.textDim,
          };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(border: Border.all(color: color)),
      child: Text(
        status.toUpperCase(),
        style: IponTypography.label.copyWith(color: color, fontSize: 10),
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final SavingsRecord record;
  const _HistoryRow({required this.record});

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('MMM d, yyyy • h:mm a');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: IponColors.frameInner.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          if (record.proofPath != null && record.proofPath!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                onTap: () => _viewProof(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ImageRefView(
                    reference: record.proofPath,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MoneyFormatter.format(record.amountCents),
                  style: IponTypography.value.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  dateFmt.format(record.date.toLocal()),
                  style: IponTypography.label
                      .copyWith(fontSize: 10, color: IponColors.textDim),
                ),
                if (record.note != null && record.note!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    record.note!,
                    style: IponTypography.body.copyWith(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _viewProof(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: IponColors.bgIndigo,
            border: Border.all(color: IponColors.frameOuter, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageRefView(
                reference: record.proofPath,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              SystemButton(
                label: 'CLOSE',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

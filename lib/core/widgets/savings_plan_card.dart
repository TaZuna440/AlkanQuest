import 'package:flutter/material.dart';
import '../theme/color_palette.dart';
import '../theme/typography.dart';
import '../utils/money_formatter.dart';
import '../utils/savings_calculator.dart';

class SavingsPlanCard extends StatelessWidget {
  final SavingsPlan? plan;

  const SavingsPlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    if (plan == null) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: IponColors.frameInner.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.calculate_outlined,
                color: IponColors.textDim, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'SET AMOUNT + DATE TO SEE YOUR PLAN.',
                style: IponTypography.label.copyWith(color: IponColors.textDim),
              ),
            ),
          ],
        ),
      );
    }

    final p = plan!;
    final severity = p.severity;
    final color = switch (severity) {
      'impossible' => IponColors.danger,
      'high' => IponColors.warning,
      _ => IponColors.frameOuter,
    };

    final perPeriod = MoneyFormatter.format(
      SavingsCalculator.roundUpPerPeriod(
        p.requiredPerPeriodCents,
        p.frequency,
      ),
    );
    final remaining = MoneyFormatter.format(p.remainingCents);

    final headline = p.requiredPerPeriodCents == 0
        ? 'GOAL ALREADY MET'
        : 'SAVE $perPeriod / ${p.periodLabel}';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                severity == 'ok'
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_rounded,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  headline,
                  style: IponTypography.header.copyWith(color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(p.countLabel, style: IponTypography.label),
          const SizedBox(height: 4),
          Text('$remaining REMAINING',
              style: IponTypography.label
                  .copyWith(color: IponColors.textSecondary)),
          if (severity == 'high') ...[
            const SizedBox(height: 10),
            Text(
              '\u26A0 HIGH TARGET. CONSIDER EXTENDING THE DATE.',
              style: IponTypography.label.copyWith(
                color: IponColors.warning,
                fontSize: 11,
              ),
            ),
          ],
          if (severity == 'impossible') ...[
            const SizedBox(height: 10),
            Text(
              '\u26A0 UNREALISTIC. EXTEND THE DATE OR LOWER THE AMOUNT.',
              style: IponTypography.label.copyWith(
                color: IponColors.danger,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

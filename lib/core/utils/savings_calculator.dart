import 'dart:math' as math;

class SavingsPlan {
  final int remainingCents;
  final int periodsRemaining;
  final int requiredPerPeriodCents;
  final String frequency;
  final String periodLabel;
  final String countLabel;

  const SavingsPlan({
    required this.remainingCents,
    required this.periodsRemaining,
    required this.requiredPerPeriodCents,
    required this.frequency,
    required this.periodLabel,
    required this.countLabel,
  });

  String get severity {
    if (requiredPerPeriodCents <= 0) return 'ok';
    switch (frequency) {
      case 'daily':
        if (requiredPerPeriodCents > 500000) return 'impossible';
        if (requiredPerPeriodCents > 200000) return 'high';
        break;
      case 'weekly':
        if (requiredPerPeriodCents > 3500000) return 'impossible';
        if (requiredPerPeriodCents > 1000000) return 'high';
        break;
      case 'monthly':
        if (requiredPerPeriodCents > 15000000) return 'impossible';
        if (requiredPerPeriodCents > 4000000) return 'high';
        break;
      case 'flexible':
        return 'ok';
    }
    return 'ok';
  }
}

class SavingsCalculator {
  SavingsCalculator._();

  /// Minimum days a frequency needs to be meaningful.
  /// Daily: 1 day, Weekly: 7 days, Monthly: 30 days, Flexible: 1 day.
  static int minDaysFor(String frequency) {
    switch (frequency) {
      case 'daily':
        return 1;
      case 'weekly':
        return 7;
      case 'monthly':
        return 30;
      case 'flexible':
        return 1;
    }
    return 1;
  }

  /// Days between now and targetDate (whole days, ceiling).
  static int daysUntil(DateTime target, {DateTime? now}) {
    final ref = now ?? DateTime.now();
    final ms = target.difference(ref).inMilliseconds;
    return (ms / const Duration(days: 1).inMilliseconds).ceil();
  }

  /// True if frequency can be used given days remaining.
  static bool frequencyFits(String frequency, int daysRemaining) {
    if (frequency == 'flexible') return true;
    return daysRemaining >= minDaysFor(frequency);
  }

  /// Given a target date, pick the highest meaningful frequency that fits.
  /// Preference order when several fit: monthly > weekly > daily.
  static String bestFrequencyFor(int daysRemaining) {
    if (daysRemaining >= 30) return 'monthly';
    if (daysRemaining >= 7) return 'weekly';
    if (daysRemaining >= 1) return 'daily';
    return 'flexible';
  }

  static SavingsPlan? compute({
    required int targetCents,
    required int startingCents,
    required DateTime? targetDate,
    required String frequency,
    DateTime? now,
  }) {
    if (targetDate == null) return null;
    final ref = now ?? DateTime.now();
    final remaining = targetCents - startingCents;
    if (remaining <= 0) {
      return SavingsPlan(
        remainingCents: 0,
        periodsRemaining: 0,
        requiredPerPeriodCents: 0,
        frequency: frequency,
        periodLabel: _periodLabel(frequency),
        countLabel: 'GOAL ALREADY MET',
      );
    }

    final daysRemaining = daysUntil(targetDate, now: ref);
    if (daysRemaining <= 0) {
      return SavingsPlan(
        remainingCents: remaining,
        periodsRemaining: 0,
        requiredPerPeriodCents: remaining,
        frequency: frequency,
        periodLabel: _periodLabel(frequency),
        countLabel: 'TARGET DATE PASSED',
      );
    }

    int periods;
    String countLabel;
    switch (frequency) {
      case 'daily':
        periods = daysRemaining;
        countLabel = '$periods ${periods == 1 ? "DAY" : "DAYS"} REMAINING';
        break;
      case 'weekly':
        periods = (daysRemaining / 7).ceil();
        countLabel = '$periods ${periods == 1 ? "WEEK" : "WEEKS"} REMAINING';
        break;
      case 'monthly':
        periods = (daysRemaining / 30).ceil();
        countLabel = '$periods ${periods == 1 ? "MONTH" : "MONTHS"} REMAINING';
        break;
      case 'flexible':
      default:
        periods = daysRemaining;
        countLabel = '$periods DAYS REMAINING';
        break;
    }

    final required = (remaining / periods).ceil();

    return SavingsPlan(
      remainingCents: remaining,
      periodsRemaining: periods,
      requiredPerPeriodCents: required,
      frequency: frequency,
      periodLabel: _periodLabel(frequency),
      countLabel: countLabel,
    );
  }

  static DateTime? suggestTargetDate({
    required int targetCents,
    required int startingCents,
    required String frequency,
    int? perPeriodCents,
    DateTime? now,
  }) {
    final ref = now ?? DateTime.now();
    final remaining = targetCents - startingCents;
    if (remaining <= 0) return ref;

    final perPeriod = perPeriodCents ??
        (switch (frequency) {
          'daily' => 10000,
          'weekly' => 50000,
          'monthly' => 200000,
          _ => 10000,
        });

    if (perPeriod <= 0) return ref;

    final periods = (remaining / perPeriod).ceil();
    final days = switch (frequency) {
      'daily' => periods,
      'weekly' => periods * 7,
      'monthly' => periods * 30,
      _ => periods,
    };
    // Enforce minimum days for the chosen frequency
    final minDays = minDaysFor(frequency);
    final finalDays = math.max(days, minDays);
    return ref.add(Duration(days: finalDays));
  }

  /// Rounding rule per spec A5: round the suggested per-period amount UP to
  /// the nearest ₱10 (daily/flexible), ₱50 (weekly), or ₱100 (monthly).
  /// Input and output are integer centavos.
  static int roundUpPerPeriod(int cents, String frequency) {
    if (cents <= 0) return 0;
    final step = switch (frequency) {
      'weekly' => 5000, // ₱50
      'monthly' => 10000, // ₱100
      _ => 1000, // ₱10 — daily & flexible
    };
    return ((cents + step - 1) ~/ step) * step;
  }

  static String _periodLabel(String frequency) {
    switch (frequency) {
      case 'daily':
        return 'DAY';
      case 'weekly':
        return 'WEEK';
      case 'monthly':
        return 'MONTH';
      case 'flexible':
        return 'DAY';
    }
    return 'DAY';
  }
}

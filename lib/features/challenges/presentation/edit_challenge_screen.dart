import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../core/utils/savings_calculator.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/system_button.dart';
import '../../../core/widgets/system_notice_dialog.dart';
import '../../../data/database/app_database.dart';
import '../../../l10n/app_strings.dart';
import '../../../l10n/l10n_providers.dart';

const _frequencies = ['daily', 'weekly', 'monthly', 'flexible'];

/// Phase 07 — Edit an active quest.
///
/// Editable: name, notes, target amount, target date, frequency.
/// Spec C7: editing the target recalculates progress/suggestions automatically
/// (they are derived from records). Spec C8: a past target date is allowed
/// but the detail screen flags the quest OVERDUE.
class EditChallengeScreen extends ConsumerStatefulWidget {
  final Challenge challenge;
  const EditChallengeScreen({super.key, required this.challenge});

  @override
  ConsumerState<EditChallengeScreen> createState() =>
      _EditChallengeScreenState();
}

class _EditChallengeScreenState extends ConsumerState<EditChallengeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _targetController;

  late DateTime _targetDate;
  late String _frequency;
  bool _saving = false;

  Challenge get c => widget.challenge;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: c.name);
    _descController = TextEditingController(text: c.description ?? '');
    _targetController = TextEditingController(
      text: MoneyFormatter.format(c.targetAmountCents).replaceFirst('₱', ''),
    );
    _targetDate = c.targetDate.toLocal();
    _frequency = c.frequency;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final todayDay = DateTime(today.year, today.month, today.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate.isBefore(todayDay) ? todayDay : _targetDate,
      firstDate: todayDay,
      lastDate: todayDay.add(const Duration(days: 365 * 50)),
      helpText: 'SELECT END DATE',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: IponColors.frameOuter,
              onPrimary: IponColors.textPrimary,
              surface: IponColors.bgIndigo,
              onSurface: IponColors.textPrimary,
            ),
            dialogTheme:
                const DialogThemeData(backgroundColor: IponColors.bgIndigo),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _targetDate = picked;
        // Auto-correct frequency if it no longer fits the new date.
        final days = SavingsCalculator.daysUntil(picked);
        if (!SavingsCalculator.frequencyFits(_frequency, days)) {
          _frequency = SavingsCalculator.bestFrequencyFor(days);
        }
      });
    }
  }

  String? _validateTarget(String? value) {
    final err = IponValidators.validateTargetAmount(value);
    if (err != null) return err;
    final cents = MoneyFormatter.parseToCents(value!)!;
    if (cents < c.currentAmountCents) {
      return 'TARGET CANNOT BE BELOW WHAT IS ALREADY SAVED '
          '(${MoneyFormatter.format(c.currentAmountCents)}).';
    }
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final targetCents = MoneyFormatter.parseToCents(_targetController.text)!;
    final updated = c.copyWith(
      name: _nameController.text.trim(),
      description: Value(_descController.text.trim().isEmpty
          ? null
          : _descController.text.trim()),
      targetAmountCents: targetCents,
      targetDate: DateTime(
        _targetDate.year,
        _targetDate.month,
        _targetDate.day,
      ).toUtc(),
      frequency: _frequency,
    );
    await ref.read(challengeRepositoryProvider).update(updated);

    if (!mounted) return;
    await SystemNoticeDialog.show(
      context,
      title: 'QUEST UPDATED',
      lines: const ['THE SYSTEM HAS RECORDED THE CHANGES.'],
      accent: IponColors.success,
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('MMM d, yyyy');
    final locale = ref.watch(localeProvider);
    String t(String key) => AppStrings.of(key, locale);
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SingleChildScrollView(
            child: SystemWindowFrame(
              title: t(AppStrings.editQuestTitle),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _label('QUEST NAME'),
                    const SizedBox(height: 8),
                    _textField(
                      controller: _nameController,
                      maxLength: 40,
                      validator: IponValidators.validateChallengeName,
                    ),
                    const SizedBox(height: 16),
                    _label('NOTES (OPTIONAL)'),
                    const SizedBox(height: 8),
                    _textField(
                      controller: _descController,
                      maxLength: 200,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    _label('TARGET AMOUNT'),
                    const SizedBox(height: 8),
                    _textField(
                      controller: _targetController,
                      keyboardType: TextInputType.number,
                      prefix: '₱ ',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9.,]')),
                      ],
                      validator: _validateTarget,
                    ),
                    const SizedBox(height: 16),
                    _label('TARGET DATE'),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: IponColors.frameInner
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined,
                                color: IponColors.frameOuter),
                            const SizedBox(width: 12),
                            Text(
                              dateFmt.format(_targetDate),
                              style: IponTypography.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _label('FREQUENCY'),
                    const SizedBox(height: 8),
                    _frequencySelector(),
                    const SizedBox(height: 24),
                    SystemButton(
                      label: _saving ? 'SAVING...' : t(AppStrings.saveChanges),
                      onPressed: _saving ? null : _save,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text, style: IponTypography.label);

  Widget _textField({
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? prefix,
    int? maxLength,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: IponTypography.value,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: IponColors.frameOuter,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        prefixText: prefix,
        prefixStyle: IponTypography.value,
        counterStyle: IponTypography.label
            .copyWith(fontSize: 10, color: IponColors.textDim),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: IponColors.frameInner.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: IponColors.frameOuter),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: IponColors.danger),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: IponColors.danger),
        ),
        errorStyle:
            IponTypography.label.copyWith(color: IponColors.danger),
      ),
    );
  }

  Widget _frequencySelector() {
    final days = SavingsCalculator.daysUntil(_targetDate);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _frequencies.map((f) {
        final selected = _frequency == f;
        final enabled = SavingsCalculator.frequencyFits(f, days);
        return InkWell(
          onTap:
              enabled ? () => setState(() => _frequency = f) : null,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: selected
                    ? IponColors.frameOuter
                    : IponColors.frameInner.withValues(alpha: 0.4),
                width: selected ? 2 : 1,
              ),
            ),
            child: Text(
              f.toUpperCase(),
              style: IponTypography.label.copyWith(
                color: !enabled
                    ? IponColors.textDim.withValues(alpha: 0.4)
                    : selected
                        ? IponColors.textPrimary
                        : IponColors.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

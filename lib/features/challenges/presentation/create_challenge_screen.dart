import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../core/utils/savings_calculator.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/savings_plan_card.dart';
import '../../../core/widgets/system_button.dart';

const _colorSwatches = [
  '#B026FF',
  '#7C3AED',
  '#39FF88',
  '#FFD24A',
  '#00E5FF',
  '#FF3B4E',
  '#FF8A3D',
  '#E0D4F5',
];

const _frequencies = ['daily', 'weekly', 'monthly', 'flexible'];

class CreateChallengeScreen extends ConsumerStatefulWidget {
  const CreateChallengeScreen({super.key});

  @override
  ConsumerState<CreateChallengeScreen> createState() =>
      _CreateChallengeScreenState();
}

class _CreateChallengeScreenState
    extends ConsumerState<CreateChallengeScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _targetController = TextEditingController();
  final _startingController = TextEditingController();

  DateTime? _targetDate;
  String _frequency = 'daily';
  String _colorHex = '#B026FF';
  String? _iconPath;
  bool _saving = false;
  bool _pickingImage = false;

  String? _nameError;
  String? _targetError;
  String? _startingError;
  String? _dateError;

  bool _touchedName = false;
  bool _touchedTarget = false;
  bool _touchedStarting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _targetController.dispose();
    _startingController.dispose();
    super.dispose();
  }

  int get _targetCents =>
      MoneyFormatter.parseToCents(_targetController.text) ?? 0;
  int get _startingCents =>
      MoneyFormatter.parseToCents(_startingController.text) ?? 0;

  int get _daysRemaining => _targetDate == null
      ? 0
      : SavingsCalculator.daysUntil(_targetDate!);

  bool _frequencyEnabled(String f) {
    if (_targetDate == null) return true; // no date yet, allow any
    return SavingsCalculator.frequencyFits(f, _daysRemaining);
  }

  SavingsPlan? get _plan => SavingsCalculator.compute(
        targetCents: _targetCents,
        startingCents: _startingCents,
        targetDate: _targetDate,
        frequency: _frequency,
      );

  bool get _canSave {
    if (IponValidators.validateChallengeName(_nameController.text) != null) {
      return false;
    }
    if (IponValidators.validateTargetAmount(_targetController.text) != null) {
      return false;
    }
    if (_targetDate == null) return false;
    if (!_frequencyEnabled(_frequency)) return false;
    if (IponValidators.validateStartingAmount(
          _startingController.text,
          _targetCents,
        ) !=
        null) {
      return false;
    }
    return true;
  }

  void _onNameChanged(String _) {
    setState(() {
      if (_touchedName || _nameController.text.isNotEmpty) {
        _nameError =
            IponValidators.validateChallengeName(_nameController.text);
      }
    });
  }

  void _onTargetChanged(String _) {
    setState(() {
      if (_touchedTarget || _targetController.text.isNotEmpty) {
        _targetError =
            IponValidators.validateTargetAmount(_targetController.text);
      }
      if (_touchedStarting || _startingController.text.isNotEmpty) {
        _startingError = IponValidators.validateStartingAmount(
          _startingController.text,
          _targetCents,
        );
      }
    });
  }

  void _onStartingChanged(String _) {
    setState(() {
      if (_touchedStarting || _startingController.text.isNotEmpty) {
        _startingError = IponValidators.validateStartingAmount(
          _startingController.text,
          _targetCents,
        );
      }
    });
  }

  /// When the user picks a new date, auto-correct the frequency to
  /// the highest that fits.
  void _reconcileFrequency() {
    if (_targetDate == null) return;
    final days = SavingsCalculator.daysUntil(_targetDate!);
    if (!SavingsCalculator.frequencyFits(_frequency, days)) {
      _frequency = SavingsCalculator.bestFrequencyFor(days);
    }
  }

  void _suggestDate() {
    if (_targetCents <= 0) return;
    final suggested = SavingsCalculator.suggestTargetDate(
      targetCents: _targetCents,
      startingCents: _startingCents,
      frequency: _frequency,
    );
    if (suggested == null) return;
    setState(() {
      _targetDate = suggested;
      _dateError = null;
    });
  }

  Future<void> _pickIcon() async {
    if (_pickingImage) return;
    setState(() => _pickingImage = true);
    try {
      final path = await ImagePickerHelper.pickAndSaveChallengeIcon();
      if (path != null && mounted) {
        setState(() => _iconPath = path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('COULD NOT LOAD IMAGE: $e',
                style: IponTypography.label),
            backgroundColor: IponColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _pickingImage = false);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    // Normalize 'now' to midnight to avoid time-of-day partial disabling.
    final today = DateTime(now.year, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? today.add(const Duration(days: 30)),
      firstDate: today,
      lastDate: today.add(const Duration(days: 365 * 50)),
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
            datePickerTheme: DatePickerThemeData(
              // Make disabled (past) days almost invisible
              backgroundColor: IponColors.bgIndigo,
              surfaceTintColor: Colors.transparent,
              headerBackgroundColor: IponColors.bgIndigo,
              headerForegroundColor: IponColors.textPrimary,
              // Selected day styling
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return IponColors.bgVoid.withValues(alpha: 0.4);
                }
                if (states.contains(WidgetState.selected)) {
                  return IponColors.textPrimary;
                }
                return IponColors.textSecondary;
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return IponColors.frameOuter;
                }
                return null;
              }),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _targetDate = picked;
        _dateError = null;
        _reconcileFrequency();
      });
    }
  }

  Future<void> _save() async {
    setState(() {
      _touchedName = true;
      _touchedTarget = true;
      _touchedStarting = true;
      _nameError =
          IponValidators.validateChallengeName(_nameController.text);
      _targetError =
          IponValidators.validateTargetAmount(_targetController.text);
      _dateError = IponValidators.validateTargetDate(_targetDate);
      _startingError = IponValidators.validateStartingAmount(
        _startingController.text,
        _targetCents,
      );
    });

    if (!_canSave) return;

    setState(() => _saving = true);

    final repo = ref.read(challengeRepositoryProvider);
    final desc = _descController.text.trim();

    await repo.create(
      name: _nameController.text.trim(),
      description: desc.isEmpty ? null : desc,
      targetAmountCents: _targetCents,
      startingAmountCents: _startingCents,
      targetDate: _targetDate!,
      frequency: _frequency,
      colorHex: _colorHex,
      iconPath: _iconPath,
    );

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: SystemWindowFrame(
              title: 'NEW QUEST',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _label('QUEST ICON'),
                  const SizedBox(height: 12),
                  _iconUploader(),
                  const SizedBox(height: 20),
                  _label('QUEST NAME'),
                  const SizedBox(height: 8),
                  _textField(
                    controller: _nameController,
                    hint: 'EMERGENCY FUND',
                    errorText: _nameError,
                    maxLength: 40,
                    onChanged: _onNameChanged,
                  ),
                  const SizedBox(height: 16),
                  _label('DESCRIPTION (OPTIONAL)'),
                  const SizedBox(height: 8),
                  _textField(
                    controller: _descController,
                    hint: '6 MONTHS OF EXPENSES',
                    maxLength: 200,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  _label('TARGET AMOUNT'),
                  const SizedBox(height: 8),
                  _textField(
                    controller: _targetController,
                    hint: '10000',
                    prefix: '₱ ',
                    errorText: _targetError,
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    onChanged: _onTargetChanged,
                  ),
                  const SizedBox(height: 16),
                  _label('STARTING AMOUNT (OPTIONAL)'),
                  const SizedBox(height: 8),
                  _textField(
                    controller: _startingController,
                    hint: '0',
                    prefix: '₱ ',
                    errorText: _startingError,
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    onChanged: _onStartingChanged,
                  ),
                  const SizedBox(height: 16),
                  _label('FREQUENCY'),
                  const SizedBox(height: 8),
                  _frequencySelector(),
                  if (_targetDate != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'DAILY = 1+ DAY  \u00B7  WEEKLY = 7+ DAYS  \u00B7  MONTHLY = 30+ DAYS',
                      style: IponTypography.label.copyWith(
                        fontSize: 10,
                        color: IponColors.textDim,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  _label('TARGET DATE'),
                  const SizedBox(height: 8),
                  _datePickerTile(),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'WHEN YOU WANT TO COMPLETE THIS QUEST.',
                          style: IponTypography.label.copyWith(
                            fontSize: 11,
                            color: IponColors.textDim,
                          ),
                        ),
                      ),
                      if (_targetCents > 0)
                        InkWell(
                          onTap: _suggestDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: IponColors.frameOuter
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                            child: Text(
                              'SUGGEST',
                              style: IponTypography.label.copyWith(
                                fontSize: 11,
                                color: IponColors.frameOuter,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (_dateError != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      '\u26A0 $_dateError',
                      style: IponTypography.label
                          .copyWith(color: IponColors.danger),
                    ),
                  ],
                  const SizedBox(height: 20),
                  _label('YOUR PLAN'),
                  const SizedBox(height: 8),
                  SavingsPlanCard(plan: _plan),
                  const SizedBox(height: 16),
                  _label('COLOR'),
                  const SizedBox(height: 8),
                  _colorPicker(),
                  const SizedBox(height: 24),
                  SystemButton(
                    label: _saving ? 'SAVING...' : 'CREATE QUEST',
                    onPressed: (_canSave && !_saving) ? _save : null,
                  ),
                  const SizedBox(height: 12),
                  SystemButton(
                    label: 'CANCEL',
                    onPressed: _saving
                        ? null
                        : () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text, style: IponTypography.label);

  Widget _iconUploader() {
    final color = _parseHex(_colorHex);
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickingImage ? null : _pickIcon,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.15),
                border: Border.all(color: color, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: _iconPath == null
                  ? Icon(
                      _pickingImage
                          ? Icons.hourglass_empty
                          : Icons.add_photo_alternate_outlined,
                      color: color,
                      size: 48,
                    )
                  : ClipOval(
                      child: FutureBuilder<String>(
                        future:
                            ImagePickerHelper.resolveAbsolute(_iconPath!),
                        builder: (context, snap) {
                          if (!snap.hasData) return const SizedBox();
                          return Image.file(
                            File(snap.data!),
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.broken_image_outlined,
                              color: color,
                              size: 48,
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _iconPath == null
                ? 'TAP TO UPLOAD IMAGE'
                : 'TAP TO CHANGE IMAGE',
            style: IponTypography.label,
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    String? hint,
    String? prefix,
    String? errorText,
    int? maxLength,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      style: IponTypography.value,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      cursorColor: IponColors.frameOuter,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            IponTypography.body.copyWith(color: IponColors.textDim),
        prefixText: prefix,
        prefixStyle: IponTypography.value,
        counterStyle: IponTypography.label
            .copyWith(fontSize: 10, color: IponColors.textDim),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorText != null
                ? IponColors.danger
                : IponColors.frameInner.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorText != null
                ? IponColors.danger
                : IponColors.frameOuter,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: IponColors.danger),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: IponColors.danger),
        ),
        errorText: errorText,
        errorStyle:
            IponTypography.label.copyWith(color: IponColors.danger),
      ),
    );
  }

  Widget _datePickerTile() {
    final label = _targetDate == null
        ? 'SELECT END DATE'
        : '${_targetDate!.year}-${_targetDate!.month.toString().padLeft(2, '0')}-${_targetDate!.day.toString().padLeft(2, '0')}';
    return InkWell(
      onTap: _pickDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: _dateError != null
                ? IponColors.danger
                : IponColors.frameInner.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: IponTypography.value.copyWith(
                  color: _targetDate == null
                      ? IponColors.textDim
                      : IponColors.textPrimary,
                ),
              ),
            ),
            const Icon(Icons.calendar_today_outlined,
                color: IponColors.frameOuter, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _frequencySelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _frequencies.map((f) {
        final selected = _frequency == f;
        final enabled = _frequencyEnabled(f);
        final minDays = SavingsCalculator.minDaysFor(f);
        final needsMore =
            !enabled && f != 'flexible' ? '${minDays}D+' : null;

        return InkWell(
          onTap: enabled ? () => setState(() => _frequency = f) : null,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: !enabled
                    ? IponColors.textDim.withValues(alpha: 0.3)
                    : selected
                        ? IponColors.frameOuter
                        : IponColors.frameInner.withValues(alpha: 0.4),
              ),
              boxShadow: (enabled && selected)
                  ? [
                      BoxShadow(
                        color:
                            IponColors.frameOuter.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  f.toUpperCase(),
                  style: IponTypography.label.copyWith(
                    color: !enabled
                        ? IponColors.textDim.withValues(alpha: 0.4)
                        : selected
                            ? IponColors.textPrimary
                            : IponColors.textSecondary,
                  ),
                ),
                if (needsMore != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    needsMore,
                    style: IponTypography.label.copyWith(
                      fontSize: 9,
                      color: IponColors.textDim.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _colorPicker() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _colorSwatches.map((hex) {
        final selected = _colorHex == hex;
        final color = _parseHex(hex);
        return InkWell(
          onTap: () => setState(() => _colorHex = hex),
          customBorder: const CircleBorder(),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? IponColors.textPrimary
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: selected
                  ? [BoxShadow(color: color, blurRadius: 12)]
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _parseHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}

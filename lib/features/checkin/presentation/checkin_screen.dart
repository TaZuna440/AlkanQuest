import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/services/draft_service.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../../../core/utils/money_formatter.dart';
import '../../../core/utils/savings_calculator.dart';
import '../../../core/widgets/image_ref_view.dart';
import '../../../core/widgets/system_button.dart';
import '../../../data/database/app_database.dart';

class CheckinScreen extends ConsumerStatefulWidget {
  final Challenge challenge;
  const CheckinScreen({super.key, required this.challenge});

  @override
  ConsumerState<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends ConsumerState<CheckinScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String? _proofPath;
  String? _amountError;
  bool _saving = false;
  bool _pickingProof = false;
  bool _restoredDraft = false;
  bool _submitted = false;

  Timer? _draftTimer;

  Challenge get c => widget.challenge;

  @override
  void initState() {
    super.initState();
    _restoreDraft();
    _amountController.addListener(_onFieldChanged);
    _noteController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _draftTimer?.cancel();
    // Save draft on close if not submitted.
    if (!_submitted) {
      _persistDraft();
    }
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _restoreDraft() async {
    final draft = await DraftService.load(c.id);
    if (!mounted || draft == null || draft.isEmpty) return;
    setState(() {
      _restoredDraft = true;
      if (draft.amountCents != null && draft.amountCents! > 0) {
        _amountController.text = MoneyFormatter.format(draft.amountCents!)
            .replaceFirst('₱', '');
      }
      if (draft.note != null) _noteController.text = draft.note!;
      if (draft.proofPath != null) _proofPath = draft.proofPath;
    });
  }

  void _onFieldChanged() {
    _draftTimer?.cancel();
    _draftTimer = Timer(const Duration(seconds: 2), _persistDraft);
    if (_amountError != null) setState(() => _amountError = null);
  }

  Future<void> _persistDraft() async {
    final amount = MoneyFormatter.parseToCents(_amountController.text) ?? 0;
    final note = _noteController.text.trim();
    final draft = CheckinDraft(
      challengeId: c.id,
      amountCents: amount > 0 ? amount : null,
      note: note.isEmpty ? null : note,
      proofPath: _proofPath,
      savedAt: DateTime.now(),
    );
    if (draft.isEmpty) {
      await DraftService.clear(c.id);
    } else {
      await DraftService.save(draft);
    }
  }

  int get _amountCents =>
      MoneyFormatter.parseToCents(_amountController.text) ?? 0;

  String? _validateAmount() {
    if (_amountController.text.trim().isEmpty) {
      return 'AMOUNT IS REQUIRED.';
    }
    final cents = MoneyFormatter.parseToCents(_amountController.text);
    if (cents == null) return 'ENTER A VALID AMOUNT.';
    if (cents <= 0) return 'AMOUNT MUST BE GREATER THAN ₱0.';
    if (cents > 100000000) return 'MAXIMUM PER CHECK-IN IS ₱1,000,000.';
    return null;
  }

  List<int> _suggestedAmounts() {
    final remaining = c.targetAmountCents - c.currentAmountCents;
    if (remaining <= 0) return [];
    final plan = SavingsCalculator.compute(
      targetCents: c.targetAmountCents,
      startingCents: c.currentAmountCents,
      targetDate: c.targetDate,
      frequency: c.frequency,
    );
    if (plan == null || plan.requiredPerPeriodCents <= 0) return [];
    // Round up to nearest ₱10
    final raw = plan.requiredPerPeriodCents;
    final rounded = ((raw + 999) ~/ 1000) * 1000;
    final suggestions = <int>[rounded, rounded * 2, rounded * 5];
    // If remaining is smaller than 10x, include it as a "finish now" option.
    if (remaining < rounded * 10) {
      suggestions.add(remaining);
    } else {
      suggestions.add(rounded * 10);
    }
    // Dedupe + keep ascending
    final set = suggestions.toSet().toList()..sort();
    return set;
  }

  Future<void> _pickProof() async {
    if (_pickingProof) return;
    setState(() => _pickingProof = true);
    try {
      final path = await ImagePickerHelper.pickAndSaveProofImage(c.id);
      if (path != null && mounted) {
        setState(() => _proofPath = path);
        _onFieldChanged();
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
      if (mounted) setState(() => _pickingProof = false);
    }
  }

  Future<void> _removeProof() async {
    if (_proofPath == null) return;
    final old = _proofPath!;
    setState(() => _proofPath = null);
    await ImagePickerHelper.deleteProof(old);
    _onFieldChanged();
  }

  Future<void> _submit() async {
    final err = _validateAmount();
    setState(() => _amountError = err);
    if (err != null) return;

    setState(() => _saving = true);
    _submitted = true;
    _draftTimer?.cancel();

    final savingsRepo = ref.read(savingsRepositoryProvider);

    await savingsRepo.create(
      challengeId: c.id,
      amountCents: _amountCents,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      proofPath: _proofPath,
    );

    await DraftService.clear(c.id);

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _cancel() async {
    // Save draft on cancel so it can be resumed.
    _draftTimer?.cancel();
    await _persistDraft();
    if (!mounted) return;
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final remaining = c.targetAmountCents - c.currentAmountCents;
    final suggestions = _suggestedAmounts();

    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: SystemWindowFrame(
              title: 'SAVINGS CHECK-IN',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _challengeHeader(remaining),
                  const SizedBox(height: 20),
                  _label('HOW MUCH DID YOU SAVE?'),
                  const SizedBox(height: 8),
                  _amountField(),
                  if (suggestions.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      'QUICK PICK',
                      style: IponTypography.label.copyWith(
                        fontSize: 11,
                        color: IponColors.textDim,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _quickPickRow(suggestions),
                  ],
                  const SizedBox(height: 20),
                  _label('NOTE (OPTIONAL)'),
                  const SizedBox(height: 8),
                  _noteField(),
                  const SizedBox(height: 20),
                  _label('PROOF (OPTIONAL)'),
                  const SizedBox(height: 8),
                  _proofRow(),
                  if (_restoredDraft) ...[
                    const SizedBox(height: 12),
                    Text(
                      '\u25C6 RESTORED FROM UNSAVED CHECK-IN',
                      style: IponTypography.label.copyWith(
                        fontSize: 10,
                        color: IponColors.gold,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SystemButton(
                    label: _saving ? 'SAVING...' : 'CONFIRM SAVINGS',
                    onPressed: _saving ? null : _submit,
                  ),
                  const SizedBox(height: 12),
                  SystemButton(
                    label: 'CANCEL',
                    onPressed: _saving ? null : _cancel,
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

  Widget _challengeHeader(int remaining) {
    final color = _parseHex(c.colorHex);
    final progress = c.targetAmountCents == 0
        ? 0.0
        : (c.currentAmountCents / c.targetAmountCents).clamp(0.0, 1.0);
    final percent = (progress * 100).round();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\u25C6 ${c.name}', style: IponTypography.header),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${MoneyFormatter.format(c.currentAmountCents)} / ${MoneyFormatter.format(c.targetAmountCents)}',
                style: IponTypography.value,
              ),
              Text('$percent%',
                  style: IponTypography.value.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: 4),
          Text('${MoneyFormatter.format(remaining)} REMAINING',
              style: IponTypography.label),
        ],
      ),
    );
  }

  Widget _amountField() {
    return TextField(
      controller: _amountController,
      style: IponTypography.value,
      keyboardType: TextInputType.number,
      maxLength: 15,
      cursorColor: IponColors.frameOuter,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
      ],
      decoration: InputDecoration(
        prefixText: '₱ ',
        prefixStyle: IponTypography.value,
        hintText: '0',
        hintStyle: IponTypography.body.copyWith(color: IponColors.textDim),
        counterStyle: IponTypography.label
            .copyWith(fontSize: 10, color: IponColors.textDim),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _amountError != null
                ? IponColors.danger
                : IponColors.frameInner.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _amountError != null
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
        errorText: _amountError,
        errorStyle:
            IponTypography.label.copyWith(color: IponColors.danger),
      ),
    );
  }

  Widget _quickPickRow(List<int> amounts) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: amounts.map((cents) {
        return InkWell(
          onTap: () {
            _amountController.text =
                MoneyFormatter.format(cents).replaceFirst('₱', '');
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: IponColors.frameInner.withValues(alpha: 0.5),
              ),
            ),
            child: Text(
              MoneyFormatter.format(cents),
              style: IponTypography.value.copyWith(fontSize: 14),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _noteField() {
    return TextField(
      controller: _noteController,
      style: IponTypography.value,
      maxLength: 200,
      maxLines: 2,
      cursorColor: IponColors.frameOuter,
      decoration: InputDecoration(
        hintText: 'SKIPPED MILK TEA',
        hintStyle: IponTypography.body.copyWith(color: IponColors.textDim),
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
      ),
    );
  }

  Widget _proofRow() {
    if (_proofPath == null) {
      return InkWell(
        onTap: _pickingProof ? null : _pickProof,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: IponColors.frameInner.withValues(alpha: 0.5),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Icon(
                  _pickingProof
                      ? Icons.hourglass_empty
                      : Icons.add_photo_alternate_outlined,
                  color: IponColors.frameOuter,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  _pickingProof ? 'LOADING...' : '+ ADD PROOF',
                  style: IponTypography.label,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: IponColors.frameInner.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ImageRefView(
              reference: _proofPath,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              placeholderBuilder: () => Container(
                width: 64,
                height: 64,
                color: IponColors.bgPlum,
                child: const Icon(Icons.broken_image_outlined,
                    color: IponColors.textDim),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text('PROOF ATTACHED',
                style: IponTypography.label
                    .copyWith(color: IponColors.success)),
          ),
          InkWell(
            onTap: _pickingProof ? null : _removeProof,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: IponColors.danger),
              ),
              child: Text(
                'REMOVE',
                style: IponTypography.label
                    .copyWith(color: IponColors.danger, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _parseHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}

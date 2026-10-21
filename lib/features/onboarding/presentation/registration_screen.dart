import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/theme/system_window_frame.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/system_button.dart';
import '../providers/onboarding_providers.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    // Rebuild on every keystroke so the CONTINUE button enables as soon as
    // the typed name is valid. (Previously the listener only cleared errors,
    // so `canSubmit` was stuck at its first-build value and the button
    // stayed disabled forever.)
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (!mounted) return;
    setState(() {
      _error = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final error = IponValidators.validateDisplayName(_controller.text);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    ref
        .read(onboardingDataProvider.notifier)
        .setDisplayName(_controller.text.trim());
    ref.read(onboardingStepProvider.notifier).goToFirstQuest();
  }

  void _onSkip() {
    ref.read(onboardingDataProvider.notifier).setDisplayName('HUNTER');
    ref.read(onboardingStepProvider.notifier).goToFirstQuest();
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit =
        IponValidators.validateDisplayName(_controller.text) == null;

    return Scaffold(
      backgroundColor: IponColors.bgVoid,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: SystemWindowFrame(
                title: 'HUNTER REGISTRATION',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('ENTER YOUR CALLSIGN:',
                        style: IponTypography.label),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _controller,
                      style: IponTypography.value,
                      maxLength: 24,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        if (IponValidators.validateDisplayName(
                                _controller.text) ==
                            null) {
                          _onSubmit();
                        }
                      },
                      cursorColor: IponColors.frameOuter,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        counterStyle: IponTypography.label
                            .copyWith(fontSize: 10, color: IponColors.textDim),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _error != null
                                ? IponColors.danger
                                : IponColors.frameInner
                                    .withValues(alpha: 0.5),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: IponColors.frameOuter),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: IponColors.danger),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: IponColors.danger),
                        ),
                        errorText: _error,
                        errorStyle: IponTypography.label
                            .copyWith(color: IponColors.danger),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SystemButton(
                      label: 'CONTINUE',
                      onPressed: canSubmit ? _onSubmit : null,
                    ),
                    const SizedBox(height: 12),
                    SystemButton(label: 'SKIP', onPressed: _onSkip),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

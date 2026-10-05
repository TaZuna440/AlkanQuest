import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OnboardingStep {
  awakening,
  registration,
  firstQuest,
  briefing,
  complete,
}

class OnboardingStepNotifier extends Notifier<OnboardingStep> {
  @override
  OnboardingStep build() => OnboardingStep.awakening;

  void goToAwakening() => state = OnboardingStep.awakening;
  void goToRegistration() => state = OnboardingStep.registration;
  void goToFirstQuest() => state = OnboardingStep.firstQuest;
  void goToBriefing() => state = OnboardingStep.briefing;
  void complete() => state = OnboardingStep.complete;
}

final onboardingStepProvider =
    NotifierProvider<OnboardingStepNotifier, OnboardingStep>(
  OnboardingStepNotifier.new,
);

class OnboardingData {
  final String displayName;
  final String? acceptedTemplateId;

  const OnboardingData({
    this.displayName = 'HUNTER',
    this.acceptedTemplateId,
  });

  OnboardingData copyWith({
    String? displayName,
    String? acceptedTemplateId,
  }) =>
      OnboardingData(
        displayName: displayName ?? this.displayName,
        acceptedTemplateId: acceptedTemplateId ?? this.acceptedTemplateId,
      );
}

class OnboardingDataNotifier extends Notifier<OnboardingData> {
  @override
  OnboardingData build() => const OnboardingData();

  void setDisplayName(String name) =>
      state = state.copyWith(displayName: name);

  void setTemplate(String? templateId) =>
      state = state.copyWith(acceptedTemplateId: templateId);
}

final onboardingDataProvider =
    NotifierProvider<OnboardingDataNotifier, OnboardingData>(
  OnboardingDataNotifier.new,
);

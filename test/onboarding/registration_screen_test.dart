import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipon_system/features/onboarding/presentation/registration_screen.dart';
import 'package:ipon_system/features/onboarding/providers/onboarding_providers.dart';

void main() {
  testWidgets(
      'typing a valid callsign enables CONTINUE and submits the name',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: RegistrationScreen()),
      ),
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(RegistrationScreen)),
    );
    container.read(onboardingStepProvider.notifier).goToRegistration();

    // Before typing, CONTINUE must not advance (name is empty/invalid).
    await tester.tap(find.text('CONTINUE'));
    await tester.pump();
    expect(container.read(onboardingStepProvider),
        OnboardingStep.registration);

    // Type a valid callsign — the button must become usable.
    await tester.enterText(find.byType(TextField), 'ShadowFox');
    await tester.pump();

    await tester.tap(find.text('CONTINUE'));
    await tester.pump();

    expect(
        container.read(onboardingStepProvider), OnboardingStep.firstQuest);
    expect(container.read(onboardingDataProvider).displayName, 'ShadowFox');
  });

  testWidgets('SKIP still assigns the default HUNTER callsign',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: RegistrationScreen()),
      ),
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(RegistrationScreen)),
    );

    await tester.tap(find.text('SKIP'));
    await tester.pump();

    expect(
        container.read(onboardingStepProvider), OnboardingStep.firstQuest);
    expect(container.read(onboardingDataProvider).displayName, 'HUNTER');
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ipon_system/l10n/app_strings.dart';
import 'package:ipon_system/l10n/system_voice.dart';

void main() {
  test('AppStrings returns Filipino for known keys', () {
    expect(AppStrings.of(AppStrings.navQuests, 'fil'), 'MGA QUEST');
    expect(AppStrings.of(AppStrings.iSavedIt, 'fil'), '+ NAG-IPON AKO');
  });

  test('AppStrings falls back to English for unknown locale', () {
    expect(AppStrings.of(AppStrings.navQuests, 'es'), 'QUESTS');
  });

  test('AppStrings falls back to the key itself when missing', () {
    expect(AppStrings.of('no_such_key', 'en'), 'no_such_key');
  });

  test('SystemVoice switches dramatic/plain and locale', () {
    expect(
      SystemVoice.checkinTitle(dramatic: true, locale: 'en'),
      '[ CHECK-IN RECORDED ]',
    );
    expect(
      SystemVoice.checkinTitle(dramatic: false, locale: 'en'),
      'Check-in recorded',
    );
    expect(
      SystemVoice.checkinTitle(dramatic: true, locale: 'fil'),
      '[ NAITALA ANG CHECK-IN ]',
    );
    expect(
      SystemVoice.reminderBody(dramatic: false, locale: 'fil'),
      contains('i-log'),
    );
  });

  test('SystemVoice milestone body mentions quest and percent', () {
    final body = SystemVoice.milestoneBody(0.5, 'Emergency',
        dramatic: true, locale: 'en');
    expect(body, contains('Emergency'));
    expect(body, contains('50%'));
  });
}

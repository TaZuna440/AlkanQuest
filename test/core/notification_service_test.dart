import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipon_system/core/services/notification_service.dart';

void main() {
  test('parseReminderTime handles HH:mm', () {
    final t = NotificationService.parseReminderTime('20:30');
    expect(t.hour, 20);
    expect(t.minute, 30);
  });

  test('parseReminderTime falls back on garbage', () {
    final t = NotificationService.parseReminderTime('nope');
    expect(t.hour, 20);
    expect(t.minute, 0);
  });

  test('parseReminderTime clamps out-of-range values', () {
    final t = NotificationService.parseReminderTime('99:99');
    expect(t.hour, 23);
    expect(t.minute, 59);
  });

  test('formatReminderTime round-trips', () {
    expect(
      NotificationService.formatReminderTime(
        const TimeOfDay(hour: 8, minute: 5),
      ),
      '08:05',
    );
  });
}

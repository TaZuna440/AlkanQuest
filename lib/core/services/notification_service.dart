import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/notification_repository.dart';

/// Daily check-in reminders + quest milestone alerts (Phase 10).
///
/// * Scheduling is **inexact** ([AndroidScheduleMode.inexactAllowWhileIdle]),
///   so no exact-alarm permission is needed.
/// * The daily reminder repeats at the player's chosen time
///   ([UserProfile.dailyReminderTime], "HH:mm").
/// * Milestone alerts are fired by the UI layer after a check-in crosses a
///   threshold flagged by [ProgressionService]; each send is logged to
///   [NotificationLogs].
class NotificationService {
  static const int dailyReminderId = 1001;
  static const int milestoneBaseId = 2000;

  static const String _channelId = 'ipon_reminders';
  static const String _channelName = 'Ipon Reminders';

  final FlutterLocalNotificationsPlugin _plugin;
  final NotificationRepository _logRepo;
  static const _uuid = Uuid();

  bool _initialized = false;

  NotificationService({
    FlutterLocalNotificationsPlugin? plugin,
    required NotificationRepository logRepo,
  })  : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
        _logRepo = logRepo;

  /// Must be called once at startup (before any schedule/show).
  Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Asia/Manila'));
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _plugin.initialize(settings: initSettings);
    _initialized = true;
  }

  /// Android 13+ runtime permission. Returns true when granted.
  /// Web/desktop: returns true (nothing to request).
  Future<bool> requestPermission() async {
    if (kIsWeb) return true;
    try {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      final granted = await android?.requestNotificationsPermission();
      return granted ?? true;
    } catch (_) {
      return false;
    }
  }

  /// Schedules (or re-schedules) the daily reminder at [time].
  /// Inexact: the OS may shift delivery, no exact-alarm permission needed.
  /// [body] defaults to the dramatic English line; pass a localized/
  /// voice-aware body from the caller when available.
  Future<void> scheduleDailyReminder(TimeOfDay time, {String? body}) async {
    await init();
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: 'Daily reminders to log your savings check-in.',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
    );

    await _plugin.zonedSchedule(
      id: dailyReminderId,
      scheduledDate: scheduled,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      title: 'SYSTEM REMINDER',
      body: body ?? 'Your quests await, Hunter. Log today\u2019s check-in.',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelDailyReminder() async {
    await _plugin.cancel(id: dailyReminderId);
  }

  /// Immediate milestone alert (25/50/75/90%/complete), logged to the DB.
  Future<void> showMilestone({
    required String title,
    required String body,
    String? challengeId,
    required String type,
  }) async {
    await init();
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: 'Quest milestone alerts.',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
    final id = milestoneBaseId +
        DateTime.now().millisecondsSinceEpoch.remainder(999999);
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
    );
    await _logRepo.log(
      id: _uuid.v4(),
      type: type,
      challengeId: challengeId,
    );
  }

  /// Parses "HH:mm" (profile.dailyReminderTime) into a [TimeOfDay].
  static TimeOfDay parseReminderTime(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length != 2) return const TimeOfDay(hour: 20, minute: 0);
    final h = int.tryParse(parts[0]) ?? 20;
    final m = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: h.clamp(0, 23), minute: m.clamp(0, 59));
  }

  /// Formats a [TimeOfDay] back to "HH:mm".
  static String formatReminderTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

# Phase 10 — Notifications

**Duration:** 4 days
**Depends on:** Phase 09 (achievements)
**Deliverable:** Daily check-in reminder + quest milestone alerts, with a proper permission flow.

## Scope

- `NotificationService` (`lib/core/services/notification_service.dart`):
  - `init()` — timezone DB init + device timezone detection (`flutter_timezone`; falls back to Asia/Manila).
  - `requestPermission()` — Android 13+ runtime permission via the plugin's platform API.
  - `scheduleDailyReminder(TimeOfDay)` — repeats daily at the player's chosen time (`UserProfile.dailyReminderTime`, "HH:mm"). **Inexact** (`AndroidScheduleMode.inexactAllowWhileIdle`): the OS may shift delivery, so no exact-alarm permission is needed.
  - `showMilestone(...)` — immediate alerts for 25/50/75/90%/complete, each logged to `NotificationLogs`.
  - `parseReminderTime` / `formatReminderTime` helpers for the "HH:mm" profile field.
- `NotificationRepository` — logs every milestone send (`type`, `challengeId`, `sentAt`).
- Android: `POST_NOTIFICATIONS` permission added to the manifest.
- Milestone wiring: after a check-in crosses a flagged threshold, the check-in screen fires the alert — only when the player enabled reminders. Quest name + Solo Leveling flavor in the copy.
- Startup: `AppRoot` bootstrap re-arms the daily reminder when `notificationsEnabled` is true.
- The settings toggle + reminder-time picker UI lands in Phase 11 (the service and permission flow are ready for it).

## Out of Scope

- Settings UI for the toggle/time picker (Phase 11).
- Streak-break warnings, weekly summaries — future ideas, not in the proposal.

## Tasks

- [x] Implement `NotificationService` (init, permission, schedule, milestone)
- [x] Add `flutter_timezone` dependency for correct local scheduling
- [x] Implement `NotificationRepository` (send log)
- [x] Add `POST_NOTIFICATIONS` to Android manifest
- [x] Fire milestone alerts from the check-in flow (gated on `notificationsEnabled`)
- [x] Re-arm the daily reminder at app startup when enabled
- [x] Unit tests for the reminder-time helpers
- [x] `flutter analyze` clean, `flutter test` green

## Acceptance Criteria

- [x] `flutter analyze` — no issues
- [x] `flutter test` — all tests pass (37/37)
- [x] Scheduling uses inexact mode (no `SCHEDULE_EXACT_ALARM` in the manifest)
- [x] Milestone alerts fire once per threshold (flags from Phase 06 prevent repeats)
- [x] Every milestone send is logged to `NotificationLogs`
- [x] Daily reminder re-arms on every app start while enabled

## Files Created

- `lib/core/services/notification_service.dart`
- `lib/core/providers/notification_providers.dart`
- `lib/data/repositories/notification_repository.dart`
- `test/core/notification_service_test.dart`

## Files Modified

- `pubspec.yaml` — added `flutter_timezone`
- `android/app/src/main/AndroidManifest.xml` — `POST_NOTIFICATIONS`
- `lib/core/providers/repository_providers.dart` — `notificationRepositoryProvider`
- `lib/features/checkin/presentation/checkin_screen.dart` — milestone alerts
- `lib/app.dart` — re-arm daily reminder at startup

## Risks

| Risk | Mitigation |
|------|-----------|
| flutter_local_notifications v22 changed to named-only parameters | Verified signatures against the published package source |
| Device timezone unknown | `flutter_timezone` with Asia/Manila fallback (PH-first app) |
| Permission denied permanently | Decline tracking columns (`notificationDeclineCount`) exist for the Phase 11 settings flow |

## Next Phase

→ Phase 11 — Profile & Settings

# Phase 11 — Profile & Settings

**Duration:** 4 days
**Depends on:** Phase 10 (notifications)
**Deliverable:** Profile screen with settings (language, system voice, reminders), CSV export, and the localization/voice infrastructure.

## Scope

- **Profile screen** (`lib/features/profile/presentation/profile_screen.dart`):
  - Player card: display name (edit dialog, validated with `IponValidators`), level/rank summary.
  - Settings: language EN/FIL switch, system voice toggle, daily reminders toggle, reminder time picker.
  - Static sections: rounding rules (spec A5), privacy note (on-device data, no account/cloud), about.
  - Export data: "EXPORT QUESTS (CSV)" and "EXPORT CHECK-INS (CSV)" via the platform share sheet.
- **Schema v4**: new `UserProfiles.systemVoiceEnabled` column (default true) with a Drift migration.
- **Localization** (`lib/l10n/app_strings.dart`): key UI strings in English + Filipino — bottom-nav labels, screen titles, main headers, primary buttons (~40 keys). `localeProvider` reads `UserProfile.locale`.
- **System voice** (`lib/l10n/system_voice.dart`): dramatic vs plain wording × en/fil for check-in results, level/rank-ups, milestones, reminders, achievement celebrations. `systemVoiceProvider` reads `UserProfile.systemVoiceEnabled`. Check-in flow, milestone notifications, reminder body, and celebration dialogs all honor both settings.
- **Reminder permission flow** (settings toggle): soft rationale dialog → system permission request → on grant, persist + schedule; on deny, record decline (`notificationDeclineCount`); after two declines the toggle points at system settings instead of re-prompting.
- **ExportService** (`lib/core/services/export_service.dart`): builds `ipon_quests.csv` / `ipon_checkins.csv` (centavos + pesos columns, ISO dates, proper CSV escaping) and shares via `SharePlus.instance.share`.

## Out of Scope

- Full-string localization (onboarding, forms, validation messages stay English) — key strings per the proposal.
- Cloud backup / import — export only, per MVP scope.

## Tasks

- [x] Schema v4 migration (`systemVoiceEnabled`) + build_runner codegen
- [x] `AppStrings` (en/fil key strings) + `localeProvider`/`systemVoiceProvider`
- [x] `SystemVoice` (dramatic/plain × en/fil)
- [x] `ProfileScreen` with all sections
- [x] Reminder permission flow with decline tracking
- [x] `ExportService` CSV export via share sheet (`share_plus`)
- [x] Localize: shell tabs, dashboard, status, achievements, detail, edit, check-in screens
- [x] Voice-aware: check-in results, milestones, reminder body, celebrations
- [x] PROFILE tab wired in `MainShell`; `_ComingSoonTab` removed
- [x] Unit tests: l10n fallbacks, voice switching
- [x] `flutter analyze` clean, `flutter test` green

## Acceptance Criteria

- [x] `flutter analyze` — no issues
- [x] `flutter test` — all tests pass (42/42)
- [x] Display name edits persist and validate (reserved names rejected)
- [x] Language switch re-labels nav, titles, headers, and primary buttons immediately
- [x] System voice toggle switches check-in dialogs/notifications between dramatic and plain
- [x] Reminder toggle requests permission once; deny is tracked; second deny redirects to system settings
- [x] Reminder time change re-schedules the daily notification
- [x] CSV export produces well-formed files and opens the share sheet
- [x] Drift migration v4 applies cleanly on top of v3 databases

## Files Created

- `lib/features/profile/presentation/profile_screen.dart`
- `lib/l10n/app_strings.dart`
- `lib/l10n/system_voice.dart`
- `lib/l10n/l10n_providers.dart`
- `lib/core/services/export_service.dart`
- `test/l10n/l10n_test.dart`

## Files Modified

- `lib/data/database/tables/user_profiles_table.dart` — `systemVoiceEnabled`
- `lib/data/database/app_database.dart` — schema v4 + migration
- `lib/data/database/app_database.g.dart` — regenerated
- `lib/data/repositories/profile_repository.dart` — settings update methods
- `lib/core/services/notification_service.dart` — voice-aware reminder body param
- `lib/features/checkin/presentation/checkin_screen.dart` — locale + voice
- `lib/features/challenges/presentation/challenge_detail_screen.dart` — locale + voice
- `lib/features/challenges/presentation/edit_challenge_screen.dart` — locale
- `lib/features/home/presentation/main_shell.dart` — locale tabs, PROFILE wired
- `lib/features/home/presentation/dashboard_tab.dart` — locale
- `lib/features/status/presentation/status_screen.dart` — locale
- `lib/features/achievements/presentation/achievements_screen.dart` — locale
- `lib/features/achievements/presentation/achievement_celebration_dialog.dart` — voice
- `lib/app.dart` — voice-aware reminder re-arm
- `pubspec.yaml` — added `share_plus`

## Risks

| Risk | Mitigation |
|------|-----------|
| Drift codegen needed after schema change | Ran `build_runner` (137s); committed regenerated `.g.dart` |
| share_plus v13 deprecated the static `Share` API | Used `SharePlus.instance.share(ShareParams(...))` |
| flutter_local_notifications v22 named-only params | Verified against published package source |

## Next Phase

→ Phase 12 — Polish

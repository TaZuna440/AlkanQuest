# Phase 12 — Polish

**Duration:** 2 weeks
**Depends on:** Phase 11 (profile & settings)
**Deliverable:** Release-ready MVP: branding aligned to spec, code review fixes, user manual.

## Scope

- **Branding** — Android app label is **AlkanQuest**; package/namespace/applicationId aligned to the spec: `com.iponsystem.app` (was `com.iponsystem.ipon_system`); `MainActivity` moved to the matching Kotlin package.
- **Code review fixes**:
  - `ProgressionService` milestone-flag update simplified (direct `copyWith` with `||`, no companion juggling); unused drift import removed.
  - `ProfileScreen` display-name edit: capture the controller text *before* dispose (was read after dispose).
- **User manual** — `docs/USER_MANUAL.md`: beginner-friendly quick-start covering the full loop (onboarding → create quest → reminders → check-in → dashboard/XP → quest complete → history), the XP/rank/streak cheat sheet, and FAQ/troubleshooting.
- Final `flutter analyze` (clean) + `flutter test` (green) pass.

## Out of Scope

- New features — the MVP scope from the proposal is complete (dashboard, quest detail, check-ins + XP, ranks, achievements, notifications, history/analytics, settings, CSV export, manual).
- Release signing / Play Store listing.

## Tasks

- [x] Align Android package to `com.iponsystem.app` + label to "AlkanQuest"
- [x] Simplify milestone-flag update in `ProgressionService`
- [x] Fix controller-after-dispose bug in display-name edit
- [x] Write `docs/USER_MANUAL.md`
- [x] `flutter analyze` clean, `flutter test` green

## Acceptance Criteria

- [x] `flutter analyze` — no issues
- [x] `flutter test` — all tests pass (42/42)
- [x] User manual covers the complete basic workflow
- [x] Every proposal expectation (1–10) is implemented — see coverage table

## Proposal Coverage

| # | Expectation | Status |
|---|---|---|
| 1 | Dashboard: active quests, progress bars, XP, level, rank E→S, streaks, suggested/remaining amounts | ✅ Phase 06 |
| 2 | Quest detail: progress, check-in history, edit, cancel (kept in history, no streak credit), delete | ✅ Phase 07 |
| 3 | First qualifying check-in/day/quest grants XP + advances streak | ✅ Phase 06 (`ProgressionService`) |
| 4 | XP/levels/ranks E→S with thresholds; completion XP + achievement | ✅ Phase 06 (spec A3/A4) |
| 5 | Achievements: unlock logic from seed + in-app celebration | ✅ Phase 06 (logic), Phase 09 (gallery + celebration) |
| 6 | Daily reminder (inexact), permission flow, milestone alerts, POST_NOTIFICATIONS | ✅ Phase 10 |
| 7 | History & analytics: completed/cancelled history, check-in history, streak stats, XP timeline | ✅ Phase 07 (history), Phase 08 (stats + timeline) |
| 8 | Settings: display name, system voice toggle, EN/FIL, rounding rules, privacy note, about | ✅ Phase 11 |
| 9 | CSV export of history via share sheet | ✅ Phase 11 |
| 10 | User manual / quick start markdown in docs/ | ✅ Phase 12 (`docs/USER_MANUAL.md`) |

## Files Created

- `docs/USER_MANUAL.md`

## Files Modified

- `android/app/src/main/AndroidManifest.xml` — label + POST_NOTIFICATIONS (Phase 10)
- `android/app/build.gradle.kts` — namespace/applicationId `com.iponsystem.app`
- `android/app/src/main/kotlin/com/iponsystem/app/MainActivity.kt` — moved + repackaged
- `lib/domain/services/progression_service.dart` — milestone-flag simplification
- `lib/features/profile/presentation/profile_screen.dart` — dispose-order fix

## Risks

| Risk | Mitigation |
|------|-----------|
| No Android SDK on this machine — APK not built here | Manifest/gradle changes are minimal and standard; team must run `flutter build apk --debug` on their machines before demo day |
| Package rename invalidates existing installs | Fresh installs only; no production users yet |

## Next Phase

→ MVP complete. Post-MVP ideas (per ROADMAP): export/import round-trip, full Filipino localization, charts on the Status screen, per-record delete/edit in history.

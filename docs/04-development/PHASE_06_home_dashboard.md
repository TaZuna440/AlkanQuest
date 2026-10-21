# Phase 06 — Home Dashboard

**Duration:** 1 week
**Depends on:** Phase 05 (check-in loop)
**Deliverable:** Progression engine (XP/streaks/achievements wired into check-ins) + Status Window dashboard with bottom navigation.

## Scope

- **Progression engine** (`lib/domain/services/`):
  - `XpService` — pure XP/rank/level rules from spec A3/A4 (rank bands E→S, level = 1 + totalXp ÷ 1000, XP-to-next-rank).
  - `StreakService` — pure streak math: per-quest period streaks (days/weeks/months by frequency, with current-period grace), daily saver streak, longest daily streak, first-check-in-today detection.
  - `ProgressionService` — orchestrates repositories on every check-in: first qualifying check-in of the day per quest → +50 XP; quest completion → +500 XP + completion streak + milestone flags; achievements evaluated on every write (spec B9); cancel → completion streak reset (spec A1).
- **Check-in wiring** — `CheckinScreen` now calls `ProgressionService.recordCheckin` and reports the outcome (XP, level-up, rank-up, quest complete, achievements) in a `SystemNoticeDialog`.
- **A5 rounding** — `SavingsCalculator.roundUpPerPeriod` (₱10 daily/flexible, ₱50 weekly, ₱100 monthly); used by dashboard suggestions and check-in quick picks.
- **Dashboard tab** — live Status Window: rank badge, level, XP-to-next-rank bar, total saved, daily streak, quests-cleared-in-a-row; active quest cards with progress bar, amounts, remaining, A5 suggested per-period amount, streak chip, "+ I SAVED IT".
- **Main shell** — bottom navigation (Dashboard / Status / Quests / Profile). Tabs for later phases show a "SYSTEM STANDBY" placeholder until their phase lands.
- `profileProvider` upgraded to a true live Drift stream so XP/streak updates refresh the UI instantly.

## Out of Scope

- Quest detail screen (Phase 07), Status deep-stats (Phase 08), achievement gallery + celebrations (Phase 09), notifications (Phase 10), settings (Phase 11).
- Tapping a quest card opens the check-in screen; the detail screen takes over this tap in Phase 07.

## Tasks

- [x] Implement `lib/domain/services/xp_service.dart` (ranks E→S, levels, XP constants)
- [x] Implement `lib/domain/services/streak_service.dart` (quest/daily/longest streaks)
- [x] Implement `lib/domain/services/progression_service.dart` (recordCheckin, cancelChallenge, milestones, achievement eval)
- [x] Add `SavingsCalculator.roundUpPerPeriod` per spec A5
- [x] Add repository streams: `ProfileRepository.watch`, `ChallengeRepository.watchById`, `SavingsRepository.watchAll`/`getAll`
- [x] Add `lib/core/providers/progression_providers.dart`
- [x] Rework `challenge_providers.dart`: live `profileProvider`, `challengeByIdProvider`, `challengeRecordsProvider`, `cancelledChallengesProvider`
- [x] Build `SystemNoticeDialog` widget
- [x] Wire `CheckinScreen` to progression service + outcome dialog; A5 quick-pick rounding
- [x] Build `MainShell` bottom navigation + `DashboardTab` Status Window
- [x] Replace `HomeScreen` with `MainShell` in `AppRoot`; delete old `home_screen.dart`
- [x] Unit tests: xp_service, streak_service, progression_service (in-memory Drift)
- [x] `flutter analyze` clean, `flutter test` green

## Acceptance Criteria

- [x] `flutter analyze` — no issues
- [x] `flutter test` — all tests pass (30/30)
- [x] First check-in of the day on a quest grants +50 XP and shows it in the result dialog
- [x] Second check-in the same day grants 0 XP but still adds to totals
- [x] Completing a quest grants +500 XP, increments the completion streak, and marks the quest completed
- [x] Achievements unlock on write (FIRST IPON on first check-in, FIRST QUEST on first completion, savings milestones)
- [x] Dashboard shows live XP, level, rank, XP-to-next-rank, total saved, streaks
- [x] Quest cards show progress, remaining, A5-rounded suggested per-period amount, and streak chip
- [x] Cancelling is blocked for non-active quests (service-level; UI button lands in Phase 07)

## Files Created

- `lib/domain/services/xp_service.dart`
- `lib/domain/services/streak_service.dart`
- `lib/domain/services/progression_service.dart`
- `lib/core/providers/progression_providers.dart`
- `lib/core/widgets/system_notice_dialog.dart`
- `lib/features/home/presentation/main_shell.dart`
- `lib/features/home/presentation/dashboard_tab.dart`
- `test/domain/xp_service_test.dart`
- `test/domain/streak_service_test.dart`
- `test/domain/progression_service_test.dart`

## Files Modified

- `lib/core/utils/savings_calculator.dart` — added `roundUpPerPeriod`
- `lib/data/repositories/profile_repository.dart` — added `watch()`
- `lib/data/repositories/challenge_repository.dart` — added `watchById()`
- `lib/data/repositories/savings_repository.dart` — added `watchAll()`, `getAll()`
- `lib/features/challenges/providers/challenge_providers.dart` — live streams
- `lib/features/checkin/presentation/checkin_screen.dart` — progression wiring
- `lib/app.dart` — `MainShell` as post-onboarding root
- `lib/features/home/presentation/home_screen.dart` — deleted (replaced by shell + tab)

## Design Decisions

| Decision | Rationale |
|----------|-----------|
| Completion XP (+500, A3) and FIRST QUEST achievement (+500 seed) stack on first completion | Keeps every number in the spec/seed literally true; framed as a deliberate "first clear" celebration bonus |
| Three streak concepts kept separate | Quest period streak (check-in consistency), daily saver streak (dashboard), quest-completion streak (spec A1, drives streak_7/streak_30) |
| Level = 1 + totalXp ÷ 1000 | Spec is silent on levels; simple, documented in code |
| Milestone flags set in progression service, notifications read them in Phase 10 | Schema already had the flags; separates data from delivery |

## Risks

| Risk | Mitigation |
|------|-----------|
| `flutter test` needs a loadable `libsqlite3.so` (Linux dev machines) | Symlink `libsqlite3.so.0` into a local lib dir and set `LD_LIBRARY_PATH`; documented here |
| Riverpod 3.x removed `AsyncValue.valueOrNull` | Use `.value` (null on loading/error) |

## Next Phase

→ Phase 07 — Challenge Detail

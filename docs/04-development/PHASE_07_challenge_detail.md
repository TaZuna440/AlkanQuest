# Phase 07 — Challenge Detail

**Duration:** 1 week
**Depends on:** Phase 06 (progression engine, dashboard)
**Deliverable:** Quest detail screen (progress, stats, check-in history) with edit / cancel / delete management.

## Scope

- `ChallengeDetailScreen` — watches one quest live (`challengeByIdProvider`):
  - Header: icon, name, status badge (ACTIVE / COMPLETED / CANCELLED), OVERDUE badge (spec C8).
  - Progress bar, saved/target amounts, notes.
  - Stat grid: remaining, A5 suggested per-period amount, quest streak (days/weeks/months by frequency), target date + days-left.
  - Check-in history: newest-first rows with amount, local date/time, note, proof thumbnail (tap → full proof viewer dialog).
  - Actions while **active**: "+ I SAVED IT" (check-in), "EDIT QUEST", "CANCEL QUEST" (confirm; records kept, cleared-streak resets per A1/B3), "DELETE QUEST" (confirm; records cascade-delete).
  - Completed/cancelled quests: history + delete only — no check-in, edit, or cancel (spec B4/B5: no reopening, no reactivation).
- `EditChallengeScreen` — edit name, notes, target amount, target date, frequency; validated with `IponValidators`.
  - Target cannot be lowered below what is already saved.
  - New target date auto-corrects the frequency if it no longer fits (`SavingsCalculator.frequencyFits`/`bestFrequencyFor`).
  - Spec C7: progress/suggestions recalculate automatically (derived from records). Spec C8: past target dates flag the quest OVERDUE on the detail screen.
- `SystemConfirmDialog` — reusable two-button System-Window confirmation (cancel/delete flows).
- Dashboard quest-card tap now opens the detail screen ("+ I SAVED IT" still opens check-in directly).

## Out of Scope

- Status deep-stats screen (Phase 08), achievement gallery (Phase 09).
- Editing a quest's color/icon (create-only for now; noted as a possible Phase 12 addition).

## Tasks

- [x] Build `SystemConfirmDialog` widget
- [x] Build `ChallengeDetailScreen` (progress, stats, history, actions)
- [x] Build `EditChallengeScreen` (validated form, frequency auto-correct)
- [x] Wire dashboard card tap → detail screen
- [x] Cancel flow via `ProgressionService.cancelChallenge` + result notice
- [x] Delete flow via `ChallengeRepository.delete` (records cascade)
- [x] `flutter analyze` clean, `flutter test` green

## Acceptance Criteria

- [x] `flutter analyze` — no issues
- [x] `flutter test` — all tests pass (30/30)
- [x] Detail shows live progress, remaining, suggested per-period (A5), streak, days-left
- [x] Overdue active quests show an OVERDUE badge
- [x] Check-in history lists every record with date, amount, note, proof thumbnail
- [x] Edit validates input; target cannot drop below saved amount
- [x] Cancel asks for confirmation, keeps records, resets the cleared-streak
- [x] Delete asks for confirmation and removes the quest + its records
- [x] Completed/cancelled quests expose no check-in, edit, or cancel actions

## Files Created

- `lib/features/challenges/presentation/challenge_detail_screen.dart`
- `lib/features/challenges/presentation/edit_challenge_screen.dart`
- `lib/core/widgets/system_confirm_dialog.dart`

## Files Modified

- `lib/features/home/presentation/dashboard_tab.dart` — card tap → detail screen

## Risks

| Risk | Mitigation |
|------|-----------|
| Drift `copyWith` on nullable columns needs `Value<T>` | Used `Value(...)` explicitly in edit screen |
| Accidental quest deletion | Double-gate: confirm dialog with explicit "DELETE FOREVER" label |

## Next Phase

→ Phase 08 — Status

# Phase 08 — Status (Progress)

**Duration:** 1 week
**Depends on:** Phase 07 (quest detail)
**Deliverable:** Status screen — rank/level/XP deep view, lifetime stats, derived XP timeline.

## Scope

- `UserStats` model (`lib/domain/models/user_stats.dart`) — one aggregated snapshot: XP/level/rank + band progress, totals, quest counts, daily/cleared streaks.
- `userStatsProvider` — combines the profile, records, and quest streams; recomputes live on every change.
- `XpTimelineBuilder` (`lib/domain/services/xp_timeline_builder.dart`) — pure derivation of the XP timeline from stored data (no ledger table):
  - +50 per first check-in of each day per quest (spec A3)
  - +500 per completed quest, dated at completion (spec A3)
  - achievement rewards dated at their unlocking event (first check-in, first completion, ₱1,000 / ₱10,000 crossings)
  - streak achievements excluded (unlock moment not reliably derivable)
- `StatusScreen` — gold rank card (rank, title, LV, XP bar with into-band numbers, XP-to-next-rank), 9-cell lifetime stats grid, XP timeline list (newest first, capped at 100).
- STATUS bottom-nav tab now shows the real screen (replaces the Phase 06 standby placeholder).

## Out of Scope

- Achievement gallery + celebrations (Phase 09) — the timeline references achievements but the gallery is separate.
- Charts/graphs — plain rows are enough for the MVP; noted as a possible Phase 12 addition.

## Tasks

- [x] Create `UserStats` / `XpTimelineEntry` models
- [x] Implement `userStatsProvider` and `xpTimelineProvider`
- [x] Extract `XpTimelineBuilder` as a pure, unit-tested function
- [x] Build `StatusScreen` (rank card, stats grid, timeline)
- [x] Wire STATUS tab in `MainShell`
- [x] Unit tests for `XpTimelineBuilder` (grouping, ordering, milestones)
- [x] `flutter analyze` clean, `flutter test` green

## Acceptance Criteria

- [x] `flutter analyze` — no issues
- [x] `flutter test` — all tests pass (33/33)
- [x] Rank card shows current rank, title, level, XP progress, XP-to-next-rank (or MAX RANK at S)
- [x] Stats grid shows totals, quest counts by status, daily + cleared streaks
- [x] Timeline lists XP events newest-first with correct +XP values and dates
- [x] Second check-in on the same day/quest does not create a duplicate +50 entry

## Files Created

- `lib/domain/models/user_stats.dart`
- `lib/domain/services/xp_timeline_builder.dart`
- `lib/features/status/providers/status_providers.dart`
- `lib/features/status/presentation/status_screen.dart`
- `test/domain/xp_timeline_builder_test.dart`

## Files Modified

- `lib/features/home/presentation/main_shell.dart` — STATUS tab wired

## Risks

| Risk | Mitigation |
|------|-----------|
| Timeline could grow unbounded | Capped at 100 newest entries |
| Achievement dates are reconstructed, not recorded | Documented; only derivable unlocks are dated |

## Next Phase

→ Phase 09 — Achievements

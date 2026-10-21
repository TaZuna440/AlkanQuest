# Phase 09 — Achievements

**Duration:** 3 days
**Depends on:** Phase 08 (status screen)
**Deliverable:** Achievement gallery + in-app celebration moment. (Unlock logic itself landed in Phase 06.)

## Scope

- Seed achievements at app startup (`AppRoot` bootstrap calls `seedDefaultsIfEmpty`) so the gallery is never empty.
- `AchievementsScreen` — gallery of all 6 seed achievements: unlocked (gold, glowing) vs locked (dimmed); names/descriptions in the player's locale (`nameEn`/`nameFil`); XP reward shown; per-achievement progress hint while locked (e.g. "₱350 / ₱1,000 SAVED", "3 / 7 QUESTS IN A ROW").
- `AchievementCelebrationDialog` — the celebration moment: a dramatic gold System Window ("[ ACHIEVEMENT UNLOCKED ]", icon, name, description, "+N XP", CLAIM button), shown once per unlock right after the check-in result dialog.
- Seed icon ids mapped to Material icons (`AchievementIcons`).
- QUESTS bottom-nav tab now shows the real gallery (replaces the Phase 06 standby placeholder).

## Out of Scope

- New achievements beyond the 6 seeded (spec B7: per-user scope; adding more is a content decision for later).
- Achievement revocation — never, per spec B8.

## Tasks

- [x] Seed achievements in `AppRoot` bootstrap
- [x] Build `AchievementsScreen` gallery with locale-aware names + progress hints
- [x] Build `AchievementCelebrationDialog`
- [x] Chain celebration dialogs after the check-in result dialog in `CheckinScreen`
- [x] Wire QUESTS tab in `MainShell`
- [x] `flutter analyze` clean, `flutter test` green

## Acceptance Criteria

- [x] `flutter analyze` — no issues
- [x] `flutter test` — all tests pass (33/33)
- [x] Gallery lists all 6 achievements with correct locked/unlocked state
- [x] Unlocking an achievement shows the celebration dialog with the right name, description, and XP
- [x] Locked achievements show a truthful progress hint
- [x] Names/descriptions follow the profile locale (en/fil)

## Files Created

- `lib/features/achievements/presentation/achievements_screen.dart`
- `lib/features/achievements/presentation/achievement_celebration_dialog.dart`

## Files Modified

- `lib/app.dart` — seed achievements at startup
- `lib/features/checkin/presentation/checkin_screen.dart` — celebration chain
- `lib/features/home/presentation/main_shell.dart` — QUESTS tab wired

## Risks

| Risk | Mitigation |
|------|-----------|
| Multiple unlocks in one check-in stack dialogs | Shown sequentially, each dismissed with CLAIM before the next |
| Locale changes after unlock | Celebration reads the locale at show-time |

## Next Phase

→ Phase 10 — Notifications

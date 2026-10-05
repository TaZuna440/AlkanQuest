# Current Phase

**Phase:** 03 — Onboarding
**Started:** —
**Target completion:** —

## What's Being Worked On

Ready to begin. Phase 03 builds the 5-screen onboarding flow.

## Deliverables

1. Splash screen (System Boot)
2. Screen 1 — SYSTEM AWAKENING
3. Screen 2 — HUNTER REGISTRATION (name input, validation)
4. Screen 3 — FIRST QUEST ASSIGNMENT (3 template cards + skip)
5. Screen 4 — SYSTEM BRIEFING (4-bullet summary + enter)
6. Home handoff with `firstRun` flag persisted

## Next Actions

1. Write `lib/features/onboarding/presentation/*.dart` (5 screens)
2. Add shared `SystemWindowFrame` usage
3. Wire Riverpod for onboarding state
4. Persist `onboardingComplete` to user profile
5. Update router to gate Home on onboarding state
6. Test manually

## Blockers

None.

## Notes

> Phase 02 delivered: Data layer (5 Drift tables, 4 repositories, 4 unit tests).
> Phase 03 delivers: First-run flow (splash through briefing).

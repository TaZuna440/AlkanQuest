# Development Plan

This folder contains **what we will build**. Not what we've done.

**For status tracking, see [../05-progress/](../05-progress/).**

## Roadmap Files

| File | Phase | Duration |
|------|-------|----------|
| `ROADMAP.md` | Overview of all 12 phases | — |
| `PHASE_01_foundation.md` | Project setup, theme, router | 1 week |
| `PHASE_02_core_models.md` | Drift tables, repositories | 1 week |
| `PHASE_03_onboarding.md` | Splash → Awakening → Registration → First Quest → Briefing | 1 week |
| `PHASE_04_create_challenge.md` | Form, validation, icon/color pickers | 1 week |
| `PHASE_05_checkin.md` | Form, draft, proof, save flow | 1 week |
| `PHASE_06_home_dashboard.md` | Status Window, quest cards | 1 week |
| `PHASE_07_challenge_detail.md` | Progress, history, edit | 1 week |
| `PHASE_08_status.md` | Stats, rank, XP bar | 1 week |
| `PHASE_09_achievements.md` | Unlock logic, celebration | 3 days |
| `PHASE_10_notifications.md` | Permissions, daily reminder | 4 days |
| `PHASE_11_profile_settings.md` | Profile, settings, about | 4 days |
| `PHASE_12_polish.md` | Animations, tests, edge cases | 2 weeks |

**Total MVP estimate:** ~12 weeks

## How to Use

1. Read `ROADMAP.md` first
2. Open the phase file you're working on
3. Check acceptance criteria before marking done
4. Update [../05-progress/PROGRESS.md](../05-progress/PROGRESS.md) when complete
5. Log changes in [../05-progress/CHANGELOG.md](../05-progress/CHANGELOG.md)

## Rules

- No phase starts until the previous one meets its acceptance criteria
- Scope changes require updating the phase file AND logging in decision log
- Every phase ends with a git tag (e.g., `v0.1.0-phase-01`)

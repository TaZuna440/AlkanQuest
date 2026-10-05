# Changelog

All changes, chronological. Newest first.

Format: YYYY-MM-DD - [type] description
Types: feat, fix, docs, chore, refactor, test

---

## 2026-10-05

### docs
- Created full documentation structure
- Added PROGRESS.md, CURRENT_PHASE.md, CHANGELOG.md, BLOCKERS.md
- Added 04-development/ with 12 phase files + roadmap
- Added DATA_DICTIONARY.md with all model fields
- Added DECISION_LOG.md with all decisions A-L
- Added design tokens (COLORS.md, TYPOGRAPHY.md, ICONS.md)

### chore
- Initialized git repository
- Created project folder structure
- Created pubspec.yaml with full dependency list
- Created README.md at project root

---

## 2026-10-05 — Phase 01 Complete

### feat
- Shadow System Window theme (colors, typography)
- IponApp root widget with ProviderScope
- HomeScreen with SystemWindowFrame component
- Empty state UI ("NO ACTIVE QUESTS" + "+ CREATE QUEST")

### chore
- Downloaded 9 font files (Orbitron, Rajdhani, JetBrains Mono)
- Configured fonts in pubspec.yaml
- Migrated from Snap Flutter to Git Flutter (fixed desktop rendering)
- Installed Linux desktop build tools (clang, cmake, ninja, GTK)
- Added Linux platform target
- Tagged v0.1.0-phase-01

### fix
- Removed `flutter_heif` (nonexistent package)
- Fixed pubspec fonts section
- Removed experimental `.fromSeed` syntax from main.dart

### known-issues
- Android emulator deferred (SDK 36 license quirk)
- Development target is Linux desktop for now

---

## 2026-10-05 — Phase 02 Complete

### feat
- 5 Drift tables: challenges, savings_records, user_profiles, achievements, notification_logs
- 4 repositories: ChallengeRepository, SavingsRepository, ProfileRepository, AchievementRepository
- `SavingsRepository._recomputeChallenge()` — auto-completes / reverts challenges in transaction
- Riverpod providers in `lib/core/providers/repository_providers.dart`
- 6 default achievements seeded
- 4 unit tests using in-memory SQLite (all passing)

### chore
- Upgraded dep stack to Riverpod 3, Drift 2.28, go_router 18
- Installed `libsqlite3-dev` for native test support
- Tagged v0.2.0-phase-02

### fix
- Removed unused `package:drift/drift.dart` import in seed file
- Pinned drift/drift_dev/sqlite3_flutter_libs to compatible versions

---

## 2026-10-05 — Phase 03 Complete

### feat
- 5-screen onboarding: Splash, Awakening, Registration, First Quest, Briefing
- Name validation with reserved-name blocking
- 3 starter quest templates (P50/day, 52-week, Custom)
- Profile persists after onboarding (onboardingComplete flag)
- AppRoot bootstraps and gates Home on profile state

### fix
- Riverpod 3 async ref usage in FirstQuestScreen
- SystemWindowFrame overflow (mainAxisSize.min)
- Migration v1→v2 adds onboardingComplete column

### chore
- Tagged v0.3.0-phase-03

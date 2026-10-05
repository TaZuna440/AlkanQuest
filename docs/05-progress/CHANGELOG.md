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

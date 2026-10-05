# Phase 01 — Foundation

**Duration:** 1 week
**Depends on:** Nothing
**Deliverable:** Flutter project runs with the Shadow System Window theme applied.

## Scope

- Flutter project initialized
- Folder structure per Section J3
- Theme tokens (colors, typography) implemented
- go_router configured with placeholder routes
- Reusable System Window frame widget
- App boots to a placeholder Home screen

## Out of Scope

- Any real data (no Drift yet)
- Any real interactions (buttons can be dead)
- Any business logic

## Tasks

- [ ] Run `flutter create .` with org `com.iponsystem`
- [ ] Add dependencies from `pubspec.yaml`
- [ ] Implement `core/theme/color_palette.dart`
- [ ] Implement `core/theme/typography.dart`
- [ ] Implement `core/theme/app_theme.dart` (ThemeData)
- [ ] Build `SystemWindowFrame` reusable widget
- [ ] Configure `core/router/app_router.dart` with all routes (placeholder screens)
- [ ] Build `features/home/presentation/home_screen.dart` placeholder
- [ ] Add all 5 bottom nav destinations
- [ ] Download fonts (Orbitron, Rajdhani, JetBrains Mono) to `assets/fonts/`
- [ ] Verify app runs on Android emulator

## Acceptance Criteria

- [ ] `flutter run` starts without errors
- [ ] Home screen shows a System Window frame with correct colors
- [ ] Bottom navigation switches between 5 placeholder screens
- [ ] Fonts load correctly (Orbitron headers, JetBrains Mono numbers)
- [ ] No console warnings about missing assets

## Files Created

- `lib/main.dart`
- `lib/app.dart`
- `lib/core/constants/app_constants.dart`
- `lib/core/constants/color_palette.dart`
- `lib/core/theme/typography.dart`
- `lib/core/theme/app_theme.dart`
- `lib/core/theme/system_window.dart`
- `lib/core/router/app_router.dart`
- `lib/features/home/presentation/home_screen.dart`
- Placeholder screens for challenges, checkin, status, profile

## Risks

| Risk | Mitigation |
|------|-----------|
| Font licensing | Use Google Fonts API — all three are free |
| Snap Flutter slow | Cache downloads before starting |
| Android license missing | Run `flutter doctor --android-licenses` |

## Next Phase

→ Phase 02 — Core Models

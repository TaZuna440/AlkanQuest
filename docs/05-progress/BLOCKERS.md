# Blockers

Active blockers preventing progress.

## Active

### [BLOCK-001] Android build OOM during first compile
**Logged:** 2026-10-05
**Impact:** Medium
**Blocking:** Real-device testing
**Description:** First `flutter run -d <phone>` gets OOM-killed (Signal 9) while Gradle unzips the 2.1 GB NDK. Causes: insufficient free RAM on dev machine + aggressive JVM heap.
**Workaround:** Continue development on Linux desktop target. All Flutter UI/logic is identical across platforms.
**Resolution:** Pending — will revisit when:
  - More RAM available, OR
  - NDK pre-installed via `sdkmanager "ndk;28.2.13676358"`, OR
  - Use a different build machine
**Resolved:** —

## Resolved

None.

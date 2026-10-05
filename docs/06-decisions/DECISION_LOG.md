# Decision Log

Every significant decision made during specification, with rationale.

## Section A - Core Mechanics

| ID | Question | Decision |
|----|----------|----------|
| A1 | Streak scope | Per completed challenge |
| A2 | Qualifying check-in | Amount > 0 on Active challenge |
| A3 | XP philosophy | Rewards consistency, not amount |
| A4 | Leveling | Rank E to S with titles |
| A5 | Suggested amount | Remaining / Remaining Periods |

## Section B - Data Model

| ID | Question | Decision |
|----|----------|----------|
| B1 | Money representation | int centavos |
| B2 | Source of truth | SavingsRecords |
| B3 | Cancelled + records | Preserve records |
| B4 | Completed reopening | No reopening |
| B5 | Cancelled reactivation | No reactivation |
| B6 | Paused status | Removed from MVP |
| B7 | Achievement scope | Per-user (global) |
| B8 | Achievement revocation | Never |
| B9 | Achievement eval | On every record write |

## Section C - Core User Flows

| ID | Decision |
|----|----------|
| C1 | Challenge picker then check-in form |
| C2 | Not in MVP |
| C3 | Prompt first check-in |
| C4 | Full celebration + new challenge prompt |
| C5 | Silent, no shame |
| C6 | Allow, recalculate downstream |
| C7 | Allow, recalculate |
| C8 | Allow, flag Overdue |

## Section D - Visual Design

| ID | Decision |
|----|----------|
| D1 | Shadow System Window theme (magenta) |
| D2 | System voice, ALL CAPS |
| D3 | Home = Status Window |
| D4 | Progress = Status Log |
| D5 | Challenges = Quest Log |
| D6 | 40 icons + 8 colors |
| D7 | Streak, Featured, Daily, Other |
| D8 | Segmented bar + circular ring |
| D9 | YYYY.MM.DD grouped by date |
| D10 | Diamond/star glyphs, no heatmap |

## Section E - Onboarding

| ID | Decision |
|----|----------|
| E1 | 5-screen system sequence |
| E2 | Partial skippable, name defaults |
| E3 | Permissions deferred |
| E4 | Exactly 2 coach marks |
| E5 | Name only required |

## Section F - Notifications

| ID | Decision |
|----|----------|
| F1 | 5 types |
| F2 | Max 2/day |
| F3 | 20:00 default |
| F4 | Opt-in after first check-in |
| F5 | Per-challenge dedup flags |
| F6 | On/off + time only |

## Section G - Localization

| ID | Decision |
|----|----------|
| G1 | English + Filipino accents |
| G2 | Peso prefix, drop .00 when whole |
| G3 | YYYY.MM.DD in logs |
| G4 | Western number format |
| G5 | Ipon, Alkansya, Kaya mo yan |
| G6 | Ipon System final |

## Section H - Proof & Media

| ID | Decision |
|----|----------|
| H1 | Local filesystem |
| H2 | JPEG + PNG + HEIC |
| H3 | 5 MB max after compression |
| H4 | Always compress |
| H5 | No encryption in MVP |
| H6 | One image + one note |
| H7 | Full-screen viewer |
| H8 | Cascade delete only |

## Section I - Edge Cases

| ID | Decision |
|----|----------|
| I1 | Trust device date |
| I2 | UTC storage, local display |
| I3 | Block negative amount |
| I4 | Truncate to 2 decimals |
| I5 | Block zero target |
| I6 | Allow past date, flag Overdue |
| I7 | Block starting >= target |
| I8 | Draft auto-save |
| I9 | Warn, never crash |
| I10 | Data lost on uninstall, disclosed |

## Section J - Architecture

| ID | Decision |
|----|----------|
| J1 | Riverpod 2.x |
| J2 | Drift (SQLite) |
| J3 | Feature-first folders |
| J4 | Testing pyramid |
| J5 | GitHub Actions |
| J6 | Drift schema v1 |
| J7 | Local logging |
| J8 | No analytics in MVP |
| J9 | Android 26+, iOS 14+ |
| J10 | com.iponsystem.app |

## Section K - Backend (Future)

| ID | Decision |
|----|----------|
| K1 | v2.0 introduction |
| K2 | Supabase |
| K3 | Offline-first sync |
| K4 | Email + Google + Apple |
| K5 | Everything except device-specific |

## Section L - Business & Legal

| ID | Decision |
|----|----------|
| L1 | Free MVP, freemium v2.0 |
| L2 | No ads ever |
| L3 | Tip jar, then subscription |
| L4 | DPA-compliant privacy |
| L5 | ToS with disclaimers |
| L6 | Full deletion on request |
| L7 | Google Play first |
| L8 | PH-first soft launch |

# ◆ AlkanQuest

**Turn saving money into quests. Level up your ipon.**

A gamified personal savings app for Filipino users — inspired by Solo Leveling's System Window.

[![Status](https://img.shields.io/badge/status-specification%20complete-b026ff)](#)
[![Platform](https://img.shields.io/badge/platform-Flutter%20%7C%20iOS%20%7C%20Android-b026ff)](https://flutter.dev/)
[![Version](https://img.shields.io/badge/version-1.0--spec-b026ff)](#)

---

## Table of Contents

- [1. Product Overview](#1-product-overview)
- [2. Core Product Concept](#2-core-product-concept)
- [3. Product Philosophy](#3-product-philosophy)
- [4. Section A — Core Mechanics](#4-section-a--core-mechanics)
- [5. Section B — Data Model Foundations](#5-section-b--data-model-foundations)
- [6. Section C — Core User Flows](#6-section-c--core-user-flows)
- [7. Section D — Visual & Interaction Design](#7-section-d--visual--interaction-design)
- [8. Section E — Onboarding](#8-section-e--onboarding)
- [9. Section F — Notifications](#9-section-f--notifications)
- [10. Section G — Localization](#10-section-g--localization)
- [11. Section H — Proof and Media](#11-section-h--proof-and-media)
- [12. Section I — Edge Cases & Error States](#12-section-i--edge-cases--error-states)
- [13. Input Validation](#13-input-validation)
- [14. Section J — Architecture & Technical](#14-section-j--architecture--technical)
- [15. Section K — Backend (Future)](#15-section-k--backend-future)
- [16. Section L — Business & Legal](#16-section-l--business--legal)
- [17. Data Models](#17-data-models)
- [18. Development Roadmap](#18-development-roadmap)
- [19. Open Questions](#19-open-questions)
- [Getting Started](#getting-started)

---

## 1. Product Overview

### 1.1 Product Name

**Ipon System**

Inspired by the Solo Leveling "System" concept. "Ipon" is a Filipino term for saving money. The app turns saving into a gamified challenge experience.

**Tagline:** *Level up your savings.*
**Package ID:** `com.iponsystem.app`

### 1.2 Product Type

Gamified Personal Savings / Ipon Challenge App — a habit-building tool, **not** a financial application.

### 1.3 Target User

Filipino users (primary) who want to save money but struggle with consistency. The system voice and rank-based progression appeal to users familiar with gaming and anime culture, while remaining approachable for non-gamers.

### 1.4 What the App Is NOT

- ❌ Not a bank
- ❌ Not a digital wallet
- ❌ Not an investment platform
- ❌ Not an accounting application
- ❌ Not a verification system for savings

---

## 2. Core Product Concept

### 2.1 The Problem

Many people want to save money but struggle with:

- Lack of consistency
- Forgetting to save
- Losing motivation
- Setting unrealistic goals
- No visual progress representation
- Abandoning challenges mid-way

Traditional finance apps focus on **tracking money**. Ipon System focuses on **motivating users to save consistently**.

### 2.2 The Solution

A gamified savings app with:

- Challenge-based savings goals
- Self-reported check-ins
- XP, levels, and rank progression (E to S)
- Streak tracking based on challenge completions
- Achievement unlocks
- Solo Leveling-inspired System Window UI

### 2.3 Important Limitation: Savings Verification

The app **cannot verify** that a user actually saved money. All savings are **self-reported check-ins**.

The app must **never** claim:

> ❌ "We verified that you saved ₱100."

Instead:

> ✅ "Savings recorded."
> ✅ "Check-in completed."

Optional proof images (screenshot, photo) are treated as **personal accountability**, not financial verification.

---

## 3. Product Philosophy

### 3.1 Core Principle

> **The app is not primarily a financial accounting tool. It is a habit-building and gamified savings tool.**

### 3.2 Product Rules

| # | Rule |
|---|------|
| 1 | The app records user-reported savings. It does not verify savings. |
| 2 | The app should not pretend to be a bank. |
| 3 | The primary objective is habit formation and motivation. |
| 4 | Gamification should encourage saving but not unhealthy financial behavior. |
| 5 | Users should be allowed to modify or cancel challenges. |
| 6 | The app should never shame users for missing a saving day. |
| 7 | Financial calculations must be deterministic and accurate. |
| 8 | Money values are handled as integer centavos (no floating-point). |
| 9 | The UI clearly distinguishes: target, recorded, remaining, suggested. |
| 10 | Features are added only when they support the core goal. |

### 3.3 One-Sentence Product Definition

> **Ipon System is a gamified savings app that turns saving money into achievable quests, tracks progress, builds habits, and celebrates milestones — all wrapped in a Solo Leveling-inspired System Window.**

---

## 4. Section A — Core Mechanics

### A1. Streak Scope

**Decision:** Streak applies to **completed challenges**. Each completed challenge increments the streak. Cancelling a challenge mid-progress resets the streak to 0.

**Home display:** `🔥 3 challenges completed in a row` — NOT `🔥 12-day streak`.

### A2. Qualifying Check-In

**Decision:** Any check-in with amount **> ₱0** on an **Active** challenge.

**Anti-abuse:** Only the first qualifying check-in per day per challenge advances the streak. Subsequent check-ins count toward totals but not streaks.

### A3. XP Philosophy

**Decision:** XP rewards **consistency**, not amount.

| Action | XP |
|--------|-----|
| First check-in per challenge per day | +50 |
| Challenge completed | +500 |
| 7-challenge streak milestone | +200 |
| 30-challenge streak milestone | +1,000 |

**XP is global** (per user, not per challenge).

### A4. Leveling & Ranks (Solo Leveling Style)

| Rank | XP Required | Title |
|------|-------------|-------|
| E | 0 – 499 | "Ipon Beginner" |
| D | 500 – 1,499 | "Consistent Saver" |
| C | 1,500 – 3,999 | "Challenge Hunter" |
| B | 4,000 – 9,999 | "Savings Warrior" |
| A | 10,000 – 24,999 | "Ipon Master" |
| S | 25,000+ | "Legendary Saver" |

### A5. Suggested Saving Amount Formula

**Decision:** `Remaining ÷ Remaining Periods = Suggested Amount`

**Rounding:**
- Daily: round **up** to nearest ₱10
- Weekly: round **up** to nearest ₱50
- Monthly: round **up** to nearest ₱100

**Edge cases:**
- If remaining time ≤ 0: suggest full remaining amount
- If remaining ≤ 0: show ₱0, mark challenge complete

---

## 5. Section B — Data Model Foundations

### B1. Money Representation

All money stored as `int` **centavos** (₱100.00 = `10000`).

### B2. Source of Truth

SavingsRecords are the source of truth. `Challenge.currentAmountCents` is a derived cache.

### B3. Cancelled Challenges & Records

Records preserved. Challenge marked Cancelled. Count toward totals/achievements/XP. **Do not** count toward streak.

### B4. Completed Challenge Reopening

No reopening. Create a new challenge. Record deletion can revert Completed → Active.

### B5. Cancelled Challenge Reactivation

No reactivation. Create a new challenge.

### B6. Paused Status

**Removed from MVP.** Only two transitions:

EOF

---

## 7. Section D — Visual & Interaction Design

### D1. Visual Identity — "Shadow System Window"

**Theme:** Solo Leveling-inspired System Window with neon magenta frames, dark void backgrounds, and holographic panels.

#### Color Palette

| Role | Hex | Usage |
|------|-----|-------|
| Background Void | `#0A0512` | App background |
| Background Indigo | `#150A28` | Behind panels |
| Background Plum | `#1E0F35` | Gradient wash |
| Panel Fill | `rgba(20, 10, 40, 0.88)` | All windows |
| **Frame Outer** | **`#B026FF`** | Neon magenta frame |
| Frame Glow | `rgba(176, 38, 255, 0.5)` | Outer halo |
| Frame Inner | `#E0D4F5` | Thin inner line |
| Text Primary | `#FFFFFF` | Headers, values |
| Text Secondary | `#B8A8D9` | Labels, meta |
| Text Dim | `#6B5A8A` | Disabled, hints |
| Accent Active | `#D44FFF` | Active tabs |
| Success / Stat Green | `#39FF88` | Bonuses, rewards |
| Warning | `#FFB800` | Overdue |
| Danger | `#FF3B4E` | Cancel, delete |
| Gold | `#FFD24A` | XP, badges |
| Progress Gradient | `#B026FF → #FFFFFF` | Bars, rings |

#### Typography

| Use | Font | Weight | Size |
|-----|------|--------|------|
| Window Title | Orbitron | 700 | 20–24 |
| Section Header | Rajdhani | 600 | 14–16 |
| Labels | Rajdhani | 500 | 12–13 |
| Big Numbers | Orbitron | 800 | 40–72 |
| Values / Stats | JetBrains Mono | 500 | 14–32 |
| Body Text | Rajdhani | 400 | 14–16 |
| Bonus Numbers | JetBrains Mono | 700 | 12–14 |

#### Frame Treatment

- **Outer frame:** Thick (~3px) neon magenta border with circuit-line etching
- **Outer glow:** `0 0 24px rgba(176, 38, 255, 0.6)`
- **Inner panel:** Sits ~12px inside, dark fill, thin lavender border
- **Corners:** Chamfered 45° cuts, no border radius
- **Divider:** Thin lavender line with ◆ diamond midpoint

### D2. Tone of Voice — "System Messages"

| Context | Example |
|---------|---------|
| Greeting | `WELCOME BACK, HUNTER MARIA` |
| Check-in prompt | `DAILY QUEST: SAVE ₱100` |
| Check-in success | `SAVINGS RECORDED. +50 XP.` |
| Progress | `42% COMPLETE. 5,800 REMAINING.` |
| Streak | `STREAK: 3 QUESTS CLEARED` |
| Complete | `QUEST COMPLETE. EMERGENCY FUND CLEARED.` |
| Break | `STREAK BROKEN. NEW QUEST AVAILABLE.` |
| Overdue | `⚠ TARGET DATE EXCEEDED.` |
| Empty | `NO ACTIVE QUESTS. ACCEPT ONE?` |
| Error | `ERROR: DATA UNAVAILABLE. RETRY?` |

**Language rules:**
- ALL CAPS for system messages
- "Hunter" as player title
- "Quest" for challenge
- "Reward" for achievement
- "Rank" for level
- Numbers always monospace
- Symbols (`◆` `▲` `♦` `★`) instead of emoji
- Optional "System Voice" toggle in Settings → falls back to friendly tone

### D3. Home Dashboard — "Status Window"


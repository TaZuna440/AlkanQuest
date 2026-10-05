# Schema Reference

Drift schema version: **1**

Auto-generated `app_database.g.dart` will hold actual table classes.
This file is the human-readable reference.

## Tables

| Table | Model | Purpose |
|-------|-------|---------|
| `challenges` | Challenge | All quests |
| `savings_records` | SavingsRecord | All check-ins |
| `user_profile` | UserProfile | Single row |
| `achievements` | Achievement | Static list |
| `notification_log` | NotificationLog | 2/day cap tracking |

## Foreign Keys

- `savings_records.challengeId` → `challenges.id` (cascade delete)
- `notification_log.challengeId` → `challenges.id` (set null on delete)

## Indexes (planned)

- `challenges.status` — for filtering active/completed
- `savings_records.challengeId` — for lookups
- `savings_records.date` — for chronological sort
- `notification_log.sentAt` — for 2/day cap queries

## Migration Strategy

- Version starts at **1**
- Every schema change bumps version + adds `onUpgrade` callback
- Never delete columns directly — mark deprecated, migrate, drop
- Add columns as nullable or with defaults

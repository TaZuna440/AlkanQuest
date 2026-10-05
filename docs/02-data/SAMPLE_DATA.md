# Sample Data

Test fixtures for development and testing.

## Sample User

```json
{
  "id": "user_001",
  "displayName": "Maria",
  "totalXp": 1250,
  "level": 5,
  "rank": "D",
  "currentStreak": 3,
  "longestStreak": 7,
  "unlockedAchievementIds": ["first_ipon", "first_1000", "streak_7"],
  "locale": "en",
  "notificationsEnabled": true,
  "dailyReminderTime": "20:00"
}
```

## Sample Challenge (Active)

```json
{
  "id": "ch_001",
  "name": "Emergency Fund",
  "targetAmountCents": 1000000,
  "currentAmountCents": 420000,
  "frequency": "weekly",
  "status": "active",
  "colorHex": "#B026FF",
  "iconId": "shield"
}
```

## Sample Savings Record

```json
{
  "id": "sr_001",
  "challengeId": "ch_001",
  "amountCents": 10000,
  "date": "2026-10-05T20:15:00Z",
  "note": "Skipped milk tea"
}
```

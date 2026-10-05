# Sample Data

Test fixtures for development and testing.

## Sample User

```json
{
  "id": "user_001",
  "displayName": "Maria",
  "avatarPath": null,
  "totalXp": 1250,
  "level": 5,
  "rank": "D",
  "currentStreak": 3,
  "longestStreak": 7,
  "unlockedAchievementIds": ["first_ipon", "first_1000", "streak_7"],
  "locale": "en",
  "notificationsEnabled": true,
  "dailyReminderTime": "20:00",
  "notificationTypes": {
    "daily": true, "streak": true, "milestone": true,
    "nearCompletion": true, "complete": true
  },
  "notificationDeclineCount": 0
}
{
  "id": "ch_001",
  "name": "Emergency Fund",
  "description": "6 months of expenses",
  "targetAmountCents": 1000000,
  "currentAmountCents": 420000,
  "startDate": "2026-10-01T00:00:00Z",
  "targetDate": "2026-12-31T00:00:00Z",
  "frequency": "weekly",
  "status": "active",
  "colorHex": "#B026FF",
  "iconId": "shield",
  "createdAt": "2026-10-01T08:00:00Z"
}
[
  {
    "id": "sr_001",
    "challengeId": "ch_001",
    "amountCents": 10000,
    "date": "2026-10-05T20:15:00Z",
    "note": "Skipped milk tea",
    "proofPath": "proofs/ch_001/sr_001_1728153300.jpg",
    "proofWidth": 1920,
    "proofHeight": 1080
  },
  {
    "id": "sr_002",
    "challengeId": "ch_001",
    "amountCents": 20000,
    "date": "2026-10-04T18:00:00Z",
    "note": "Payday",
    "proofPath": null
  }
]
{
  "id": "first_ipon",
  "nameEn": "FIRST IPON",
  "nameFil": "UNANG IPON",
  "descriptionEn": "First savings check-in",
  "descriptionFil": "Unang pag-ipon",
  "icon": "coin_stack",
  "xpReward": 100
}

---

### Block 6 — Design Folder

```bash
cat > docs/03-design/README.md << 'EOF'
# Design Reference

Visual tokens for the Shadow System Window theme.

## Files

| File | Content |
|------|---------|
| `COLORS.md` | Full palette |
| `TYPOGRAPHY.md` | Fonts and scales |
| `ICONS.md` | 40 challenge icons |
| `FRAMES.md` | Panel frame spec (to be added) |
| `MOTION.md` | Animation spec (to be added) |

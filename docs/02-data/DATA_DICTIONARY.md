# Data Dictionary

Complete field-level reference. All money is `int` centavos. All dates UTC.

---

## UserProfile

| Field | Type | Nullable | Default |
|-------|------|----------|---------|
| id | String (UUID) | No | — |
| displayName | String (1–24) | No | "HUNTER" |
| avatarPath | String | Yes | null |
| totalXp | int | No | 0 |
| level | int | No | 1 |
| rank | String | No | "E" |
| currentStreak | int | No | 0 |
| longestStreak | int | No | 0 |
| unlockedAchievementIds | List<String> | No | [] |
| locale | String | No | "en" |
| notificationsEnabled | bool | No | false |
| dailyReminderTime | String | No | "20:00" |
| notificationTypes | Map<String, bool> | No | defaults |
| notificationDeclineCount | int | No | 0 |
| lastNotificationPrompt | DateTime | Yes | null |
| createdAt | DateTime | No | now |

---

## Challenge

| Field | Type | Nullable | Default |
|-------|------|----------|---------|
| id | String (UUID) | No | — |
| name | String (1–40) | No | — |
| description | String (≤200) | Yes | null |
| targetAmountCents | int | No | — |
| currentAmountCents | int | No | 0 |
| startDate | DateTime | No | now |
| targetDate | DateTime | No | — |
| frequency | String | No | "daily" |
| status | String | No | "active" |
| colorHex | String | No | "#B026FF" |
| iconId | String | No | "piggy_bank" |
| milestone25Notified | bool | No | false |
| milestone50Notified | bool | No | false |
| milestone75Notified | bool | No | false |
| nearCompletionNotified | bool | No | false |
| completionNotified | bool | No | false |
| createdAt | DateTime | No | now |
| completedAt | DateTime | Yes | null |

---

## SavingsRecord

| Field | Type | Nullable | Default |
|-------|------|----------|---------|
| id | String (UUID) | No | — |
| challengeId | String (UUID) | No | — |
| amountCents | int | No | — |
| date | DateTime | No | now |
| note | String (≤200) | Yes | null |
| proofPath | String | Yes | null |
| proofWidth | int | Yes | null |
| proofHeight | int | Yes | null |
| createdAt | DateTime | No | now |

---

## Achievement

| Field | Type | Nullable |
|-------|------|----------|
| id | String | No |
| nameEn | String | No |
| nameFil | String | No |
| descriptionEn | String | No |
| descriptionFil | String | No |
| icon | String | No |
| xpReward | int | No |

---

## CheckinDraft

| Field | Type | Nullable |
|-------|------|----------|
| challengeId | String | No |
| amountCents | int | Yes |
| note | String | Yes |
| proofTempPath | String | Yes |
| savedAt | DateTime | No |

---

## NotificationLog

| Field | Type | Nullable |
|-------|------|----------|
| id | String (UUID) | No |
| type | String | No |
| challengeId | String | Yes |
| sentAt | DateTime | No |

---

## Rules

- **Money:** `int` centavos. ₱100.00 = `10000`.
- **Dates:** UTC storage, local display.
- **IDs:** UUID v4.
- **Strings:** Trimmed, length-limited per validation rules.

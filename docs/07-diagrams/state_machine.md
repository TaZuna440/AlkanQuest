# Challenge State Machine

## States

- Active - user is working toward the goal
- Completed - target reached
- Cancelled - user ended it

## Transitions

         +----------+
         |  ACTIVE  |
         +----+-----+
              |
     +--------+--------+
     v                 v
+----------+     +-----------+
|COMPLETED |     | CANCELLED |
+----------+     +-----------+
     ^
     | (record deleted,
     |  drops below target)
     +-------- ACTIVE

## Rules

| From | To | Trigger |
|------|-----|---------|
| Active | Completed | Total >= target |
| Active | Cancelled | User cancels |
| Completed | Active | Record deleted, total < target |
| Completed | Cancelled | NOT allowed |
| Cancelled | (any) | Terminal state |

## Not Allowed

- Reactivating cancelled - create new
- Pausing - not in MVP
- Reopening completed - create new

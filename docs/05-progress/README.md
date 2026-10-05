# Progress Tracking

**The source of truth for "what have we actually done?"**

Updated after every working session.

## Files

| File | Purpose |
|------|---------|
| `PROGRESS.md` | Dashboard — overall status at a glance |
| `CURRENT_PHASE.md` | What's being worked on right now |
| `CHANGELOG.md` | Every change, dated |
| `BLOCKERS.md` | Things blocking progress |
| `SESSIONS/` | Optional: one file per session |

## Rules

1. **Every session** updates `CURRENT_PHASE.md`
2. **Every completed task** gets a `CHANGELOG.md` entry
3. **Every blocker** logged in `BLOCKERS.md` with impact + workaround
4. **Every phase completion** updates `PROGRESS.md`
5. Use ISO dates: `2026-10-05`

## Do Not

- Do not edit `04-development/` here — that's the plan
- Do not delete changelog entries — append only
- Do not mark something "done" without acceptance criteria met

## Read First

- [PROGRESS.md](PROGRESS.md) — Where are we?
- [CURRENT_PHASE.md](CURRENT_PHASE.md) — What now?

### [BLOCK-001] Short description
**Logged:** YYYY-MM-DD
**Impact:** High / Medium / Low
**Blocking:** Phase XX — Name
**Description:** What's blocking
**Workaround:** Temporary solution if any
**Resolution:** How it was resolved
**Resolved:** YYYY-MM-DD
# Session — YYYY-MM-DD

**Phase:** XX — Name
**Duration:** ~X hours

## Goal

What we intended to accomplish.

## Done

- [x] Task 1
- [x] Task 2

## Not Done

- [ ] Task 3 (reason)

## Decisions Made

- Decision X because Y

## Next Session

- Task 3
- Task 4

---

### Block 9 — Decisions Folder

```bash
cat > docs/06-decisions/README.md << 'EOF'
# Decision Log & Open Questions

## Files

| File | Purpose |
|------|---------|
| `DECISION_LOG.md` | Every decision with rationale |
| `OPEN_QUESTIONS.md` | Unresolved items |
| `ASSUMPTIONS.md` | Things assumed true (to be verified) |

## Rules

- Every spec ambiguity → decision logged
- Every decision → rationale documented
- Never delete decisions — mark superseded
- Open questions → resolved by adding to DECISION_LOG

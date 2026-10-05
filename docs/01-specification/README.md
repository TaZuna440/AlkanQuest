# Product Specification

Full specification split across sections. Source of truth for what the app does.

## Files

| File | Sections | Content |
|------|----------|---------|
| `sections-a-c.md` | A, B, C | Core mechanics, data model, user flows |
| `sections-d-f.md` | D, E, F | Visual design, onboarding, notifications |
| `sections-g-i.md` | G, H, I | Localization, proof/media, edge cases |
| `sections-j-l.md` | J, K, L | Architecture, backend, business/legal |

## How to Read

- **Building a feature?** Read the relevant section first.
- **Conflicting with spec?** Raise it in `06-decisions/OPEN_QUESTIONS.md`.
- **Spec is silent?** Log a decision in `06-decisions/DECISION_LOG.md`.

## Rules

These are non-negotiable:
1. The app records user-reported savings. Never verify.
2. Never pretend to be a bank.
3. Habit formation is the primary objective.
4. Never shame users.
5. Money is `int` centavos.
6. Never revoke achievements.

See [06-decisions/DECISION_LOG.md](../06-decisions/DECISION_LOG.md) for all decisions.

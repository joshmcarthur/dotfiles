# Decision records

A decision is significant if it involves choosing between approaches, introducing a new dependency, establishing a new pattern, or making a trade-off with future consequences. Minor implementation details do not need a record.

Record the decision before implementing it.

- **Project has `docs/adr/`:** record the decision as an ADR (format below). Lore still holds plans and reference docs. Link to the ADR from lore. Do not copy its content.
- **Project has no `docs/adr/`:** record the decision in the Lore Work's `decisions.md`, with the same Context / Decision / Rationale / Consequences headings. Do not create `docs/adr/`. See `~/.dotfiles/agents/instructions/lore.md`.

ADR format:
```markdown
# ADR-NNN: Title

**Status:** Accepted
**Date:** YYYY-MM

## Context
What situation or requirement prompted this decision.

## Decision
What was decided.

## Rationale
Why this option was chosen over the alternatives, including a summary of trade-offs.

## Consequences
What this decision makes easier or harder going forward.
```

Number ADRs sequentially after the highest existing ADR, and include the ADR in the same commit as the initial implementation.

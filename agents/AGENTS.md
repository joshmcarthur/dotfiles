---
description: Josh's global agent preferences
alwaysApply: true
applyTo: "**"
---

# Workflow

## Plan first, code second

Before touching any files, produce a detailed implementation plan. Do not write code during planning.

The plan must include:
- Summary of the approach and key decisions
- List of files to be created or modified
- Identified commit boundaries (logical, working slices)
- Any trade-offs or alternatives considered

After presenting the plan, use the client's interactive question tool when available (for example, `vscode_askQuestions` in VS Code) to request approval in the chat UI. Offer these single-select options and allow free-text feedback:
- "Yes, approved": approve the presented plan and proceed with implementation.
- "No, stop": do not implement the plan.
- "Change something": use the user's feedback to revise the plan, then request approval again.

Wait for explicit approval before writing any code. An explicit affirmative selection counts as approval; a skipped or dismissed question does not. If the question tool is unavailable, request typed approval ("approved", "proceed", "looks good"). Plan approval does not authorize commits or bypass later approval gates.

## Decisions and durable context

Use git-lore (`refs/lore/<work-id>`) for context that must outlive a session but must not live in the working tree. Use the create-lore, read-lore, edit-lore and sync-lore skills.

- Before planning, look for an existing Lore Work (`git config branch.<branch>.lore`, `git for-each-ref refs/lore`). If one exists, read it first.
- After a plan is approved, record it as `plan.md` in the branch's Lore Work. Create the Work if none exists. Skip this for work that fits in one commit.
- At each commit boundary and phase break, update `plan.md`, and `handoff.md` if the work will continue in another session.
- Put temporary plans, reference docs and investigation notes in lore, not in the working tree or `tmp/`, so they survive builds, cleans and branch switches.
- Apply the lore curation test: would a future developer or agent otherwise have to rediscover this? Do not record conversation or activity logs.
- Do not push lore (sync-lore) without asking.

### Where significant decisions go

A decision is significant if it involves choosing between approaches, introducing a new dependency, establishing a new pattern, or making a trade-off with future consequences. Minor implementation details do not need a record.

- **Project has `docs/adr/`:** record the decision as an ADR (format below). Lore still holds plans and reference docs. Link to the ADR from lore. Do not copy its content.
- **Project has no `docs/adr/`:** record the decision in the Lore Work's `decisions.md`, with the same Context / Decision / Rationale / Consequences headings. Do not create `docs/adr/`.

Record the decision before implementing it.

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

## Commit boundaries

At each commit boundary identified in the plan:
1. Stop coding
2. Write a short summary covering:
   - What changed
   - Why significant decisions were made the way they were
3. Wait for go-ahead before committing or continuing

Do not commit without being asked to. When asked to commit:
- Stage the relevant files
- Write a commit message that reflects the decisions just summarised
- For development projects (local, non-production environments), run a style and security review before committing:
  - Flag any style issues found (formatting, naming, code smells)
  - Flag any security issues found (injection risks, exposed secrets, insecure defaults, OWASP Top 10)
  - If issues are found, summarise them and ask whether to fix before committing or proceed anyway
  - If no issues are found, note that briefly and proceed
- Do not use `--no-verify` or skip hooks

## Staying on plan

If a decision not covered by the approved plan comes up mid-implementation, stop and flag it rather than making a silent choice. Paste the relevant plan section if context is needed. The approved plan is a contract — deviations require explicit sign-off.

## Scope discipline

Only make changes that are directly required by the plan. Do not refactor surrounding code, add comments, improve formatting, or introduce abstractions unless specifically asked. A focused change is easier to review and safer to commit.

## Phase breaks for large features

For multi-phase work, end each phase with a summary of what was completed and any decisions that should carry into the next phase. A fresh session per phase is preferred for large features.

## Talk in ASD-STE100 Simplified Technical English

When you describe work, systems, findings, or options to Josh, write in ASD-STE100 Simplified Technical English.

This is how you talk to him. It is not a rewrite style for published copy.

### Do this

- Use short sentences. One instruction or one fact per sentence.
- Use the active voice.
- Use the same word for the same thing. Do not cycle synonyms.
- Prefer concrete verbs and nouns over abstract ones.
- Put the finding first. Then give the reason.

### Do not do this

- Do not use the copyrighted STE dictionary. Follow the writing rules, not the 900-word list.
- Do not apply this when the humanize skill is rewriting published copy. That skill keeps genre, contractions, and voice.
- Do not apply this inside code, paths, quotes, or error text you did not write.
- Do not flatten a requested voice (essay, joke, marketing) into STE.

### Examples

Bad: "The persistence layer essentially acts as a load-bearing abstraction over the various storage backends, ensuring robustness."

Good: "Postgres stores the records. Redis caches reads. If Redis is down, the app reads from Postgres."

---
name: writing-design-docs
description: Use when writing a software design document, design spec, RFC, or architecture proposal; when deciding whether a project needs a design doc; or when a draft is bloated with implementation detail, missing an objective, or mixing cheap UI choices with hard-to-reverse decisions.
---

# Writing design docs

A design doc records **expensive-to-reverse decisions** so teammates can give feedback before anyone implements the wrong thing. Specify every detail and the design phase *is* the implementation — that defeats the doc.

Adapted from Michael Lynch, [How to Write an Effective Software Design Document](https://refactoringenglish.com/excerpts/write-an-effective-design-doc/) (Refactoring English). Section recipes and RecencyBank examples in [references/sections.md](references/sections.md) are his. This skill is an agent workflow; it is not a substitute for the original essay.

## When to write

Write one if **any** of these are true (two or more → almost certainly):

- Multiple people will coordinate the implementation
- More than ~3 months of full-time work
- The system will run in production for years
- Cross-team collaboration
- Goals or requirements are still ambiguous
- Catastrophic risks you can prevent at design time (security, legal)

Investment can be a one-pager, a long signoff doc, or **zero**. A 4-hour low-risk tweak does not need this skill.

## Filter: cost of being wrong

Keep a decision in the doc only when reversing it after implementation is expensive (language, storage, public API, trust boundaries, data model).

Drop a decision when user feedback can be acted on in hours (pagination, "load more", copy, visual polish). Mention those at most as non-goals or "out of scope," never as designed alternatives.

## Workflow

```
Design doc progress:
- [ ] 1. Decide whether to write
- [ ] 2. List candidate decisions; keep only high-cost ones
- [ ] 3. Pick sections that house those decisions
- [ ] 4. Write first page, then chosen sections
- [ ] 5. Save to the repo's spec path
```

1. Apply **When to write**. If no, stop and say so.
2. List the decisions you are tempted to specify. Keep only high cost-of-being-wrong.
3. From the menu below, include only sections that carry a kept decision. **Omit unused headings** — no `N/A` stubs.
4. Write in the order below. First page must make sense with no verbal briefing.
5. Save to `docs/specs/YYYY-MM-DD-<topic>-design.md` unless the repo already defines a design/spec path or template (`AGENTS.md`, `docs/specs/`, `docs/design/`).

For section jobs, length, and RecencyBank examples, read [references/sections.md](references/sections.md) only for the sections you are including.

## Document (this is the output)

### First page — always

| Section | What it is |
| --- | --- |
| **Title** | Short, distinctive, evocative. RecencyBank, not "Project Flying Silver Horse". |
| **Metadata** | Author (name + email), created date, canonical URL/path, status, approvers if signoff is required. |
| **Objective** | One sentence, plain language, on page one. |
| **Background** | Why this project, what problem, previous attempts. Self-contained. |
| **Related documents** | Links to test plans, related designs, prior iterations — only if they exist. |

### Then — only what you need

| Section | Include when |
| --- | --- |
| **Goals** | Always, once you are writing. Impact on users/team/company, not implementation. "Minimize deploy outages," not "Add Kubernetes." |
| **Non-goals** | Readers might assume extra scope (general-purpose reuse, v2 features). |
| **Scenarios** | The goal is hard to picture (a numbered walkthrough of the finished system). |
| **Diagrams** | Reviewers need data flow, component fit, or dependency/protocol picture. Editable source (Mermaid, D2, Excalidraw, Google Drawings) plus a link to that source — not a whiteboard photo. |
| **Glossary** | External or new-to-team terms. Prefer recognizable words or inline definitions. |
| **Constraints** | Budget, hardware, clients, or dependencies force the design. |
| **SLOs** | Performance/availability/scale must be objective. Numbers, not "performant." |
| **Monitoring / alerting** | You defined SLOs and need to say how production detects misses (including pages). |
| **Timeline** | Stakeholders need milestones. Each milestone is a useful artifact (dummy UI before plumbing). |
| **Interfaces** | UI sketches (not pixel-perfect), API/CLI semantics, or file formats. |
| **Dependencies / infrastructure** | Language, where code runs, where data lives — the hard-to-swap ones. Easy-to-replace vendors can wait. |
| **Security** | Threats, attack surface, trust boundaries. Document "we think this is low risk" too — reviewers catch gaps. |
| **Privacy** | Sensitive data, retention, access, protection (at rest / in transit). |
| **Legal** | Regulated domains, contract limits, or an open-source license choice. |
| **Logging** | Critical events, levels, storage, retention, access, data that must never be logged. |
| **Open issues** | Unsolved flaws, gaps, or forks. Each entry: problem, options, **immediate next step**. |
| **Resolved issues** | Closed open issues, moved here with the decision on top and the original discussion kept. |
| **Alternatives considered** | Strong options a reader will ask "why not X?" A few lines each, not every discarded thought. |

## Shape check (before handing the doc over)

- Objective is one sentence; background stands alone.
- Goals are impact; non-goals name tempting extra scope.
- Cheap-to-change choices are absent from the design (not argued at length).
- No section exists only to look complete.
- Open issues have a next step; alternatives are brief.
- The doc is still a design: swapping an easy dependency later should not require rewriting it.

Rewrite if the draft has `N/A` headings, specifies button labels or pagination, names a tool as a goal, or leaves open issues as TBD.

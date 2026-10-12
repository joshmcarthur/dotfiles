---
name: thermo-nuclear-plan-review
description: Use when reviewing an implementation plan, proposed change, design-before-code, or "should we build it this way" writeup; when a plan looks thorough but large, adds services, layers, or files, or might fit in existing code; when asked for a thermo-nuclear plan review, plan quality audit, code-judo review of a proposal, or a harsh look at a plan before anyone implements it.
---

# Thermo-Nuclear Plan Review

Same maintainability bar as `thermo-nuclear-code-quality-review`, applied to a **proposed** change rather than an enacted diff.

The job is not "is this plan thorough enough to execute?" The job is: **is this the focused, succinct change that achieves the objective, or is there a code-judo move that deletes most of the plan?**

A complete specification of the wrong architecture is still the wrong architecture. Do not ask the author to fill in TDD steps, file paths, or retries for a subsystem that should not be built.

## When to Use

- An implementation plan, RFC-as-plan, or task list exists and someone is about to start coding
- A plan adds packages, services, buses, flags, channels, base classes, or "platform" layers for a single feature
- You wrote the plan and need a gate before handing it off (sunk-cost self-review)
- Someone asks whether the plan is overbuilt, under-engineered, or missing a smaller path through existing code

**Not this skill:** the change is already in a branch → `thermo-nuclear-code-quality-review`. Whether the *product* objective is worth doing. Drafting a plan from scratch (`writing-plans`) — run this *after* a draft exists.

## Core Prompt

> Review this plan as a proposed change against the current codebase.
> Find the smallest change that achieves the stated objective.
> Prefer reusing an existing seam (mailer, policy, helper, canonical layer) over introducing a new subsystem.
> Be ambitious about deleting work from the plan. If a 1-file change hits the goal, the 10-task platform is a failed plan, not a thorough one.
> Measure twice, cut once — nothing has been coded yet, so the cheap move is to reframe now.

## Non-Negotiable Standards

0. **Hunt for the judo first.**
   - Read the existing code the plan would touch *and* the nearby canonical helpers, not only the plan document.
   - Name the focused alternative explicitly, even when you approve ("already the judo").
   - If a path makes whole tasks, types, or layers disappear while preserving the objective, that path *is* the review.

1. **Do not complete the wrong plan.**
   - Verdict `Request changes` means the *shape is right* and details need fixing.
   - If the shape is wrong, verdict is `Reject and reframe`. Do not offer "fully specify the platform" as a reasonable other option.
   - Writing-plans ceremony (TDD steps, exact code in every task, no placeholders) is **secondary**. Ceremony on RecencyBus does not redeem RecencyBus.

2. **Surface area must match the objective.**
   - Count new files, types, infra, flags, and uncalled abstractions the plan would add.
   - A large count against a small objective is a presumptive reject, not a 3-day estimate to honor.
   - Speculative generality (SMS stub, v1.1 channel, "legacy" split, feature flags for one send, base class with one subclass) is YAGNI. Add the second caller when it exists.

3. **Do not let the plan push a file past ~1k lines without decomposition.**
   - Same rule as the code-quality review, applied to the *proposed* edit.
   - Inverse smell: exploding a small change into many new files/modules to avoid editing the right existing one.

4. **Do not plan spaghetti growth.**
   - Copy-pasted `if` guards into several controllers, one-off flags in unrelated flows, or bypassing a canonical policy/helper to "avoid refactoring it this sprint" are design problems.
   - Prefer extending the existing abstraction (policy object, mailer, helper) over going around it.

5. **Keep logic in the canonical layer; reuse what exists.**
   - "Keep the controller skinny" is not a reason to invent a service in front of an existing one-liner pattern.
   - Declaring a working module "legacy" so a parallel tree can be born is a boundary leak, not a migration.

6. **Prefer direct, boring, maintainable structure over a smaller framework.**
   - Trimming SMS and admin UI but keeping the bus + service + channel stack is still the wrong plan.
   - Thin wrappers, identity notifiers, and pass-through "platforms" do not earn their keep.

7. **Treat "we can simplify later" as a reject reason, not a mitigation.**
   - Unused infrastructure becomes load-bearing. The cheap time to delete it is before it is written.
   - Staff authorship, already-socialized estimates, thumbs-up in Slack, and standup awkwardness do not change the shape.

## Primary Questions

- What is the objective in one sentence, independent of the proposed architecture?
- What existing file/helper already does the neighboring job?
- What is the smallest change that hits the objective?
- Which tasks/types/infra in this plan vanish if we take that path?
- Would enacting this plan add branching, flags, or special cases into unrelated flows?
- Would it grow a file past ~1k lines, or scatter a small idea across many new files?
- Are new types earning their keep for *this* objective, or for a hypothetical next one?
- Is logic landing in the canonical layer, or leaking across a new boundary?
- Is this a modest extraction that is still a framework?

## Output (this is the review)

Fill these slots **in this order**. Do not lead with plan-document nits.

1. **Verdict:** `Approve` | `Request changes` | `Reject and reframe`
2. **Judo:** the focused change that achieves the objective (files, existing seam, what disappears). If approving: `already the judo — [one sentence why]`.
3. **Shape:** why the plan's surface area matches or misses the objective, citing existing code.
4. **If enacted:** structural problems the plan would create (spaghetti, 1k-line, boundary leaks, wrapper types, wrong layer). Skip cosmetic nits when shape is wrong.
5. **Document issues (optional):** TDD gaps, placeholders, missing paths — only if the shape is acceptable. Omit entirely on `Reject and reframe`.

Tone: direct, serious, not rude. High-conviction, few comments.

Good phrases:

- `the objective is X; this plan builds Y. use the existing Z seam instead.`
- `these N tasks disappear if we add one method on the type that already does this.`
- `this is a smaller framework, not a smaller change.`
- `do not fully specify this platform — do not build it.`
- `going around RateLimiter to avoid touching it is worse than extending Policy.`
- `already the judo; don't expand this into a platform.`
- `we can simplify later is how this becomes load-bearing.`

## Approval Bar

Approve only when all of these hold:

- no visible smaller path through existing code that still hits the objective
- no new subsystem, base class, or parallel module tree for a single caller
- no planned spaghetti (copied special cases, bypassed canonical helpers)
- no unjustified file-size explosion or file-count explosion
- no speculative flags/channels/retries/buses whose only job is "future"
- planned logic sits in the canonical layer

Presumptive blockers:

- the plan preserves a lot of incidental work when a judo move would delete it
- the plan would push a file from under 1k to over 1k lines, or add many files to avoid one edit
- the plan bolts ad-hoc branches into unrelated flows
- the plan scatters feature checks across shared code instead of one abstraction
- the plan adds wrappers/casts/optionality that the existing pattern does not need
- the plan duplicates a helper or puts logic in the wrong layer
- the reviewer is about to say "approve with nits so the team can start"

If those fail, `Reject and reframe` (wrong shape) or `Request changes` (right shape, fix details). Do not split the difference by keeping a trimmed platform.

## Rationalizations

| Excuse | Reality |
|--------|---------|
| "Needs more detail / fully specify the platform" | Wrong shape. Reframe. Specifying RecencyBus is not a fix. |
| "Modest extraction / keep a smaller platform" | A smaller framework is still a framework. |
| "Staff estimated 3 days / already socialized" | The estimate is a smell, not a reason to keep the work. |
| "We can simplify later" | Unused infra becomes load-bearing. Delete it from the plan. |
| "Next-quarter SMS / v2 justifies the abstraction" | Add the second channel when it is a ticket. |
| "Keep the controller skinny" | One existing-pattern call is already skinny. |
| "Writing-plans says expand TDD / files / steps" | Ceremony on the wrong change is still the wrong change. |
| "Approve with nits so they can start" | Starting the wrong plan is more expensive than an awkward standup. |
| "Don't touch load-bearing X this sprint" | Extending X's extension point ≠ rewriting X. Bypassing X *is* a design change. |
| "I already told them the plan was ready" | Correcting it now is cheaper than an intern implementing it. |

## Red Flags — STOP and reframe

- Top findings are placeholders, TDD, naming, or intern-executability while new packages appear
- Verdict is `ready to implement` or `needs more detail` on a plan that adds a subsystem
- Alternative is `none` while the plan creates uncalled types
- You offered "fully specify the overbuild" as a path forward
- You expanded a one-seam change into a platform so the plan would look "complete"
- You did not open the existing files the plan would touch
- You approved because of seniority, estimate, or Slack thumbs-up
- You kept the bus after dropping the SMS stub and calling it a compromise

## Parent Orchestration

Before invoking this review, gather in one prompt:

1. The plan text (path or paste)
2. The objective in one sentence, if it is not already the plan's Goal
3. Full contents of files the plan would touch, plus nearby canonical helpers (the mailer that already sends, the policy object, the existing service)

Do not review the plan in a vacuum. Do not spawn nested subagents from the reviewer.

## Example

**Objective:** email a password-reset link. **Existing:** `UserMailer#welcome` + `deliver_later`; controller already mints the token. **Plan:** RecencyBus, NotificationService, EmailChannel, SMS stub, Flipper, Redis, admin audit, 10 tasks.

```text
VERDICT: Reject and reframe
JUDO: UserMailer#password_reset + deliver_later from forgot_password.
      RecencyBus, NotificationService, Flipper, Redis, SMS stub, admin UI disappear.
SHAPE: Goal is one transactional email. Welcome already shows the seam.
       A 3-day platform is not a thorough plan for that goal.
IF ENACTED: Parallel mailer tree, uncalled channel interface, flags in front of auth mail.
DOCUMENT ISSUES: omitted (wrong shape)
```

Do not also say "or fully specify the notification platform."

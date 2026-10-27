# Design doc sections

Section jobs and RecencyBank examples adapted from Michael Lynch, [How to Write an Effective Software Design Document](https://refactoringenglish.com/excerpts/write-an-effective-design-doc/) (Refactoring English). RecencyBank is his invented caching-layer example. A fuller public exemplar of his approach: [Little Moments design doc](https://codeberg.org/mtlynch/little-moments/src/branch/master/docs/design/DESIGN.md).

Include a section only when the skill's menu says it houses a kept decision.

## Title

Short, distinctive, evocative — the name people will say out loud.

- Good: RecencyBank (caching layer between app and DB).
- Bad: Project Flying Silver Horse.

## Metadata

```markdown
**URL**: http://go/recency-bank-design
**Author**: Michael Lynch (michael@refactoringenglish.com)
**Created**: 2026-06-22
**Status**: Approved
- alan@ signed off, 2026-07-14
- betty@ signed off, 2026-07-15
```

## Objective

One sentence any stakeholder understands.

> Improve application performance by adding a caching layer between the Trogdor web server and the Postgres database.

## Background

Answer: why this project, what problem, previous attempts. Put anything a cold reader needs on page one.

> When we launched the Trogdor web app in 2023, pages typically loaded in 100ms or less. After three years, median page loads have ballooned to 600ms, which causes users to perceive our app as sluggish.
>
> We investigated the slowdown and discovered that database lookups make up 80% of page load times. As our data store has grown larger, database lookups have gotten slower.
>
> We also discovered that 95% of database lookups are for the same 3% of database rows. This pattern of usage benefits greatly from memory-backed caching. The cache would serve frequently-accessed data faster and reduce database load for all other queries.

## Related documents

Bulleted links only.

> - **Testing plan**: http://go/recency-bank-test-plan
> - **Trogdor performance report**: http://go/trogdor-perf-2026

## Goals

Impact, not internals.

- Bad: Add Kubernetes to our infrastructure.
- Good: Minimize outages related to deploying new app versions.

> - Increase user-perceived responsiveness for Trogdor web app.
> - Reduce database server load.

## Non-goals

Scope readers might wrongly assume.

> - Create a general-purpose, reusable caching system — The caching layer we add to the Trogdor web app will make application-specific optimizations. Re-using this cache on other systems is out of scope.
> - Location-aware caching — It may be useful in the future to support caches that sit geographically close to the end user to reduce latency, but that is out of scope of v1.

## Scenarios

Numbered story of the finished system.

> **Scenario: Share a report via URL**
> 1. Bob creates a custom report in his KeyMetrics dashboard.
> 2. Bob navigates to the menu bar and clicks "Share > as URL."
> 3. Bob emails the URL to his teammate, Charlie.
> 4. Charlie clicks the link and sees an exact copy of Bob's report in read-only mode.

## Diagrams

Show data flow, how components fit, interactions with dependencies/clients, and protocols. Use an editable tool (Excalidraw, draw.io, Google Drawings, Mermaid, D2, Graphviz). Link the source drawing or code.

## Glossary

Define terms a new teammate or partner team will not know. Prefer ordinary words or inline definitions so readers do not jump around.

> - **Apposaurus**: the team's internal load testing tool.

## Constraints

Imposed limits that explain otherwise-odd choices.

> Our servers are all RISC-V, so all code and dependencies must run on RISC-V architecture.

## Service level objectives (SLOs)

Concrete metrics. SLAs are SLOs plus money; inside a company, write SLOs.

Typical axes: uptime/availability, latency, scale.

> - Trogdor's 50th percentile latency for user-facing HTTP requests: <=200ms
> - Postgres 50th percentile query latency: <= 80ms

## Monitoring / alerting

How you learn the SLOs are missed. What pages the on-call?

> The following events will trigger a page to the on-call engineer:
>
> - Trogdor's 95th percentile latency for user-facing HTTP requests: >= 3s
> - Average CPU usage for Postgres servers during trailing 2m window: >= 90%

## Timeline

Milestones that produce artifacts stakeholders can react to (dummy data in a UI before production plumbing).

> - **Milestone 1 (2026-07-01)**: RecencyBank is live in the test environment with a hardcoded subset of cached data (doesn't read from Postgres).
> - **Milestone 2 (2026-07-17)**: RecencyBank is live in the test environment and caches real data from Postgres.
> - **Milestone 3 (2026-08-03)**: RecencyBank is live in the test environment and enforces cache eviction and lifecycle rules.
> - **Milestone 4 (2026-08-22)**: RecencyBank is fully implemented and deployed to production.

## Interfaces

- GUI: simple sketches, not pixel-perfect UI.
- Software: API or CLI semantics.
- Files: the format.

RecencyBank example: introduce a `Store` interface matching the existing `PostgresDB` surface, wrap it with a cache, change one field type on `Server`. Do not paste the cache's internals.

## Dependencies / infrastructure

Language, hardware/service, persistence. Dwell on what is painful to change later (language, storage backend), not an email vendor you can swap in an afternoon.

> - **Language**: Go — We widely use Go already, and it's a suitable language for serving highly parallel workflows.
> - **Third-party packages** — bbolt: a widely used key-value store that implements many of the features we need for RecencyBank.

## Security

Threats considered, attack surface, trust boundaries (browser → server is one). Even "unlikely" deserves the rationale.

> RecencyBank must not accept direct requests from the public Internet, as it does not enforce any access control.
>
> RecencyBank will run on a segregated network where it only accepts inbound requests from the Trogdor web server and can only make outbound requests to the Postgres server pool.

## Privacy

Sensitive data, retention, who can access it, how it is protected.

> RecencyBank contains the same sensitive user data as the Postgres database, so it inherits the privacy policy of our Postgres systems. In particular, engineers may only access RecencyBank systems in production with an associated bug number.

## Legal considerations

Regulated domains, contracts, "what if this goes awry," OSS license choice.

## Logging

Critical events, levels, where logs live, retention, access, secrets to exclude.

> RecencyBank logs the following events:
>
> - At initialization, logs the parameters used to initialize RecencyBank as well as RAM capacity and usage on the host.
> - Persisting a value in memory fails.
> - Invalidating the cache fails.

## Open issues

Each entry:

1. What needs more work
2. Options
3. Immediate next step

> **Open Issue: Choosing RAM size for cache**
>
> We need to decide how much RAM to assign to our caching layer. Adding RAM increases performance, but RAM is expensive, and there are diminishing returns.
>
> I estimate the cost of creating a test environment and running a single simulation to be 3.0 dev days. Additional simulations ~0.75 dev days each.
>
> **Proposed solution**: Choose 128 GB of RAM without testing. It's probably close to optimal, and dev time is significantly more expensive than RAM.
>
> **Next step**: Ask our tech lead to weigh in.

## Resolved issues

Move the open issue here. Put **Decision** first; keep the original discussion.

> **Decision**: Provision 128 GB of RAM to the caching layer. If we're failing to meet our performance goals and we're RAM-constrained, we can add more RAM at that point.

## Alternatives considered

A few brief lines for strong, tempting options.

> - Google Cloud Firestore (persistent storage) — Durability and reliability were appealing, but I disliked the platform lock-in and the difficulty of testing locally.

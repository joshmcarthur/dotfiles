---
name: reviewing-prs-by-theme
description: >-
  Use when reviewing a large, mixed, or hard-to-scan pull request; when the user
  wants to read a PR in parts by area (architecture, data model, templates, CSS, JS);
  when they ask to skip mundane, generated, lockfile, or snapshot changes; or when
  they ask to post a collapsible themed review on a GitHub pull request.
---

# Reviewing PRs by theme

A **themed briefing** of a pull request. Group the diff by area so a human can read the important parts and skip the mundane. Map first. Findings second, and only when they are real.

This is not a quality-lens audit (security / correctness / a11y as top-level sections). It is not `thermo-nuclear-code-quality-review`. If the user asks for that audit, run that skill.

## When to use

- Large or mixed PR, hard to see what matters
- User wants to read it in parts, skip lockfiles/generated noise, or group by architecture / data model / templates / CSS / JS
- User asks to post a collapsible themed review on the PR

**Not this skill:** harsh maintainability audit → `thermo-nuclear-code-quality-review`. Fixing the PR. Editing the reviewed repo.

## Workflow

1. Resolve the target: PR URL, number, or current branch vs base. Fetch with `gh` / `git diff`. Read title, body, file list, and stats **before** writing themes.
2. Classify each file by **role**, not extension (`models.py` → data model, `urls.py` → architecture).
3. Derive themes from files that exist. Drop empty themes. Put lockfiles, generated files, vendor, snapshots, locale dumps, and formatting-only edits in **Mechanical**.
4. Rank: **Read** (behavior, contracts, data, architecture) → **Skim** (wiring, tests as evidence) → **Skip** (mechanical).
5. Report in chat using the recipe below.
6. Post to GitHub **only if the user asked to post**. "Review this PR" is not permission to post.

If more than ~15 non-mechanical files, review each Read theme in parallel, then synthesize into one report.

## Chat report (this is the output)

Fill these slots **in this order**. Use markdown headings. Do not use `<details>` in chat (it renders poorly).

1. **Map** — PR identity, one sentence on what it does, then Read / Skim / Skip lists with file counts.
2. **Read first** — one heading per Read theme: what changed, why it matters, files, then any real findings.
3. **Skim** — short.
4. **Skip** — mechanical names and line counts only. Do not review them as product code.

Put findings under the theme they belong to. Prefer a few real findings over a category checklist. No finding list when nothing is real.

Do not add CSS, a11y, security, or other headings because a thorough review "should cover every category." If CSS files did not change, there is no CSS theme.

## Posting (only when asked)

Observable predicate: the user asked to post, publish, or put the review on the PR.

If they did **not** ask: stay in chat. Do not "also drop it on the PR so the team can see it."

If they **did** ask: post **one conversation comment**. Do not open a GitHub review. Do not submit inline comments. Do not send `REQUEST_CHANGES` / `APPROVE` unless the user asked for a review verdict.

Prefix the comment with `🤖 ` (see `agents/AGENTS.md`). Keep tags at column 0. Blank line after every `</summary>`. No `open` attribute — every theme starts collapsed. Nested `<details>`: theme → files / findings. Visible body is only the map (Read / Skim / Skip + counts). If the comment would exceed ~65k characters, drop the mechanical file list first. Do not `@` people.

```markdown
🤖 Themed review of #123. Open a section to read it.

**Read:** Architecture (3 files), Data model (2)
**Skim:** Tests (1 file)
**Skip:** Mechanical (12 files, +3400)

<details>
<summary>Read — Architecture (3 files)</summary>

What changed and why it matters.

<details>
<summary>Files</summary>

- `config/urls.py`
- `app/services/billing.py`

</details>

<details>
<summary>Finding — billing bypasses Policy</summary>

Evidence and a specific fix.

</details>

</details>

<details>
<summary>Skip — Mechanical (12 files, +3400)</summary>

- `yarn.lock` (+3100)

</details>
```

## Theme starters (not a locked catalog)

Keep a name only if the diff has files for it. Add a PR-specific theme when a cluster does not fit (jobs, GraphQL, permissions).

| Theme | Role |
| --- | --- |
| Architecture | New apps, routes, settings, service boundaries, permissions, layering |
| Data model | Models, migrations, schema, serializers |
| Templates | HTML, Django/ERB/Slim, view components |
| CSS | css, scss, less, tailwind |
| JS | js, ts, Stimulus, Turbo, packs |
| Tests | Specs as evidence, not a style pass |
| Config / CI | Workflows, package manifests, env |
| Mechanical | Lockfiles, generated, vendor, snapshots, i18n dumps, formatting-only |

## Rationalizations

| Excuse | Reality |
| --- | --- |
| "Cover every category so nothing slips" | Categories come from the file list. Empty CSS/a11y/security headings are noise. |
| "A CSS heading with n/a is complete" | Omit the theme. |
| "Post it so the team isn't blocked" | Post only when asked, and then one collapsed comment, not a review with inlines. |
| "Inline comments are more useful" | Inlines spam every reviewer. Nested `<details>` is the post format. |
| "REQUEST_CHANGES makes the blocker visible" | Verdict events only if the user asked for a review verdict. |
| "yarn.lock deserves a real review section" | Mechanical: name, line count, skip. |

## Red flags — stop and rewrite

- Top-level Security / Correctness / Accessibility / CSS sections on a themed briefing
- A theme with "no issues" / "n/a" because the area did not change
- Lockfile or snapshot reviewed as if it were architecture
- Posted to the PR without the user asking
- GitHub **review** with inline comments, or `REQUEST_CHANGES`, when asked only to post
- Visible PR comment longer than the map (theme bodies not in `<details>`)
- `<details>` indented (becomes a code block) or no blank line after `</summary>`

## Common mistakes

- File-by-file dump instead of a map + Read themes
- Quality-lens report cloned from generic PR-review skills
- Filling empty themes to look thorough
- Auto-posting the chat transcript

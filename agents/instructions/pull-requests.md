# Pull requests

If the project has a pull request template (`.github/pull_request_template.md`, `.github/PULL_REQUEST_TEMPLATE/`, `docs/pull_request_template.md` or `pull_request_template.md` at the root), follow it. Otherwise use the format below.

PRs are usually squash merged, and the title and body become the commit message. Write for a developer who reads `git log` months later. Be succinct. Leave out anything that only matters during review.

**Title:** the ticket number and a short summary (for example `ABC-123: Hide archived items from search`). If there is no ticket, use a conventional commit title (for example `fix: hide archived items from search`).

**Body:**
```markdown
## What
What the change is.

## Why
Why the change is being made. If other options were explored, say why this one was chosen.

## How
How the change resolves the issue or adds the feature.

## Evidence
Proof that the change works: a screenshot, a recording, test output or a snippet of command output. If no evidence is possible, say why in one line.
```

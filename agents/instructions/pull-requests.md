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
Proof that the change works: a screenshot, a recording, test output or a snippet of command output. If no evidence is possible, say why in one line. For images and videos, see "Images and screenshots".
```

## Images and screenshots

Attach images and videos with `gh pr create`, `gh pr edit` or `gh pr comment` and the `--attach` flag. The CLI uploads the file and puts the URL in the body. You need push access to the repository.

- Do not commit images to the repository. Do not use a third-party image host.
- Write `![alt text](local/path.png)` in the body. Pass the same file to `--attach`. The CLI replaces the local path with the uploaded URL. A file that the body does not reference goes at the end of the body.
- Always write alt text. Say what the image shows. Videos have no alt text.
- Put a video reference (`![](local/path.mp4)`) alone in its paragraph. Inside a sentence, it renders as a link and not as a player.
- Repeat `--attach` for more files. You cannot attach the same file twice.
- `--attach` accepts image and video files only (png, gif, jpg, jpeg, svg, mp4, mov, webm). For other evidence, paste the output as text.
- To add evidence after the PR exists, use `gh pr edit` or `gh pr comment` with `--attach`.

### Grouping screenshots

Show one or two key screenshots in the open, directly under `Evidence`. For three or more screenshots, or for large ones, put them in a collapsed `<details>` block:

```markdown
<details>
<summary>Search results page, before and after</summary>

![Before: archived items shown](before.png)
![After: archived items hidden](after.png)

</details>
```

- Write a `<summary>` that says what the group shows. Do not write only "Screenshots".
- Leave a blank line after `</summary>` and before `</details>`. Without the blank lines, GitHub does not render the Markdown inside the block.
- Use one `<details>` block for each topic, for example one for each page or each before and after pair. Do not put all images in one block.
- Pass every image in the group to `--attach`.

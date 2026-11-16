# gh and issue templates

Use `gh`. Prefer `--body-file` for issue bodies and comments. Do not pass secrets on `--body`.

```text
gh issue list --state open --json number,title,labels,assignees,parent,subIssues,blockedBy
gh issue view N --comments
gh issue create --title T --body-file path --label L --parent N --blocked-by N
gh issue comment N --body-file path
gh pr create --title T --body-file path
gh label list
```

`--parent`, `--blocked-by`, and `--add-sub-issue` are native relationships. Do not fake them with a `sub-issue` label or a markdown epic. Do not use `-T` (it collides with `--template`).

## Templates

Read the **target** repo, in order: `.github/ISSUE_TEMPLATE/`, then org templates if the repo has none. Follow what is there. Do not author templates.

YAML forms: write answers as markdown headings matching the field labels, in a body file. Apply only labels that already exist (`gh label list`). Template default labels apply only if those labels already exist; create nothing new.

If the repo has no templates, write a short human issue: problem, why it matters, acceptance criteria. Still apply only existing labels.

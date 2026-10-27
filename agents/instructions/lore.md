# Lore

Use git-lore (`refs/lore/<work-id>`) for context that must outlive a session but must not live in the working tree. Use the create-lore, read-lore, edit-lore and sync-lore skills.

- Before planning, look for an existing Lore Work (`git config branch.<branch>.lore`, `git for-each-ref refs/lore`). If one exists, read it first.
- After a plan is approved, record it as `plan.md` in the branch's Lore Work. Create the Work if none exists. Skip this for work that fits in one commit.
- At each commit boundary and phase break, update `plan.md`, and `handoff.md` if the work will continue in another session.
- Put temporary plans, reference docs and investigation notes in lore, not in the working tree or `tmp/`, so they survive builds, cleans and branch switches.
- Apply the lore curation test: would a future developer or agent otherwise have to rediscover this? Do not record conversation or activity logs.
- Do not push lore (sync-lore) without asking.

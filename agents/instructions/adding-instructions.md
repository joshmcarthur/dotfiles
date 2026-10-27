# Adding instructions

`~/.dotfiles/agents/AGENTS.md` is loaded into every session of every tool. Keep it short.

- Put a rule inline in `AGENTS.md` only if it applies to every task. Put everything else in `~/.dotfiles/agents/instructions/<kebab-case-name>.md`.
- Add one line per file to the "Situational instructions" list in `AGENTS.md`, in this format: "<trigger>: read `<path>`".
- Write the trigger as a concrete moment or observable state that an agent can recognise. Good: "Before you create a pull request, or change its title or body". Bad: "PR conventions". One line can hold several triggers.
- Use full `~/.dotfiles/...` paths, in the index and between instruction files. Never use relative links: every tool reads `AGENTS.md` through a symlink, so relative paths can resolve against the wrong folder.
- Make each file make sense on its own. Do not add frontmatter.
- The dotfiles repo is public. Leave out secrets, client names and private project details.

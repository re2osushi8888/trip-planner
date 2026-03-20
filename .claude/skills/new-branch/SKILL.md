---
name: new-branch
description: Guide the developer through the full new-branch workflow. Use when the user wants to create a new branch, start work on an issue, or says things like "ブランチを切る", "start working on", "new branch for issue", or "create a branch".
invocable: true
---

# New Branch Workflow

This skill guides you through creating a new branch linked to a GitHub Issue.

## Steps

1. **Confirm the Issue** — Ask for the issue number if not provided. Run `gh issue view <number>` and show the title/labels to the user.
2. **Suggest Branch Prefix** — Present `feat` / `fix` and recommend one. See [prefix guide](references/prefix-guide.md).
3. **Determine Branch Name** — Use `<prefix>/<issue-number>-<short-description>` (2–5 kebab-case words from the title). Confirm with the user.
4. **Fetch Latest Main** — Run `git fetch && git checkout main && git pull origin main`.
5. **Create Branch** — Run `git checkout -b <branch-name>`.
6. **Push Immediately** — Run `git push -u origin <branch-name>`.
7. **Link to Issue** — Run `gh issue develop <issue-number> --name <branch-name>`.

After all steps, show the [summary output](references/summary-output.md).

## Error Handling

See [error handling guide](references/error-handling.md).

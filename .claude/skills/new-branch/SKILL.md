---
name: new-branch
description: Guide the developer through the full new-branch workflow. Use when the user wants to create a new branch, start work on an issue, or says things like "ブランチを切る", "start working on", "new branch for issue", or "create a branch".
invocable: true
---

# New Branch Workflow

This skill guides you through creating a new branch that is properly linked to a GitHub Issue.

---

## Steps

### Step 1: Confirm the Issue

Ask the user for the issue number if not already provided.

Run the following to verify the issue exists:

```bash
gh issue view <issue-number>
```

Show the issue title and labels to the user to confirm it is the correct one.

### Step 2: Suggest Branch Prefix

Based on the issue labels and title, suggest a branch prefix from the list below. **Present all options and recommend one.**

| Prefix     | When to use                                |
| ---------- | ------------------------------------------ |
| `feat`     | New feature or capability                  |
| `fix`      | Bug fix                                    |
| `chore`    | Maintenance, tooling, dependency updates   |
| `docs`     | Documentation only                         |
| `refactor` | Code restructuring without behavior change |

**How to recommend:**

- Label `bug` → recommend `fix`
- Labels `enhancement`, `story`, `epic` → recommend `feat`
- Labels `deps`, `config`, `ci` → recommend `chore`
- Label `documentation` → recommend `docs`
- No clear label → ask the user to choose

Present the options using `AskUserQuestion` with the recommended option listed first and marked "(Recommended)".

### Step 3: Determine Branch Name

Construct the branch name using the following convention:

```
<prefix>/<issue-number>-<short-description>
```

- `short-description`: 2–5 words in kebab-case, derived from the issue title
- Example: `feat/97-new-branch-skill`

Confirm the branch name with the user before proceeding.

### Step 4: Fetch and Checkout Latest Main

```bash
git fetch
git checkout main
git pull origin main
```

### Step 5: Create the Branch

```bash
git checkout -b <branch-name>
```

### Step 6: Push to Remote Immediately

```bash
git push -u origin <branch-name>
```

This makes the branch visible on GitHub right away.

### Step 7: Link Branch to Issue Development

```bash
gh issue develop <issue-number> --name <branch-name>
```

This links the branch to the GitHub Issue's Development section.

---

## Summary Output

After completing all steps, show the user a summary:

```
Branch created and linked to issue.

Issue:  #<number> - <title>
Branch: <branch-name>
Remote: pushed to origin/<branch-name>
GitHub: branch linked to issue #<number> development
```

---

## Error Handling

- **Issue not found**: Stop and ask the user to verify the issue number.
- **Working tree is dirty**: Warn the user and ask them to stash or commit changes before proceeding.
- **Branch already exists**: Inform the user and ask whether to use the existing branch or choose a different name.
- **`gh` not authenticated**: Prompt the user to run `gh auth login`.

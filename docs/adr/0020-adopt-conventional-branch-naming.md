# 0020. Adopt Conventional Branch Naming with feat/ and fix/ Prefixes

Date: 2026-03-20
Status: Accepted

## Context

The project already adopts Conventional Commits (ADR-0003) for commit message validation and Trunk-Based Development (ADR-0018) for branching strategy. Branch names, however, had no formal convention, leading to inconsistency across contributors.

When introducing a Claude Code skill (`/new-branch`) to guide developers through the branch creation workflow, a branch naming convention needed to be established so the skill could present a concise, unambiguous choice to the developer.

Conventional Commits defines the following types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, and others. Mapping all of these to branch prefixes would create too many options for day-to-day use.

## Decision

We adopt a two-prefix branch naming convention aligned with Conventional Commits, using only the two most common types:

```
<prefix>/<issue-number>-<short-description>
```

| Prefix | When to use                                      |
| ------ | ------------------------------------------------ |
| `feat` | New features, enhancements, stories, and tooling |
| `fix`  | Bug fixes                                        |

**Examples:**

- `feat/97-new-branch-skill`
- `fix/42-resolve-auth-timeout`

**Rationale for limiting to two prefixes:**

- Branches are short-lived in Trunk-Based Development; granular categorisation adds little value at the branch level
- Conventional Commits type granularity belongs in the commit message, not the branch name
- Two options reduce cognitive load and make the `/new-branch` skill interaction faster

**Alternatives considered:**

- **Full Conventional Commits prefix set** (`feat`, `fix`, `docs`, `refactor`, `chore`, etc.): Rejected because it introduces unnecessary decision overhead for short-lived branches. The commit message already captures the semantic type.
- **No prefix convention** (free-form branch names): Rejected because it creates inconsistency and makes automated tooling harder to build.

## Consequences

**Positive:**

- Branch names are consistent and predictable across all contributors
- The `/new-branch` skill can offer a fast two-option prompt, reducing friction
- Aligns with the existing Conventional Commits investment

**Negative:**

- Branches for `docs`, `refactor`, `chore`, and other types must use `feat/`, which is a slight semantic mismatch; developers may find this counterintuitive at first

**Neutral:**

- The issue number in the branch name (`feat/<issue>-*`) retains traceability regardless of prefix choice
- Commit messages remain the authoritative record of change type

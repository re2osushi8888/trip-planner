# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) for the trip-planner project.

## About ADRs

ADRs document important architectural decisions made during the project, including the context, the decision itself, and its consequences. This helps team members understand why certain choices were made and provides historical context for future decisions.

## Index

| Number                                                               | Title                                                          | Status                  | Date       |
| -------------------------------------------------------------------- | -------------------------------------------------------------- | ----------------------- | ---------- |
| [0001](0001-record-architecture-decisions.md)                        | Record Architecture Decisions                                  | Accepted                | 2026-03-12 |
| [0002](0002-do-not-adopt-adr-tools.md)                               | Do Not Adopt adr-tools for ADR Management                      | Accepted                | 2026-03-13 |
| [0003](0003-adopt-commitlint-for-commit-message-validation.md)       | Adopt commitlint for Commit Message Validation                 | Accepted                | 2026-03-13 |
| [0004](0004-adopt-ls-lint-for-file-naming-conventions.md)            | Adopt ls-lint for File Naming Conventions                      | Accepted                | 2026-03-13 |
| [0005](0005-adopt-monorepo-with-pnpm-workspaces-and-turborepo.md)    | Adopt Monorepo Architecture with pnpm Workspaces and Turborepo | Accepted                | 2026-03-13 |
| [0006](0006-adopt-lefthook-for-git-hooks-management.md)              | Adopt Lefthook for Git Hooks Management                        | Accepted                | 2026-03-13 |
| [0007](0007-adopt-oxlint-and-oxfmt-for-linting-and-formatting.md)    | Adopt oxlint and oxfmt for Linting and Formatting              | Accepted                | 2026-03-13 |
| [0008](0008-adopt-mise-for-development-tool-version-management.md)   | Adopt mise for Development Tool Version Management             | Accepted                | 2026-03-13 |
| [0009](0009-adopt-aikido-safe-chain-for-supply-chain-protection.md)  | Adopt Aikido Safe Chain for Supply Chain Protection            | Accepted                | 2026-03-13 |
| [0010](0010-adopt-epic-story-task-hierarchy-for-issue-management.md) | Adopt Epic-Story-Task Hierarchy for Issue Management           | Accepted                | 2026-03-17 |
| [0011](0011-adopt-skill-creator-plugin-for-skill-development.md)     | Adopt skill-creator Plugin for Skill Development               | Accepted                | 2026-03-17 |
| [0012](0012-adopt-vite-plus-for-unified-toolchain.md)                | Adopt Vite+ for Unified Toolchain                              | Accepted (Experimental) | 2026-03-18 |
| [0013](0013-adopt-react-spa-with-vite-plus.md)                       | Adopt React SPA with Vite+                                     | Accepted                | 2026-03-18 |
| [0014](0014-use-lefthook-for-git-hooks-instead-of-vite-plus.md)      | Use Lefthook for Git Hooks Management Instead of Vite+        | Accepted                | 2026-03-18 |

## ADR Lifecycle

- **Proposed**: Under consideration
- **Accepted**: Approved and ready for implementation
- **Rejected**: Considered but not adopted
- **Deprecated**: No longer applicable
- **Superseded**: Replaced by another ADR (with reference)

## Creating New ADRs

Use the `/adr` command to interactively create a new ADR from your conversation with Claude.

Alternatively, copy the template and follow the naming convention:

```bash
cp docs/adr/0000-template.md docs/adr/XXXX-your-decision.md
```

Replace `XXXX` with the next sequential number (zero-padded to 4 digits).

## Format

Each ADR follows this structure:

```markdown
# {Number}. {Title}

Date: YYYY-MM-DD
Status: {Proposed|Accepted|Rejected|Deprecated|Superseded}

## Context

What is the issue we're facing?

## Decision

What decision have we made?

## Consequences

What are the results of this decision (positive, negative, and neutral)?
```

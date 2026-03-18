# 0003. Adopt commitlint for Commit Message Validation

Date: 2026-03-13
Status: Accepted

## Context

The trip-planner project requires consistent and meaningful commit messages to maintain a clear project history. As the project grows and potentially involves multiple contributors, several challenges emerge:

- **Inconsistent formatting**: Without enforcement, commit messages vary widely in style and quality
- **Poor searchability**: Unstructured messages make it difficult to find specific changes in git history
- **International collaboration**: Mixed-language commit messages hinder team collaboration
- **Changelog generation**: Manual changelog creation is time-consuming and error-prone
- **Context loss**: Vague commit messages lose important context about why changes were made

The project needed a way to enforce commit message standards automatically without relying on manual code review.

## Decision

We will adopt **commitlint** with the Conventional Commits specification to enforce commit message standards.

**Implementation:**

- Use `@commitlint/cli` with `@commitlint/config-conventional` as the base ruleset
- Integrate with lefthook to run validation on commit-msg hook
- Add custom rules for project-specific requirements:
  - **English-only enforcement**: Custom plugin to reject non-ASCII characters
  - **Scope enumeration**: Predefined scopes aligned with project structure (api, web, auth, trip, etc.)
  - **Scope casing**: Enforce kebab-case for multi-word scopes
- Provide interactive commit prompt via commitizen (`pnpm commit`)

**Configuration highlights:**

```
Format: <type>(<scope>): <subject>
Types: feat, fix, docs, chore, refactor, test, etc.
Scopes: api, web, auth, trip, booking, docs, config, etc.
Language: English only (enforced by custom rule)
```

**Alternatives considered:**

- **Manual code review only**: Rejected because it's not scalable, inconsistent, and catches issues too late in the workflow

- **Git hooks without commitlint**: Rejected because custom validation scripts would require maintenance and lack community standards

- **No enforcement**: Rejected because it would lead to inconsistent commit history, making it difficult to track changes, generate changelogs, or understand project evolution

- **Alternative hook managers (husky)**: Chose lefthook instead for lighter weight and better performance

## Consequences

**Positive:**

- Consistent commit message format across the entire project
- Automated enforcement at commit time prevents non-compliant messages
- Clear categorization via scopes makes it easy to filter changes by area
- Enables automated changelog generation from commit history
- English-only rule ensures accessibility for international contributors
- Interactive prompt (`pnpm commit`) guides contributors through proper message creation
- Conventional Commits format is widely adopted and well-documented

**Negative:**

- Learning curve for contributors unfamiliar with Conventional Commits
- Blocked commits require message rewriting, which can interrupt workflow
- Scope list requires maintenance as project structure evolves
- Custom English-only rule may occasionally flag false positives (URLs, code snippets)

**Neutral:**

- Commit messages become more verbose but more informative
- Team must agree on appropriate scopes and keep them updated
- Pre-commit hooks add a small amount of time to each commit (typically <1 second)

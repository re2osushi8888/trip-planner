# 14. Use Lefthook for Git Hooks Management Instead of Vite+

Date: 2026-03-18
Status: Accepted

## Context

Vite+ is a unified toolchain that includes built-in git hooks functionality through `vp staged` and configuration options. While Vite+ aims to provide a complete development workflow, we encountered several critical issues when attempting to use its git hooks features:

1. **commitlint Integration**: Vite+ does not support running commitlint for commit message validation. Our project requires strict commit message conventions enforced by commitlint, which is essential for maintaining a clean git history.

2. **Hook Conflicts**: Vite+ and Lefthook cannot coexist peacefully. Both tools attempt to manage git hooks, leading to conflicts where hooks fail to execute properly or override each other.

3. **Customization Limitations**: Vite+ hooks are designed for standard workflows and lack the flexibility needed for project-specific requirements. Lefthook provides more granular control over hook execution, including parallel execution, glob patterns, and conditional execution.

We already have Lefthook successfully configured (ADR-0006) with:

- Pre-commit hooks for linting, formatting, type checking, and file naming
- Commit-msg hooks for commitlint validation
- Parallel execution for faster hook runs

## Decision

We will continue using **Lefthook** for all git hooks management and will not adopt Vite+ hooks functionality.

Our git hooks workflow:

- Pre-commit: `vp check --fix` (via Lefthook), `ls-lint`, `type-check`
- Commit-msg: `commitlint`

Vite+ will be used only for its core toolchain features (dev, build, test, lint, fmt) but not for git hooks orchestration.

**Alternatives considered:**

- **Vite+ Hooks Only**: Rejected due to lack of commitlint support and insufficient customization options for our multi-stage validation requirements.

- **Husky**: Previously considered but Lefthook was chosen in ADR-0006 for its superior performance (Go-based vs Node.js-based), native parallel execution, and better monorepo support.

- **Custom Shell Scripts**: Rejected due to maintenance burden and lack of features like parallel execution, glob patterns, and skip mechanisms that Lefthook provides.

## Consequences

**Positive:**

- Maintain commitlint integration for enforcing commit message conventions
- Preserve existing Lefthook configuration that works reliably
- Retain flexibility for complex hook workflows (parallel execution, conditional hooks)
- Avoid hook conflicts between tools
- Keep separation of concerns: Vite+ for build tooling, Lefthook for git workflow

**Negative:**

- Cannot fully leverage Vite+'s unified toolchain vision (hooks remain separate)
- Need to maintain two tools instead of one
- Vite+ `staged` command and related hooks configuration go unused
- Slight increase in dependency count

**Neutral:**

- Lefthook configuration must be manually kept in sync with Vite+ commands (e.g., updating from `pnpm` to `vp` commands)
- Team members need to understand both Vite+ and Lefthook configurations

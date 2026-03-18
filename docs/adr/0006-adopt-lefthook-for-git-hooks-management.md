# 0006. Adopt Lefthook for Git Hooks Management

Date: 2026-03-13
Status: Accepted

## Context

The trip-planner project requires automated quality checks to run before code is committed or pushed to the repository. Several tools need to be integrated into the Git workflow:

- **Commit message validation**: commitlint enforces Conventional Commits format (ADR 0003)
- **File naming conventions**: ls-lint ensures consistent file naming (ADR 0004)
- **Linting and formatting**: ESLint and Prettier maintain code quality
- **Type checking**: TypeScript compiler validates type safety
- **Testing**: Unit and integration tests must pass before pushing

Without a Git hooks manager, these challenges emerge:

- **Manual setup**: Each developer must manually configure Git hooks, leading to inconsistency
- **No version control**: Native `.git/hooks` scripts are not tracked in the repository
- **Maintenance burden**: Updating hooks requires coordinating across all team members
- **Limited flexibility**: Native Git hooks lack features like parallel execution, file filtering, and conditional logic
- **Cross-platform issues**: Shell scripts may not work consistently across different operating systems

The project needed a lightweight, version-controlled solution to manage Git hooks consistently across all development environments.

## Decision

We will adopt **lefthook** as the Git hooks manager for the trip-planner project.

**Implementation:**

- Use lefthook to manage all Git hooks (commit-msg, pre-commit, pre-push)
- Configuration stored in `lefthook.yml` at repository root
- Hooks automatically installed via `lefthook install` (run during `pnpm install` via prepare script)
- Parallel execution of independent checks for faster feedback
- File-based filtering to run checks only on relevant files

**Hook configuration:**

```yaml
commit-msg:
  commands:
    commitlint:
      run: pnpm commitlint --edit {1}

pre-commit:
  commands:
    ls-lint:
      run: pnpm ls-lint
    type-check:
      run: pnpm type-check
      glob: "*.{ts,tsx}"
    lint:
      run: pnpm eslint {staged_files}
      glob: "*.{js,ts,jsx,tsx}"

pre-push:
  commands:
    test:
      run: pnpm test
```

**Alternatives considered:**

- **husky**: Rejected because it's heavier (requires Node.js for all operations), slower, and has more complex configuration. Lefthook is a single binary with better performance.

- **pre-commit (Python-based)**: Rejected because it requires Python runtime and is primarily designed for Python projects. Lefthook is language-agnostic and better suited for JavaScript/TypeScript projects.

- **Native Git hooks**: Rejected because hooks are not version-controlled, require manual setup on each machine, and lack advanced features like parallel execution and file filtering.

- **lint-staged + husky**: Rejected because it requires two separate tools (lint-staged for file staging, husky for hook management). Lefthook provides both capabilities in a single tool.

- **simple-git-hooks**: Rejected because it's more minimal but lacks advanced features like parallel execution, file filtering, and cross-platform support that lefthook provides.

## Consequences

**Positive:**

- Version-controlled hook configuration ensures consistency across all development environments
- Automatic installation via `prepare` script eliminates manual setup for new developers
- Parallel execution of independent checks significantly reduces hook execution time
- File-based filtering runs checks only on affected files, improving performance
- Single binary with no runtime dependencies (faster and more reliable than Node.js-based alternatives)
- Cross-platform support (Linux, macOS, Windows) ensures consistent behavior
- Simple YAML configuration is easy to read, maintain, and extend
- Developers can skip hooks when necessary using `LEFTHOOK=0` or `--no-verify` (for emergencies)
- Integrates seamlessly with existing tools (commitlint, ls-lint, ESLint, TypeScript)

**Negative:**

- Adds another tool to the project's dependency stack
- Hook execution adds time to commit/push operations (though parallelization minimizes this)
- Developers unfamiliar with lefthook need to learn its configuration format
- Failed hooks block commits/pushes, which can interrupt workflow (though this is intentional)
- Requires `lefthook install` to be run at least once (automated via prepare script, but could fail in some environments)

**Neutral:**

- Hooks can be bypassed with `--no-verify` flag, but this should be used sparingly and only in exceptional cases
- Configuration must be maintained as project tooling evolves
- Team must agree on which checks run at which hook stages (commit vs push)
- Some checks (like full test suite) may be too slow for pre-commit and are better suited for pre-push or CI/CD

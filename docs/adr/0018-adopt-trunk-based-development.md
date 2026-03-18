# 0018. Adopt Trunk-Based Development

Date: 2026-03-18
Status: Accepted

## Context

The project requires a clear branching strategy to manage code collaboration and deployment. The team needs a workflow that supports:

- Fast iteration and frequent deployments
- Simple, easy-to-understand branching model
- Seamless CI/CD integration
- Efficient collaboration for a small team

Key considerations:

- Team size is small, allowing for close collaboration
- Rapid development cycles require quick feedback loops
- Continuous integration and deployment are priorities
- Complexity overhead of multiple long-lived branches is undesirable
- Code review and quality gates must remain robust despite simplified branching

## Decision

We will adopt **Trunk-Based Development** as our branching strategy.

In trunk-based development:

- All developers commit to a single branch (`main`) or very short-lived feature branches (< 1 day)
- Feature branches are merged back to `main` frequently (at least daily)
- `main` branch is always in a releasable state
- Feature flags are used to hide incomplete features in production
- Release tags are created directly from `main`
- Automated tests and CI checks run on every commit to ensure `main` stability

**Workflow:**

1. Create short-lived feature branch from `main` (e.g., `feature/add-login`)
2. Develop feature in small, incremental commits
3. Open PR when feature is complete (same day or next day)
4. CI runs all tests, linting, and checks
5. Code review and approval
6. Merge to `main` and delete feature branch
7. Deploy to production from `main` (manual or automated)

**Alternatives considered:**

- **GitHub Flow**: Uses feature branches that can live for extended periods, with direct merges to main. While simpler than Git Flow, it allows branches to diverge significantly from main, increasing merge conflicts and integration issues. Trunk-based development's emphasis on very short-lived branches (< 1 day) provides faster feedback and reduces integration problems.

- **GitLab Flow**: Introduces environment branches (staging, production) in addition to feature branches. This adds complexity with multiple long-lived branches and environment-specific branches. For our small team with strong CI/CD, deploying directly from main with tags is simpler and more efficient. The additional branch overhead isn't justified for our team size and deployment velocity.

## Consequences

**Positive:**

- **Faster feedback loops**: Frequent merges to main ensure early detection of integration issues
- **Simplified workflow**: Single source of truth (`main`) reduces mental overhead
- **Reduced merge conflicts**: Short-lived branches minimize divergence from main
- **Better CI/CD integration**: Single branch simplifies deployment pipelines
- **Improved collaboration**: Everyone works close to the same codebase state
- **Continuous integration**: True continuous integration with all code integrated daily
- **Easier debugging**: Less context switching between branches, clearer git history
- **Reduced stale branches**: Short-lived branches eliminate branch cleanup overhead

**Negative:**

- **Requires discipline**: Developers must commit to main frequently and keep branches short-lived
- **Feature flag complexity**: Incomplete features require feature flags to hide from production
- **Code review pressure**: Faster merge cadence requires responsive code reviews
- **Test coverage requirement**: Robust automated tests are essential to keep main stable
- **Requires good CI/CD**: Weak CI or slow tests will block the workflow
- **Learning curve**: Team may need training if accustomed to long-lived feature branches

**Neutral:**

- **Smaller PRs**: Changes are broken into smaller, more frequent PRs (generally good but requires adjustment)
- **Release process**: Releases happen directly from main via tags (simpler but different from branch-based releases)
- **Hotfix workflow**: Hotfixes committed directly to main or via very short branches (< 1 hour)
- **Rollback strategy**: Uses git revert or forward fixes rather than branch-based rollbacks

## Implementation Guidelines

To successfully implement trunk-based development:

1. **Branch lifetime**: Feature branches must be merged within 1 day (ideally same day)
2. **PR size**: Keep PRs small and focused (< 400 lines of code when possible)
3. **Feature flags**: Use feature flags for work-in-progress features
4. **CI/CD**: Ensure fast, reliable automated tests (< 10 minutes)
5. **Code review**: Prioritize reviewing PRs to avoid blocking merges
6. **Main stability**: Never merge code that breaks tests or fails CI
7. **Daily integration**: Developers should pull from main and merge at least daily

## Related ADRs

- [ADR-0003: Adopt commitlint for Commit Message Validation](0003-adopt-commitlint-for-commit-message-validation.md) - Consistent commit messages support clear trunk history
- [ADR-0006: Adopt Lefthook for Git Hooks Management](0006-adopt-lefthook-for-git-hooks-management.md) - Pre-commit hooks ensure main branch quality
- [ADR-0016: Adopt Vitest for Unit and Integration Testing](0016-adopt-vitest-for-testing.md) - Fast, reliable tests are essential for trunk-based development

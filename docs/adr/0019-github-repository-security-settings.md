# 0019. GitHub Repository Security Settings

Date: 2026-03-19
Status: Accepted

## Context

The project uses GitHub as the primary code repository and collaboration platform. As the codebase contains sensitive logic and will be deployed to production, we need to establish secure repository settings to protect against:

- Unauthorized code changes
- Commit history tampering
- Insider attacks or compromised admin accounts
- Malicious code injection
- Incomplete or untested code reaching main branch

Key considerations:

- Repository is public, requiring strong protection on the main branch
- Following trunk-based development (ADR-0018) with frequent merges
- Small team requiring balance between security and agility
- Need for accountability and auditability of all changes
- Protection against both external and insider threats

## Decision

We will configure GitHub repository settings with strong security controls, managed through Terraform Infrastructure as Code.

### Repository Settings

**Basic Configuration:**

- Visibility: Public
- Vulnerability alerts: Enabled (Dependabot security alerts)
- Auto-merge: Enabled (after CI/CD checks pass)
- Delete branch on merge: Enabled (cleanup short-lived branches)

### Branch Protection Rules (main branch)

**Code Review Requirements:**

- Required approving reviews: 0 (not required for single-developer team)
- Dismiss stale reviews: Enabled (new commits invalidate approvals)
- Require conversation resolution: Disabled (not needed for single-developer team)

**Status Check Requirements:**

- Require status checks before merging: Enabled
- Require branches to be up to date: Enabled (strict mode)
- Required status checks: To be configured when CI/CD workflows are added

**Commit Requirements:**

- Require signed commits: **Disabled** (not required for single-developer team)
  - GPG setup overhead not justified for solo development
  - May be enabled later if team expands

**Branch Restrictions:**

- Allow force pushes: **Disabled** (prevents history rewriting)
- Allow deletions: **Disabled** (prevents accidental branch deletion)
- Enforce rules for administrators: **Disabled** (allow flexibility for single-developer team)

**Merge Settings:**

- Allow merge commits: Disabled
- Allow squash merging: **Enabled** (only allowed method)
- Allow rebase merging: Disabled

Rationale: Squash-only keeps main branch history clean (1 PR = 1 commit), improving readability and aligning with trunk-based development.

### Infrastructure as Code

All settings are managed through Terraform in `infra/github/`:

- Version controlled and auditable
- Changes reviewed through pull requests
- Consistent configuration across environments
- Easy to replicate settings for new repositories

## Consequences

### Positive

**Security Improvements:**

- **Force push prevention**: Maintains immutable commit history for audit trails
- **Branch deletion prevention**: Protects main branch from accidental removal
- **Strict mode**: Ensures branches are up-to-date before merging
- **Squash merge only**: Keeps commit history clean (1 PR = 1 commit)

**Operational Benefits:**

- Infrastructure as Code: Terraform manages settings with version control
- Auditability: All setting changes tracked in git history
- Consistency: Prevents configuration drift
- Documentation: Settings defined in code serve as documentation

### Negative

**Development Friction:**

- **Strict mode**: Requires branches to be up-to-date before merging
  - Minimal impact for single-developer team (no concurrent PRs)
  - Ensures testing against latest main branch state

**Single-Developer Team Optimizations:**

- No approval required: Self-approval not possible on GitHub, approval count set to 0
- No conversation resolution: Self-review discussions unnecessary
- No admin enforcement: Flexibility for emergency fixes without compromising security
- Signed commits disabled: GPG setup overhead not justified
- Strict mode maintained: Ensures testing against latest state

### Neutral

**Policy Enforcement:**

- Force push prevention trades flexibility for security (deliberate choice)
- No admin enforcement: Prioritizes developer flexibility over strict security posture
- Zero approval count: Pragmatic choice for single-developer workflow

## Implementation

### Phase 1: Terraform Configuration (Current)

1. Define repository settings in `infra/github/repository.tf`
2. Configure branch protection rules for main branch
3. Review and approve Terraform configuration via PR
4. Apply settings to GitHub repository

### Phase 2: CI/CD Integration (Future)

1. Create GitHub Actions workflows (lint, test, security scan)
2. Update `required_status_checks.contexts` in Terraform
3. Apply updated configuration

### Emergency Procedures

If admin bypass is needed for critical hotfixes:

1. Document the emergency in an issue
2. Temporarily disable protection via Terraform
3. Apply the hotfix
4. Re-enable protection immediately
5. Create follow-up PR with proper review

## Alternatives Considered

**Alternative 1: Require Signed Commits**

- Enable `require_signed_commits = true` for cryptographic verification
- **Rejected for now**: Setup overhead not justified for single-developer team; may reconsider if team expands

**Alternative 2: GitHub Rulesets**

- Use newer Rulesets API instead of Branch Protection Rules
- **Deferred**: Branch protection rules sufficient for current needs; may migrate later

**Alternative 3: Require Approvals**

- Require 1+ approving reviews
- **Rejected**: GitHub doesn't allow self-approval; impractical for single-developer team

**Alternative 4: Required Linear History**

- Enforce linear git history (no merge commits)
- **Rejected**: Adds complexity without significant security benefit; conflicts with flexible merge strategies

## Related ADRs

- [ADR-0018: Adopt Trunk-Based Development](0018-adopt-trunk-based-development.md) - Branch strategy this security model supports
- [ADR-0003: Adopt commitlint for Commit Message Validation](0003-adopt-commitlint-for-commit-message-validation.md) - Commit quality enforcement
- [ADR-0006: Adopt Lefthook for Git Hooks Management](0006-adopt-lefthook-for-git-hooks-management.md) - Local pre-commit enforcement

## References

- [GitHub Branch Protection Documentation](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [Git Commit Signing](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)
- [Terraform GitHub Provider](https://registry.terraform.io/providers/integrations/github/latest/docs)

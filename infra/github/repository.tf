# Repository settings
# Note: This manages settings for an existing repository
# To import: terraform import github_repository.main trip-planner

resource "github_repository" "main" {
  name        = var.repository_name
  description = "A trip planning application built with TypeScript and Hono"
  visibility  = "public"

  has_issues      = true
  has_discussions = false
  has_projects    = true
  has_wiki        = false

  allow_merge_commit     = false # Disable to keep history clean
  allow_squash_merge     = true  # Squash merge only (1 PR = 1 commit)
  allow_rebase_merge     = false # Disable to keep history clean
  allow_auto_merge       = true
  delete_branch_on_merge = true

  vulnerability_alerts = true

  # Security features (free for public repositories)
  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

# Branch protection for main branch (Trunk-Based Development)
# See: docs/adr/0018-adopt-trunk-based-development.md
resource "github_branch_protection" "main" {
  repository_id = github_repository.main.node_id
  pattern       = "main"

  # Require status checks to pass before merging
  # Add CI/CD workflow names here when configured (e.g., ["CI", "lint", "test"])
  required_status_checks {
    strict   = true # Require branches to be up to date before merging
    contexts = []   # TODO: Add status check contexts from GitHub Actions
  }

  # Require code review (ADR-0019: Approval not required for single-developer team)
  required_pull_request_reviews {
    dismiss_stale_reviews           = true # Invalidate old reviews on new commits
    require_code_owner_reviews      = false
    required_approving_review_count = 0 # No approval required (single-developer)
    require_last_push_approval      = false
  }

  # Additional protections for trunk stability
  require_conversation_resolution = false # Not required for single-developer team
  require_signed_commits          = false # Not using GPG signing
  required_linear_history         = true  # Enforce linear history (clean git log)
  allows_force_pushes             = false
  allows_deletions                = false

  # Allow admin bypass for flexibility (single-developer team)
  enforce_admins = false
}

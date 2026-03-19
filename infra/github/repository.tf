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

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  vulnerability_alerts = true
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

  # Require code review (ADR-0018: Code review and approval required)
  required_pull_request_reviews {
    dismiss_stale_reviews           = true # Invalidate old reviews on new commits
    require_code_owner_reviews      = false
    required_approving_review_count = 1 # At least 1 approval required
    require_last_push_approval      = false
  }

  # Additional protections for trunk stability
  require_conversation_resolution = true  # Resolve all discussions before merging
  required_linear_history         = false # Allow merge commits (set true for linear history)
  allows_force_pushes             = false
  allows_deletions                = false

  # Admins can bypass protection for emergency fixes
  enforce_admins = false
}

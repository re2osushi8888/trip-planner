# GitHub Issue/PR Labels
# Manages existing labels in the repository

locals {
  labels = {
    # Default GitHub labels
    "bug" = {
      color       = "d73a4a"
      description = "Something isn't working"
    }
    "documentation" = {
      color       = "0075ca"
      description = "Improvements or additions to documentation"
    }
    "duplicate" = {
      color       = "cfd3d7"
      description = "This issue or pull request already exists"
    }
    "enhancement" = {
      color       = "a2eeef"
      description = "New feature or request"
    }
    "good first issue" = {
      color       = "7057ff"
      description = "Good for newcomers"
    }
    "help wanted" = {
      color       = "008672"
      description = "Extra attention is needed"
    }
    "invalid" = {
      color       = "e4e669"
      description = "This doesn't seem right"
    }
    "question" = {
      color       = "d876e3"
      description = "Further information is requested"
    }
    "wontfix" = {
      color       = "ffffff"
      description = "This will not be worked on"
    }

    # Issue hierarchy labels
    "epic" = {
      color       = "7057ff"
      description = "Large features or initiatives spanning multiple Stories"
    }
    "story" = {
      color       = "0075ca"
      description = "User-facing features combining Job Story and User Story formats"
    }
    "task" = {
      color       = "008672"
      description = "Technical implementation work"
    }

    # Task type labels
    "feature" = {
      color       = "a2eeef"
      description = "New feature implementation tasks"
    }
    "kaizen" = {
      color       = "fbca04"
      description = "Improvement tasks (continuous improvement)"
    }

    # Scope labels
    "api" = {
      color       = "c5def5"
      description = "API endpoints and backend logic"
    }
    "web" = {
      color       = "c5def5"
      description = "Frontend UI and user interface"
    }
    "domain" = {
      color       = "c5def5"
      description = "Domain logic and business rules"
    }
    "db" = {
      color       = "c5def5"
      description = "Database schema and migrations"
    }
    "config" = {
      color       = "c5def5"
      description = "Configuration and environment setup"
    }
    "infra" = {
      color       = "c5def5"
      description = "Infrastructure, deployment, and CI/CD"
    }

    # User idea label
    "userIdea" = {
      color       = "ededed"
      description = "Quick ideas and suggestions"
    }
  }
}

resource "github_issue_label" "labels" {
  for_each = local.labels

  repository  = github_repository.main.name
  name        = each.key
  color       = each.value.color
  description = each.value.description
}

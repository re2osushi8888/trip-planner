provider "github" {
  owner = var.github_owner
  # Authentication automatically uses GitHub CLI (gh auth token)
  # No need to set GITHUB_TOKEN if you're logged in via `gh auth login`
}

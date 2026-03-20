# Dependabot Security Updates
# Automatically creates pull requests for security vulnerabilities
resource "github_repository_dependabot_security_updates" "main" {
  repository = github_repository.main.name
  enabled    = true
}

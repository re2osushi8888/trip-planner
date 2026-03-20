output "repository_full_name" {
  description = "Full name of the repository"
  value       = github_repository.main.full_name
}

output "repository_url" {
  description = "URL of the repository"
  value       = github_repository.main.html_url
}

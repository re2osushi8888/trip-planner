# GitHub Terraform Configuration

This directory contains Terraform configuration for managing GitHub repository settings.

## Prerequisites

1. Install Terraform (>= 1.0) - Already configured in `.mise.toml`
2. Authenticate with GitHub CLI:
   ```bash
   gh auth login
   ```
   Required token scopes: `repo`, `workflow` (already included in your current auth)

## Setup

1. Initialize Terraform:

   ```bash
   cd infra/github
   mise exec -- terraform init
   ```

2. Check authentication:

   ```bash
   gh auth status
   ```

3. Import existing repository (first time only):

   ```bash
   mise exec -- terraform import github_repository.main trip-planner
   mise exec -- terraform import github_branch_protection.main trip-planner:main
   ```

4. Review the plan:

   ```bash
   mise exec -- terraform plan
   ```

5. Apply changes:
   ```bash
   mise exec -- terraform apply
   ```

## What's Managed

- Repository settings (description, features, merge settings)
- Branch protection rules for `main` branch
- (Add more as you expand)

## Authentication

- Automatically uses GitHub CLI authentication (`gh auth token`)
- No need to manually set `GITHUB_TOKEN` environment variable
- If `gh` CLI is not found, set `GITHUB_TOKEN` environment variable as fallback

## Notes

- Always run `terraform plan` before `terraform apply`
- Use `mise exec -- terraform` to run Terraform commands

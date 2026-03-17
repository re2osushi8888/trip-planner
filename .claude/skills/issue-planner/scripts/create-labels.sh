#!/bin/bash
# Create all required GitHub labels for the project
# Usage: ./create-labels.sh [--force]

set -euo pipefail

FORCE=false
if [ "${1:-}" = "--force" ]; then
  FORCE=true
fi

# Check if gh is installed
if ! command -v gh &> /dev/null; then
  echo "Error: gh (GitHub CLI) is required but not installed"
  exit 1
fi

echo "Creating GitHub labels for trip-planner project..."
echo ""

# Label definitions: name, color, description
# Based on .github/project-setup.md
declare -a LABELS=(
  # Hierarchy labels
  "userIdea|fbca04|Quick ideas and suggestions (no strict format)"
  "epic|7057ff|Large features or initiatives spanning multiple Stories"
  "story|0075ca|User-facing features combining Job Story and User Story formats"
  "task|008672|Technical implementation work"

  # Task type labels
  "feature|a2eeef|New feature implementation tasks"
  "bug|d73a4a|Bug fix tasks"
  "kaizen|fbca04|Improvement tasks (continuous improvement)"

  # Scope labels
  "api|c5def5|API endpoints and backend logic"
  "web|c5def5|Frontend UI and user interface"
  "domain|c5def5|Domain logic and business rules"
  "db|c5def5|Database schema and migrations"
  "config|c5def5|Configuration and environment setup"
  "infra|c5def5|Infrastructure, deployment, and CI/CD"
)

created=0
updated=0
skipped=0
failed=0

for label_def in "${LABELS[@]}"; do
  IFS='|' read -r name color description <<< "$label_def"

  # Check if label already exists
  if gh label list --limit 1000 | grep -q "^$name"; then
    if [ "$FORCE" = true ]; then
      echo "Updating label: $name"
      if gh label edit "$name" --color "$color" --description "$description" 2>/dev/null; then
        echo "  ✓ Updated: $name (color: #$color)"
        ((updated++))
      else
        echo "  ✗ Failed to update: $name"
        ((failed++))
      fi
    else
      echo "  ○ Already exists: $name (use --force to update)"
      ((skipped++))
    fi
  else
    echo "Creating label: $name"
    if gh label create "$name" --color "$color" --description "$description" 2>/dev/null; then
      echo "  ✓ Created: $name (color: #$color)"
      ((created++))
    else
      echo "  ✗ Failed to create: $name"
      ((failed++))
    fi
  fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Summary:"
echo "  ✓ Created: $created"
if [ "$FORCE" = true ]; then
  echo "  ✓ Updated: $updated"
fi
echo "  ○ Skipped: $skipped"
if [ $failed -gt 0 ]; then
  echo "  ✗ Failed: $failed"
fi
echo ""
echo "Total labels defined: ${#LABELS[@]}"

if [ $failed -gt 0 ]; then
  exit 1
fi

echo ""
echo "Next steps:"
echo "  1. Verify labels at: https://github.com/re2osushi8888/trip-planner/labels"
echo "  2. Create project boards using .github/project-setup.md"

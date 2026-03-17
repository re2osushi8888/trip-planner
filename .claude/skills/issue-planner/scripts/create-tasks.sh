#!/bin/bash
# Bulk create Tasks from JSON data file
# Usage: ./create-tasks.sh <tasks-data.json>

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <tasks-data.json>"
  echo "Example: $0 tasks.json"
  exit 1
fi

DATA_FILE="$1"

if [ ! -f "$DATA_FILE" ]; then
  echo "Error: Data file '$DATA_FILE' not found"
  exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo "Error: jq is required but not installed"
  echo "Install with: sudo apt-get install jq"
  exit 1
fi

# Check if gh is installed
if ! command -v gh &> /dev/null; then
  echo "Error: gh (GitHub CLI) is required but not installed"
  exit 1
fi

echo "Creating Tasks from $DATA_FILE..."
echo ""

# Parse JSON and create issues
tasks=$(jq -c '.tasks[]' "$DATA_FILE")

issue_numbers=()
scope_labels=()

while IFS= read -r task; do
  type=$(echo "$task" | jq -r '.type')
  title=$(echo "$task" | jq -r '.title')
  scope=$(echo "$task" | jq -r '.scope')
  description=$(echo "$task" | jq -r '.description')
  acceptance=$(echo "$task" | jq -r '.acceptance_criteria')
  parent_story=$(echo "$task" | jq -r '.parent_story // ""')
  notes=$(echo "$task" | jq -r '.notes // ""')

  # Validate type
  if [[ ! "$type" =~ ^(feature|bug|kaizen)$ ]]; then
    echo "Error: Invalid type '$type' (must be: feature, bug, or kaizen)"
    exit 1
  fi

  # Validate scope
  if [[ ! "$scope" =~ ^(api|web|domain|db|config|infra)$ ]]; then
    echo "Error: Invalid scope '$scope' (must be: api, web, domain, db, config, or infra)"
    exit 1
  fi

  # Build labels (task + type label)
  labels="task,$type"

  # Build issue body
  body="## Scope

**$scope**

## Description

$description

## Acceptance Criteria

$acceptance"

  if [ -n "$parent_story" ]; then
    body="$body

## Parent Story

Part of Story $parent_story"
  fi

  if [ -n "$notes" ]; then
    body="$body

## Technical Notes

$notes"
  fi

  echo "Creating Task: $title"
  echo "  Type: $type, Scope: $scope"

  # Create issue and capture issue number
  issue_url=$(gh issue create \
    --title "$title" \
    --label "$labels" \
    --body "$body")

  issue_number=$(echo "$issue_url" | grep -oP '\d+$')
  issue_numbers+=("$issue_number")
  scope_labels+=("$issue_number:$scope")

  echo "  ✓ Created #$issue_number: $issue_url"

  # Add relationship comment if parent_story is specified
  if [ -n "$parent_story" ]; then
    gh issue comment "$issue_number" --body "Part of Story $parent_story" >/dev/null 2>&1
    echo "  ✓ Added relationship to $parent_story"
  fi

  echo ""

  # Small delay to avoid rate limiting
  sleep 1
done <<< "$tasks"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Successfully created ${#issue_numbers[@]} Tasks"
echo ""
echo "Task Issue Numbers:"
for num in "${issue_numbers[@]}"; do
  echo "  #$num"
done
echo ""
echo "⚠️  IMPORTANT: Manually add scope labels to each Task:"
for item in "${scope_labels[@]}"; do
  issue_num="${item%%:*}"
  scope="${item##*:}"
  echo "  gh issue edit $issue_num --add-label $scope"
done
echo ""
echo "Or run all at once:"
echo "  for label in ${scope_labels[@]}; do"
echo "    IFS=':' read -r num scope <<< \"\$label\""
echo "    gh issue edit \$num --add-label \$scope"
echo "  done"
echo ""
echo "Next steps:"
echo "  1. Add scope labels (see above)"
echo "  2. Add Tasks to GitHub Project"
echo "  3. Set appropriate status"

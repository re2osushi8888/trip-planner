#!/bin/bash
# Bulk create Stories from JSON data file
# Usage: ./create-stories.sh <stories-data.json>

set -euo pipefail

# Function to get issue internal ID
get_issue_id() {
  local issue_number=$1
  gh issue view "$issue_number" --json id --jq ".id"
}

# Function to add sub-issue relationship via GraphQL API
add_sub_issue() {
  local parent_number=$1
  local child_number=$2

  local parent_id=$(get_issue_id "$parent_number")
  local child_id=$(get_issue_id "$child_number")

  gh api graphql \
    -H "GraphQL-Features: sub_issues" \
    -f query='
      mutation($parentId: ID!, $childId: ID!) {
        addSubIssue(input: { issueId: $parentId, subIssueId: $childId }) {
          issue {
            number
            title
          }
          subIssue {
            number
            title
          }
        }
      }
    ' \
    -f parentId="$parent_id" \
    -f childId="$child_id" \
    > /dev/null 2>&1
}

if [ $# -lt 1 ]; then
  echo "Usage: $0 <stories-data.json>"
  echo "Example: $0 stories.json"
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

echo "Creating Stories from $DATA_FILE..."
echo ""

# Parse JSON and create issues
stories=$(jq -c '.stories[]' "$DATA_FILE")

issue_numbers=()

while IFS= read -r story; do
  title=$(echo "$story" | jq -r '.title')
  user_story=$(echo "$story" | jq -r '.user_story')
  context=$(echo "$story" | jq -r '.context // ""')
  background=$(echo "$story" | jq -r '.background // ""')
  acceptance=$(echo "$story" | jq -r '.acceptance_criteria')
  parent_epic=$(echo "$story" | jq -r '.parent_epic // ""')
  notes=$(echo "$story" | jq -r '.notes // ""')

  # Build issue body
  body="## User Story

$user_story"

  if [ -n "$context" ]; then
    body="$body

## Context & Motivation (Job Story)

$context"
  fi

  if [ -n "$background" ]; then
    body="$body

## Background

$background"
  fi

  body="$body

## Acceptance Criteria

$acceptance"

  if [ -n "$parent_epic" ]; then
    body="$body

## Parent Epic

Part of Epic $parent_epic"
  fi

  if [ -n "$notes" ]; then
    body="$body

## Design & Technical Notes

$notes"
  fi

  echo "Creating Story: $title"

  # Create issue and capture issue number
  issue_url=$(gh issue create \
    --title "$title" \
    --label "story" \
    --body "$body")

  issue_number=$(echo "$issue_url" | grep -oP '\d+$')
  issue_numbers+=("$issue_number")

  echo "  ✓ Created #$issue_number: $issue_url"

  # Add sub-issue relationship if parent_epic is specified
  if [ -n "$parent_epic" ]; then
    # Extract issue number (remove '#' if present)
    parent_num=$(echo "$parent_epic" | sed 's/^#//')

    echo -n "  Setting as sub-issue of Epic #$parent_num... "
    if add_sub_issue "$parent_num" "$issue_number"; then
      echo "✓"
    else
      echo "⚠ (warning: may already exist or error occurred)"
    fi
  fi

  echo ""

  # Small delay to avoid rate limiting
  sleep 1
done <<< "$stories"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Successfully created ${#issue_numbers[@]} Stories"
echo ""
echo "Story Issue Numbers:"
for num in "${issue_numbers[@]}"; do
  echo "  #$num"
done
echo ""
echo "Next steps:"
echo "  1. Add Stories to GitHub Project"
echo "  2. Link Stories to parent Epics"
echo "  3. Create Tasks for Stories as needed"

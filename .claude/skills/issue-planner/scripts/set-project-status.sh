#!/bin/bash
# Set GitHub Project status for issues
# Usage: ./set-project-status.sh <status> <issue-numbers...>
# Example: ./set-project-status.sh Backlog 50 51 52 53 54

set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <status> <issue-numbers...>"
  echo "Example: $0 Backlog 50 51 52 53 54"
  echo ""
  echo "Available statuses: Todo, Backlog, In progress, Review, Done"
  exit 1
fi

STATUS_NAME="$1"
shift
ISSUE_NUMBERS=("$@")

# Project configuration (from .github/project-setup.md)
PROJECT_ID="PVT_kwHOCPVz884BRjqm"
STATUS_FIELD_ID="PVTSSF_lAHOCPVz884BRjqmzg_Wc3U"

# Status option IDs
declare -A STATUS_IDS
STATUS_IDS["Todo"]="f75ad846"
STATUS_IDS["Backlog"]="15a88ded"
STATUS_IDS["In progress"]="47fc9ee4"
STATUS_IDS["Review"]="526cbac6"
STATUS_IDS["Done"]="98236657"

# Validate status
if [ -z "${STATUS_IDS[$STATUS_NAME]:-}" ]; then
  echo "Error: Invalid status '$STATUS_NAME'"
  echo "Available statuses: ${!STATUS_IDS[@]}"
  exit 1
fi

STATUS_OPTION_ID="${STATUS_IDS[$STATUS_NAME]}"

echo "Setting status to: $STATUS_NAME"
echo "Issues: ${ISSUE_NUMBERS[@]}"
echo ""

# Function to add issue to project and set status
add_and_set_status() {
  issue_number=$1

  # Get issue node ID
  issue_id=$(gh api graphql -f query='
    query($owner: String!, $repo: String!, $number: Int!) {
      repository(owner: $owner, name: $repo) {
        issue(number: $number) {
          id
        }
      }
    }
  ' -f owner="re2osushi8888" -f repo="trip-planner" -F number="$issue_number" | jq -r '.data.repository.issue.id')

  if [ "$issue_id" = "null" ] || [ -z "$issue_id" ]; then
    echo "  ✗ Issue #$issue_number not found"
    return 1
  fi

  # Add issue to project (or get existing item)
  item_id=$(gh api graphql -f query='
    mutation($projectId: ID!, $contentId: ID!) {
      addProjectV2ItemById(input: {projectId: $projectId, contentId: $contentId}) {
        item {
          id
        }
      }
    }
  ' -f projectId="$PROJECT_ID" -f contentId="$issue_id" 2>/dev/null | jq -r '.data.addProjectV2ItemById.item.id')

  # If already in project, get the item ID
  if [ "$item_id" = "null" ] || [ -z "$item_id" ]; then
    item_id=$(gh api graphql -f query='
      query($projectId: ID!, $contentId: ID!) {
        node(id: $projectId) {
          ... on ProjectV2 {
            items(first: 100) {
              nodes {
                id
                content {
                  ... on Issue {
                    id
                  }
                }
              }
            }
          }
        }
      }
    ' -f projectId="$PROJECT_ID" -f contentId="$issue_id" | jq -r ".data.node.items.nodes[] | select(.content.id == \"$issue_id\") | .id")
  fi

  if [ "$item_id" = "null" ] || [ -z "$item_id" ]; then
    echo "  ✗ Failed to add issue #$issue_number to project"
    return 1
  fi

  # Set status
  result=$(gh api graphql -f query='
    mutation($projectId: ID!, $itemId: ID!, $fieldId: ID!, $optionId: String!) {
      updateProjectV2ItemFieldValue(input: {
        projectId: $projectId
        itemId: $itemId
        fieldId: $fieldId
        value: {singleSelectOptionId: $optionId}
      }) {
        projectV2Item {
          id
        }
      }
    }
  ' -f projectId="$PROJECT_ID" -f itemId="$item_id" -f fieldId="$STATUS_FIELD_ID" -f optionId="$STATUS_OPTION_ID" 2>&1)

  if echo "$result" | jq -e '.data.updateProjectV2ItemFieldValue.projectV2Item.id' > /dev/null 2>&1; then
    echo "  ✓ #$issue_number: Status set to $STATUS_NAME"
  else
    echo "  ✗ #$issue_number: Failed to set status"
    echo "$result" | jq -r '.errors[]? .message' 2>/dev/null || echo "$result"
    return 1
  fi
}

# Process each issue
success_count=0
fail_count=0

for issue in "${ISSUE_NUMBERS[@]}"; do
  if add_and_set_status "$issue"; then
    ((success_count++))
  else
    ((fail_count++))
  fi
  sleep 0.3
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $fail_count -eq 0 ]; then
  echo "✅ Successfully updated $success_count issue(s) to status: $STATUS_NAME"
else
  echo "⚠️  Updated $success_count issue(s), failed $fail_count issue(s)"
  exit 1
fi

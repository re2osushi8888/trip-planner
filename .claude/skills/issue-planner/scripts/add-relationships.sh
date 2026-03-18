#!/bin/bash
# Add parent-child relationships to existing issues using GitHub's sub-issue feature
# Usage: ./add-relationships.sh

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "Adding parent-child relationships to existing issues..."
echo ""

# Function to get issue internal ID
get_issue_id() {
  local issue_number=$1
  gh issue view "$issue_number" --json id --jq ".id"
}

# Function to add sub-issue relationship
add_sub_issue() {
  local parent_number=$1
  local child_number=$2

  echo -n "  Adding #$child_number as sub-issue of #$parent_number... "

  # Get internal IDs
  local parent_id=$(get_issue_id "$parent_number")
  local child_id=$(get_issue_id "$child_number")

  # Execute GraphQL mutation
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

  echo -e "${GREEN}✓${NC}"
}

# Epic 1 (#50) -> Stories
echo -e "${BLUE}Epic #50: Development Environment${NC}"
for story in 55 56 57 58; do
  add_sub_issue 50 "$story"
done

echo ""
echo -e "${BLUE}Epic #51: Travel App Core${NC}"
for story in 59 62 63 64; do
  add_sub_issue 51 "$story"
done

echo ""
echo -e "${BLUE}Epic #52: Claude Code/AI Support${NC}"
for story in 65 66 67 68; do
  add_sub_issue 52 "$story"
done

echo ""
echo -e "${BLUE}Epic #53: Technology Selection/ADR${NC}"
for story in 69 70 71 72; do
  add_sub_issue 53 "$story"
done

echo ""
echo -e "${BLUE}Epic #54: Project Management${NC}"
for story in 73 74 75 76; do
  add_sub_issue 54 "$story"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Relationships added!${NC}"
echo ""
echo "GitHub will now show these relationships in the issue sidebar."

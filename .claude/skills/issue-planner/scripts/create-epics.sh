#!/bin/bash
# Bulk create Epics from JSON data file
# Usage: ./create-epics.sh <epics-data.json>

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <epics-data.json>"
  echo "Example: $0 epics.json"
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

echo "Creating Epics from $DATA_FILE..."
echo ""

# Parse JSON and create issues
epics=$(jq -c '.epics[]' "$DATA_FILE")

issue_numbers=()

while IFS= read -r epic; do
  title=$(echo "$epic" | jq -r '.title')
  overview=$(echo "$epic" | jq -r '.overview')
  scope_in=$(echo "$epic" | jq -r '.scope.in')
  scope_out=$(echo "$epic" | jq -r '.scope.out')
  acceptance=$(echo "$epic" | jq -r '.acceptance_criteria')
  priority=$(echo "$epic" | jq -r '.priority // "Medium"')
  dependencies=$(echo "$epic" | jq -r '.dependencies // "None"')
  notes=$(echo "$epic" | jq -r '.notes // ""')

  # Build issue body
  body="## Overview

$overview

## Scope

### In Scope
$scope_in

### Out of Scope
$scope_out

## Epic Acceptance Criteria

$acceptance

## Priority

$priority

## Dependencies

$dependencies"

  if [ -n "$notes" ]; then
    body="$body

## Additional Notes

$notes"
  fi

  echo "Creating Epic: $title"

  # Create issue and capture issue number
  issue_url=$(gh issue create \
    --title "$title" \
    --label "epic" \
    --body "$body")

  issue_number=$(echo "$issue_url" | grep -oP '\d+$')
  issue_numbers+=("$issue_number")

  echo "  ✓ Created #$issue_number: $issue_url"
  echo ""

  # Small delay to avoid rate limiting
  sleep 1
done <<< "$epics"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Successfully created ${#issue_numbers[@]} Epics"
echo ""
echo "Epic Issue Numbers:"
for num in "${issue_numbers[@]}"; do
  echo "  #$num"
done
echo ""
echo "Next steps:"
echo "  1. Add Epics to GitHub Project"
echo "  2. Set status to 'Backlog'"
echo "  3. Create Stories for each Epic"

#!/bin/bash
# Add parent-child relationships to existing issues
# Usage: ./add-relationships.sh

set -euo pipefail

echo "Adding relationships to existing issues..."
echo ""

# Epic 1 (#50) -> Stories
echo "Epic #50: Development Environment"
for story in 55 56 57 58; do
  echo "  Adding Story #$story to Epic #50"
  gh issue comment "$story" --body "Part of Epic #50"
done

echo ""
echo "Epic #51: Travel App Core"
for story in 59 62 63 64; do
  echo "  Adding Story #$story to Epic #51"
  gh issue comment "$story" --body "Part of Epic #51"
done

echo ""
echo "Epic #52: Claude Code/AI Support"
for story in 65 66 67 68; do
  echo "  Adding Story #$story to Epic #52"
  gh issue comment "$story" --body "Part of Epic #52"
done

echo ""
echo "Epic #53: Technology Selection/ADR"
for story in 69 70 71 72; do
  echo "  Adding Story #$story to Epic #53"
  gh issue comment "$story" --body "Part of Epic #53"
done

echo ""
echo "Epic #54: Project Management"
for story in 73 74 75 76; do
  echo "  Adding Story #$story to Epic #54"
  gh issue comment "$story" --body "Part of Epic #54"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Relationships added!"
echo ""
echo "GitHub will now show these relationships in the issue sidebar."

# Issue Bulk Creation Scripts

Shell scripts for creating multiple GitHub Issues (Epics and Stories) at once.

## Scripts

- `create-epics.sh` - Bulk create Epic issues from JSON data
- `create-stories.sh` - Bulk create Story issues from JSON data
- `example-epics.json` - Example Epic data file template
- `example-stories.json` - Example Story data file template

## Prerequisites

```bash
# Install jq (JSON processor)
sudo apt-get install jq

# Install and authenticate GitHub CLI
gh auth login
```

## Usage

### Creating Epics

1. Copy the example file and edit with your data:
   ```bash
   cp example-epics.json my-epics.json
   # Edit my-epics.json
   ```

2. Run the script:
   ```bash
   ./create-epics.sh my-epics.json
   ```

3. The script will:
   - Create each Epic as a GitHub Issue
   - Apply the `epic` label automatically
   - Output issue numbers for reference
   - Add a small delay between creations to avoid rate limiting

### Creating Stories

1. Copy the example file and edit with your data:
   ```bash
   cp example-stories.json my-stories.json
   # Edit my-stories.json
   ```

2. Run the script:
   ```bash
   ./create-stories.sh my-stories.json
   ```

3. The script will:
   - Create each Story as a GitHub Issue
   - Apply the `story` label automatically
   - Output issue numbers for reference
   - Add a small delay between creations to avoid rate limiting

## JSON Data Format

### Epic Data Structure

```json
{
  "epics": [
    {
      "title": "[Epic] Your Epic Title",
      "overview": "Multi-line overview with goals, problems, and beneficiaries",
      "scope": {
        "in": "Bullet list of in-scope items",
        "out": "Bullet list of out-of-scope items"
      },
      "acceptance_criteria": "Checklist of completion criteria",
      "priority": "High | Medium | Low",
      "dependencies": "Dependencies or 'None'",
      "notes": "Additional notes (optional)"
    }
  ]
}
```

### Story Data Structure

```json
{
  "stories": [
    {
      "title": "[Story] Your Story Title",
      "user_story": "As a...\nI want...\nso that...",
      "context": "When...\nI want to...\nso I can... (optional)",
      "background": "Background information (optional)",
      "acceptance_criteria": "Checklist of criteria",
      "parent_epic": "#123 (optional)",
      "notes": "Technical notes (optional)"
    }
  ]
}
```

## Tips

- **Use `\n` for line breaks** in JSON strings
- **Review the data file** before running the script
- **Save data files** for future reference or similar projects
- **Check rate limits** if creating many issues (script adds 1s delay)
- **Issue numbers** are printed at the end for easy reference

## Example Workflow

```bash
# 1. Create Epics from data file
./create-epics.sh my-epics.json
# Output: Created #50, #51, #52, #53, #54

# 2. Update story data with Epic numbers
# Edit my-stories.json and set "parent_epic": "#50" etc.

# 3. Create Stories
./create-stories.sh my-stories.json
# Output: Created #55, #56, #57, #58...

# 4. Add issues to GitHub Project and set status
# (Use GitHub web UI or API)
```

## Troubleshooting

**Error: "jq: command not found"**
```bash
sudo apt-get update
sudo apt-get install jq
```

**Error: "gh: command not found"**
```bash
# Install GitHub CLI
# See: https://github.com/cli/cli#installation
```

**Error: "failed to create issue"**
- Check GitHub CLI authentication: `gh auth status`
- Check repository permissions
- Verify JSON syntax: `jq . my-data.json`

**Rate limiting**
- Script includes 1-second delay between issues
- For large batches (>20 issues), consider increasing delay
- GitHub API rate limit: 5000 requests/hour for authenticated users

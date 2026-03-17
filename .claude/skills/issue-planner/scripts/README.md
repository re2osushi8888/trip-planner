# Issue Bulk Creation Scripts

Shell scripts for creating multiple GitHub Issues (Epics and Stories) at once.

## Scripts

- `create-epics.sh` - Bulk create Epic issues from JSON data
- `create-stories.sh` - Bulk create Story issues from JSON data
- `set-project-status.sh` - Set GitHub Project status for issues

## Prerequisites

```bash
# Install jq (JSON processor)
sudo apt-get install jq

# Install and authenticate GitHub CLI
gh auth login
```

## Usage

### Creating Epics

1. Create a JSON data file with your Epic data (see [JSON Data Format](#json-data-format) below):
   ```bash
   # Create your data file
   vim my-epics.json
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

1. Create a JSON data file with your Story data (see [JSON Data Format](#json-data-format) below):
   ```bash
   # Create your data file
   vim my-stories.json
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

**Field definitions**: Refer to the issue templates for detailed field descriptions:
- Epic fields: [`.github/ISSUE_TEMPLATE/1-epic.yml`](../../../.github/ISSUE_TEMPLATE/1-epic.yml)
- Story fields: [`.github/ISSUE_TEMPLATE/2-story.yml`](../../../.github/ISSUE_TEMPLATE/2-story.yml)

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

**Note:** Field meanings and examples are defined in the Epic issue template. The JSON structure maps directly to the template fields.

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

**Note:** Field meanings and examples are defined in the Story issue template. The JSON structure maps directly to the template fields.

## Tips

- **Use `\n` for line breaks** in JSON strings
- **Review the data file** before running the script
- **Save data files** for future reference or similar projects
- **Check rate limits** if creating many issues (script adds 1s delay)
- **Issue numbers** are printed at the end for easy reference

### Setting Project Status

Set the GitHub Project status for issues:

```bash
./set-project-status.sh <status> <issue-numbers...>
```

**Available statuses:**
- `Backlog` - Backlog items
- `Todo` - Ready to work on
- `In progress` - Currently being worked on
- `Review` - In review
- `Done` - Completed

**Example:**
```bash
# Set Epics to Backlog status
./set-project-status.sh Backlog 50 51 52 53 54

# Set Stories to Todo status
./set-project-status.sh Todo 55 56 57 58

# Move issue to In progress
./set-project-status.sh "In progress" 59
```

**Note:** This script will automatically add issues to the project if they're not already added.

---

## Example Workflow

```bash
# 1. Create Epics from data file
./create-epics.sh my-epics.json
# Output: Created #50, #51, #52, #53, #54

# 2. Set Epics to Backlog status
./set-project-status.sh Backlog 50 51 52 53 54

# 3. Update story data with Epic numbers
# Edit my-stories.json and set "parent_epic": "#50" etc.

# 4. Create Stories
./create-stories.sh my-stories.json
# Output: Created #55, #56, #57, #58...

# 5. Set Stories to appropriate status
./set-project-status.sh Todo 55 56 57 58
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

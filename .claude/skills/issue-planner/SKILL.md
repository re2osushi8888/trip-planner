---
name: issue-planner
description: Plan and structure GitHub Issues by breaking down user requirements into Epic → Story → Task hierarchy. Use when user wants to create issues, plan features, organize work into epics/stories/tasks, or needs help structuring their backlog. Handles breakdown of large features into manageable pieces with proper scope classification (api, web, domain, db, config, infra).
invocable: true
---

# Issue Creation Workflow

This skill provides guidelines for creating GitHub Issues following the Epic → Story → Task hierarchy.

## Workflow Overview

```
User Requirement
    ↓
Epic (Large Feature/Initiative)
    ↓
Story (Job Story + User Story Hybrid)
    ↓
Task (Feature/Bug/Kaizen by Scope)
    ↓
Development (Implement by Scope)
```

---

## Hierarchy Structure

### 1. Epic
Large body of work that encompasses multiple Stories. Typically spans multiple sprints.

### 2. Story
Specific feature or capability from the user's perspective. Combines Job Story (context/motivation) and User Story (role/benefit). Typically completed in 1-2 sprints.

### 3. Task
Technical implementation work. Split by scope (api, web, domain, db, config, infra). Typically completed in hours to days.

---

## Quick Start Guide

### Step 1: Create an Epic

**When**: Large feature spanning multiple Stories and sprints

Use template: `1-epic.yml` → Label: `epic`

**Title**: `[Epic] <Brief description>`

**Key fields**: Overview, Scope (In/Out), Acceptance Criteria, Related Stories

See [Template Reference](references/template-reference.md#epic-template) for detailed field descriptions.

---

### Step 2: Break Down Epic into Stories

**When**: Specific user-facing capability deliverable in 1-2 sprints

Use template: `2-story.yml` → Label: `story`

**Title**: `[Story] <Feature description>`

**Hybrid format**:
- User Story: "As a [role], I want [feature], so that [benefit]"
- Job Story: "When [situation], I want to [motivation], so I can [outcome]"

**Key fields**: User Story, Context, Acceptance Criteria, Related Tasks, Parent Epic

See [Template Reference](references/template-reference.md#story-template) for detailed field descriptions.

---

### Step 3: Break Down Story into Tasks

**Split by Scope**: api / web / domain / db / config / infra

**Task Types**:
- `3-task-feature.yml` → Labels: `task`, `feature`
- `3-task-bug.yml` → Labels: `task`, `bug`
- `3-task-kaizen.yml` → Labels: `task`, `kaizen`

**Title**: `[Feature|Bug|Kaizen] <Specific technical task>`

**Key fields**: Scope (required), Description, Acceptance Criteria, Parent Story

⚠️ **Important**: Manually add scope label (api/web/domain/db/config/infra) after creating each Task.

See [Template Reference](references/template-reference.md#task-templates) for detailed field descriptions and [Complete Example](references/complete-example.md) for a full walkthrough.

---

## Bulk Creation Scripts

For creating multiple Epics or Stories at once, use the provided shell scripts.

### Prerequisites

- `jq` installed: `sudo apt-get install jq`
- `gh` (GitHub CLI) installed and authenticated

### First-Time Setup: Create Labels

Before creating issues, set up all required GitHub labels:

```bash
cd .claude/skills/issue-planner/scripts
./create-labels.sh
```

This creates 14 labels: userIdea, epic, story, task, feature, bug, kaizen, and all scope labels (api, web, domain, db, config, infra).

Use `--force` to update existing labels if definitions change.

### Creating Multiple Epics

1. **Prepare data file** (JSON format):
   ```bash
   # Create your JSON file with Epic data
   # See .github/ISSUE_TEMPLATE/1-epic.yml for field definitions
   vim my-epics.json
   ```

2. **Run script**:
   ```bash
   ./scripts/create-epics.sh my-epics.json
   ```

**Example JSON structure**:
```json
{
  "epics": [
    {
      "title": "[Epic] Example Epic Title",
      "overview": "Brief overview...",
      "scope": {
        "in": "- Feature A\n- Feature B",
        "out": "- Feature X (separate Epic)"
      },
      "acceptance_criteria": "- [ ] Criteria 1\n- [ ] Criteria 2",
      "priority": "High",
      "dependencies": "None",
      "notes": "Additional notes"
    }
  ]
}
```

### Creating Multiple Stories

1. **Prepare data file** (JSON format):
   ```bash
   # Create your JSON file with Story data
   # See .github/ISSUE_TEMPLATE/2-story.yml for field definitions
   vim my-stories.json
   ```

2. **Run script**:
   ```bash
   ./scripts/create-stories.sh my-stories.json
   ```

### Creating Multiple Tasks

1. **Prepare data file** (JSON format):
   ```bash
   # Create your JSON file with Task data
   # See .github/ISSUE_TEMPLATE/3-task-*.yml for field definitions
   vim my-tasks.json
   ```

2. **Run script**:
   ```bash
   ./scripts/create-tasks.sh my-tasks.json
   ```

3. **Add scope labels** (manually):
   ```bash
   # Script will output these commands for you
   gh issue edit <issue-number> --add-label <scope>
   ```

**Example JSON structure**:
```json
{
  "stories": [
    {
      "title": "[Story] Example Story Title",
      "user_story": "As a...\nI want...\nso that...",
      "context": "When...\nI want to...\nso I can...",
      "background": "Why important...",
      "acceptance_criteria": "- [ ] Criteria 1",
      "parent_epic": "#123",
      "notes": "Technical notes"
    }
  ]
}
```

**Task JSON structure**:
```json
{
  "tasks": [
    {
      "type": "feature | bug | kaizen",
      "title": "[Feature|Bug|Kaizen] Task Title",
      "scope": "api | web | domain | db | config | infra",
      "description": "Task description",
      "acceptance_criteria": "- [ ] Criteria 1",
      "parent_story": "#123",
      "notes": "Implementation notes"
    }
  ]
}
```

### Benefits

- ⚡ **Fast**: Create 5-20 issues in seconds instead of minutes
- ✅ **Consistent**: All issues follow the same format
- 📝 **Reviewable**: Data file can be reviewed before creation
- 🔄 **Reusable**: Save data files for similar projects

### Important Notes

- **Relationships**: Scripts automatically add parent-child relationships when `parent_epic` (Stories) or `parent_story` (Tasks) is specified in JSON data. GitHub will show these in the issue sidebar.
- **Tasks**: After creating Tasks with `create-tasks.sh`, you must manually add scope labels (`api`, `web`, `domain`, `db`, `config`, `infra`). The script will output the exact commands needed.
- **Field definitions**: Always refer to `.github/ISSUE_TEMPLATE/*.yml` files for authoritative field descriptions and examples.

---

## References

For detailed information, see:
- **[Complete Example](references/complete-example.md)**: Full walkthrough of User Authentication System from requirement to Tasks
- **[Template Reference](references/template-reference.md)**: Detailed field descriptions for Epic, Story, and Task templates

---

## Recommended Implementation Order

When implementing Tasks, follow this order:

1. **db** - Database schema first
2. **domain** - Business logic second
3. **api** - API layer third
4. **web** - UI last
5. **config** - As needed throughout
6. **infra** - Deploy after implementation

---

## Important Notes

### Label Management

**Automatic Labels** (set by templates):
- `epic` for Epic template
- `story` for Story template
- `task` for all Task templates
- `feature`, `bug`, `kaizen` for Task type

**Manual Labels** (YOU MUST ADD):
- Scope labels: `api`, `web`, `domain`, `config`, `infra`, `db`

⚠️ **Important**: After creating each Task, manually add the appropriate scope label.

### Linking Issues

- Reference parent Epic in Story descriptions: "Part of Epic #123"
- Reference parent Story in Task descriptions: "Part of Story #456"
- Use GitHub's issue linking syntax: `#123`
- Use GitHub Projects to visualize Epic → Story → Task relationships

---

## Usage

When a user requests a new feature:

1. **Understand the requirement**
   - Ask clarifying questions if needed
   - Determine if it's an Epic, Story, or Task

2. **Create Epic** (if large feature)
   - Use Epic template (`1-epic.yml`)
   - Define scope and success criteria

3. **Break down into Stories**
   - Identify user-facing capabilities
   - Create Story for each capability using hybrid format
   - Link to parent Epic

4. **Break down into Tasks**
   - Identify which scopes are needed (api, web, domain, db, config, infra)
   - Create one Task per scope per Story
   - Choose appropriate Task type (Feature/Bug/Kaizen)
   - Link to parent Story

5. **Set up labels**
   - Verify automatic labels are set
   - Manually add scope labels to each Task

6. **Add to GitHub Project**
   - Add Epic, Stories, and Tasks to project board
   - Use Epic Board view for Epics
   - Use Story Board view for Stories
   - Use Task Board view for Tasks

7. **Start development**
   - Work on Tasks in recommended order
   - Update Task/Story/Epic status as you progress

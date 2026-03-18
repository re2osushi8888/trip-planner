# Workflow Guide: Epic → Story → Task

This guide provides detailed step-by-step instructions for the two-phase workflow.

---

## Table of Contents

- [Phase 1: Initial Planning (Epic → Story)](#phase-1-initial-planning-epic--story)
- [Phase 2: Development Start (Story → Task)](#phase-2-development-start-story--task)
- [Recommended Implementation Order](#recommended-implementation-order)
- [Label Management](#label-management)
- [Linking Issues](#linking-issues)

---

## Phase 1: Initial Planning (Epic → Story)

Create Epic and Story hierarchy to define your product roadmap. **Do NOT create Tasks at this stage.**

### Step 1: Understand the Requirement

- Ask clarifying questions if needed
- Determine if it's an Epic, Story, or smaller work item
- Identify the user value and business impact

### Step 2: Create Epic (if large feature)

**When**: Large feature spanning multiple Stories and sprints

Use template: `1-epic.yml` → Label: `epic`

**Title format**: `[Epic] <Brief description>`

**Key fields**:
- **Overview**: High-level description of the Epic
- **Scope In**: What's included in this Epic
- **Scope Out**: What's explicitly NOT included
- **Acceptance Criteria**: How to know the Epic is complete
- **Related Stories**: List of Story issue numbers (added as Stories are created)

See [Template Reference](template-reference.md#epic-template) for detailed field descriptions.

### Step 3: Break Down Epic into Stories

**When**: Specific user-facing capability deliverable in 1-2 sprints

Use template: `2-story.yml` → Label: `story`

**Title format**: `[Story] <Feature description>`

**Hybrid format** (combine both):
- **User Story**: "As a [role], I want [feature], so that [benefit]"
- **Job Story**: "When [situation], I want to [motivation], so I can [outcome]"

**Key fields**:
- **User Story**: Role-based perspective
- **Context (Job Story)**: Situation-based perspective
- **Background**: Why this Story is important
- **Acceptance Criteria**: Testable conditions for completion
- **Parent Epic**: Reference to parent Epic issue number (e.g., `#123`)

See [Template Reference](template-reference.md#story-template) for detailed field descriptions.

### Step 4: Add to GitHub Project

1. Add Epic to project board → Use **Epic Board** view
2. Add Stories to project board → Use **Story Board** view
3. Link Stories to their parent Epic in the Story description

**⚠️ Important**: Do NOT create Tasks at this stage. Stories remain in backlog until ready to implement.

---

## Phase 2: Development Start (Story → Task)

When ready to start implementing a specific Story, break it down into Tasks.

### Step 1: Select Story to Implement

- Choose a Story from the backlog
- Ensure parent Epic is approved and understood
- Verify acceptance criteria are clear

### Step 2: Break Down Story into Tasks

**When**: About to start development on a specific Story

**Split by Scope**: Identify which technical scopes are needed:
- `api` - API endpoints and business logic exposure
- `web` - Frontend UI components
- `domain` - Core business logic
- `db` - Database schema and migrations
- `config` - Configuration files
- `infra` - Infrastructure and deployment

**Task Types** (choose appropriate template):
- `3-task-feature.yml` → Labels: `task`, `feature`
- `3-task-bug.yml` → Labels: `task`, `bug`
- `3-task-kaizen.yml` → Labels: `task`, `kaizen`

**Title format**: `[Feature|Bug|Kaizen] <Specific technical task>`

**Key fields**:
- **Scope**: REQUIRED - One of: api, web, domain, db, config, infra
- **Description**: Technical implementation details
- **Acceptance Criteria**: Testable conditions for Task completion
- **Parent Story**: Reference to parent Story issue number (e.g., `#456`)

See [Template Reference](template-reference.md#task-templates) for detailed field descriptions.

### Step 3: Set Up Labels

**Automatic labels** (set by templates):
- `epic` for Epic template
- `story` for Story template
- `task` for all Task templates
- `feature`, `bug`, `kaizen` for Task type

**Manual labels** (YOU MUST ADD):
- Scope labels: `api`, `web`, `domain`, `db`, `config`, `infra`

⚠️ **Important**: After creating each Task, manually add the appropriate scope label:

```bash
gh issue edit <issue-number> --add-label <scope>
```

### Step 4: Add Tasks to GitHub Project

1. Add Tasks to project board → Use **Task Board** view
2. Link Tasks to their parent Story in the Task description

### Step 5: Start Development

Work on Tasks in the recommended implementation order (see below).

Update Task/Story/Epic status as you progress:
- Task: `Todo` → `In Progress` → `Done`
- Story: Completed when all Tasks are done
- Epic: Completed when all Stories are done

---

## Recommended Implementation Order

When implementing Tasks for a Story, follow this order:

1. **db** - Database schema first
   - Design tables, relationships, indexes
   - Create migration scripts

2. **domain** - Business logic second
   - Implement core business rules
   - Write unit tests for domain logic

3. **api** - API layer third
   - Create endpoints that expose domain logic
   - Write integration tests for APIs

4. **web** - UI last
   - Build frontend components
   - Wire up to API endpoints

5. **config** - As needed throughout
   - Environment variables
   - Feature flags
   - System configurations

6. **infra** - Deploy after implementation
   - CI/CD pipeline updates
   - Deployment scripts
   - Infrastructure provisioning

**Rationale**: This order follows the dependency chain from data layer to presentation layer, minimizing rework and enabling incremental testing.

---

## Label Management

### Automatic Labels (set by templates)

These labels are automatically applied when you create an issue using the corresponding template:

- `epic` - Applied by `1-epic.yml` template
- `story` - Applied by `2-story.yml` template
- `task` - Applied by all `3-task-*.yml` templates
- `feature` - Applied by `3-task-feature.yml` template
- `bug` - Applied by `3-task-bug.yml` template
- `kaizen` - Applied by `3-task-kaizen.yml` template

### Manual Labels (YOU MUST ADD)

After creating each Task, you **must manually add** the appropriate scope label:

**Scope labels**:
- `api` - API endpoints and controllers
- `web` - Frontend UI components
- `domain` - Core business logic
- `db` - Database schema and queries
- `config` - Configuration files
- `infra` - Infrastructure and deployment

**How to add**:

```bash
# Using gh CLI
gh issue edit <issue-number> --add-label <scope>

# Example
gh issue edit 123 --add-label api
```

**Why manual?**: GitHub issue templates don't support dynamic label selection based on form input, so scope labels must be added after creation.

### First-Time Setup: Create Labels

Before creating any issues, set up all required GitHub labels:

```bash
cd .claude/skills/issue-planner/scripts
./create-labels.sh
```

This creates 14 labels: `userIdea`, `epic`, `story`, `task`, `feature`, `bug`, `kaizen`, and all scope labels (`api`, `web`, `domain`, `db`, `config`, `infra`).

Use `--force` to update existing labels if definitions change.

---

## Linking Issues

GitHub supports parent-child relationships between issues, which are automatically visualized in the issue sidebar.

### How to Link

**In Story descriptions**, reference the parent Epic:

```markdown
Part of Epic #123
```

**In Task descriptions**, reference the parent Story:

```markdown
Part of Story #456
```

**Use GitHub's issue linking syntax**: `#123`

### Parent-Child Relationships

When using bulk creation scripts (see [Bulk Creation Guide](bulk-creation-guide.md)), relationships are automatically set up when you specify:
- `parent_epic` field in Story JSON data
- `parent_story` field in Task JSON data

GitHub will display these relationships in:
- Issue sidebar (under "Development")
- Issue timeline
- GitHub Projects (as hierarchical views)

### Visualizing Relationships

Use **GitHub Projects** to visualize Epic → Story → Task relationships:

1. Create project views for each level:
   - **Epic Board**: Filter by `label:epic`
   - **Story Board**: Filter by `label:story`
   - **Task Board**: Filter by `label:task`

2. Use **parent-child grouping** in project views to see hierarchical relationships

3. Track progress from Epic level down to individual Tasks

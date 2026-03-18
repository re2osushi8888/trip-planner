---
name: issue-planner
description: Plan and structure GitHub Issues by breaking down user requirements into Epic → Story → Task hierarchy. Use when user wants to create issues, plan features, organize work into epics/stories/tasks, or needs help structuring their backlog. Handles breakdown of large features into manageable pieces with proper scope classification (api, web, domain, db, config, infra).
invocable: true
---

# Issue Creation Workflow

This skill helps you create GitHub Issues following a two-phase Epic → Story → Task hierarchy.

---

## Workflow Overview

### Phase 1: Initial Planning (Epic → Story)

```
User Requirement
    ↓
Epic (Large Feature/Initiative)
    ↓
Story (Job Story + User Story Hybrid)
```

Create Epic and Story hierarchy to define your product roadmap. **Tasks are NOT created at this stage.**

### Phase 2: Development Start (Story → Task)

```
Selected Story
    ↓
Task (Feature/Bug/Kaizen by Scope)
    ↓
Development (Implement by Scope)
```

When ready to start work on a Story, break it down into Tasks by technical scope (api, web, domain, db, config, infra).

---

## Hierarchy Structure

### 1. Epic

Large body of work that encompasses multiple Stories. Typically spans multiple sprints.

**Template**: `1-epic.yml` → Label: `epic`

### 2. Story

Specific feature or capability from the user's perspective. Combines Job Story (context/motivation) and User Story (role/benefit). Typically completed in 1-2 sprints.

**Template**: `2-story.yml` → Label: `story`

### 3. Task

Technical implementation work. Split by scope (api, web, domain, db, config, infra). Typically completed in hours to days.

**Templates**: `3-task-feature.yml`, `3-task-bug.yml`, `3-task-kaizen.yml` → Labels: `task` + type

---

## Quick Reference

### What to Do in Each Phase

**Phase 1: Initial Planning**

1. Create Epic for large features
2. Break down Epic into Stories (user-facing capabilities)
3. Add Epic and Stories to GitHub Project
4. **Stop** - Do not create Tasks yet

**Phase 2: Development Start**

1. Select a Story to implement
2. Break down Story into Tasks (by technical scope)
3. Manually add scope labels to each Task
4. Work on Tasks in recommended order (db → domain → api → web)

---

## Available Tools

### Manual Creation

- Use GitHub Issue templates: `.github/ISSUE_TEMPLATE/1-epic.yml`, `2-story.yml`, `3-task-*.yml`
- Create issues one at a time via GitHub UI

### Bulk Creation Scripts

- **Phase 1**: `create-epics.sh`, `create-stories.sh` - Build product roadmap
- **Phase 2**: `create-tasks.sh` - Create Tasks when starting Story implementation

See [Bulk Creation Guide](references/bulk-creation-guide.md) for detailed usage.

---

## References

For detailed step-by-step instructions, see:

- **[Workflow Guide](references/workflow-guide.md)** - Detailed Phase 1 and Phase 2 procedures, label management, issue linking
- **[Bulk Creation Guide](references/bulk-creation-guide.md)** - How to use scripts to create multiple issues at once
- **[Template Reference](references/template-reference.md)** - Field descriptions for Epic, Story, and Task templates
- **[Complete Example](references/complete-example.md)** - Full walkthrough from requirement to Tasks

---

## Quick Tips

- **Epic Title**: `[Epic] <Brief description>`
- **Story Title**: `[Story] <Feature description>`
- **Task Title**: `[Feature|Bug|Kaizen] <Specific technical task>`
- **Linking**: Reference parent issues with `#123` syntax
- **Scope Labels**: Manually add after creating Tasks (api, web, domain, db, config, infra)
- **Implementation Order**: db → domain → api → web → config → infra

---

## When to Use This Skill

- User wants to create GitHub Issues from requirements
- User asks to plan features or organize work
- User mentions "epic", "story", "task", or backlog planning
- User wants to structure a large feature into manageable pieces
- User asks about proper scope classification or task breakdown

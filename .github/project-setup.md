# GitHub Project Setup Guide

This document describes how to set up GitHub Project views for the trip-planner project.

## Project Information

- **Project Name**: re2osushi8888/trip-planner
- **Project Number**: 2
- **Project ID**: `PVT_kwHOCPVz884BRjqm`
- **URL**: https://github.com/users/re2osushi8888/projects/2

## Existing Views

The following views already exist:
- Backlog (Board)
- Priority board (Board)
- Team items (Table)
- Roadmap (Roadmap)
- My items (Table)

## Recommended Views for Epic-Story-Task Hierarchy

### 1. Epic Board

**Purpose**: Track large features and initiatives

**Setup Steps**:
1. Open the project: https://github.com/users/re2osushi8888/projects/2
2. Click "+ New view" button
3. Enter view name: `Epic Board`
4. Select layout: **Board**
5. Click "Create"
6. Configure the view:
   - Click "..." menu → "Filter"
   - Add filter: `label:epic`
   - Save

**Status Columns** (recommended):
- Backlog
- In Progress
- Done

---

### 2. Story Board

**Purpose**: Track user-facing features and capabilities

**Setup Steps**:
1. Click "+ New view" button
2. Enter view name: `Story Board`
3. Select layout: **Board**
4. Click "Create"
5. Configure the view:
   - Click "..." menu → "Filter"
   - Add filter: `label:story`
   - Save

**Status Columns** (recommended):
- Todo
- In Progress
- Review
- Done

---

### 3. Task Board

**Purpose**: Track technical implementation tasks (Feature, Bug, Kaizen)

**Setup Steps**:
1. Click "+ New view" button
2. Enter view name: `Task Board`
3. Select layout: **Board**
4. Click "Create"
5. Configure the view:
   - Click "..." menu → "Filter"
   - Add filter: `label:task`
   - Save

**Status Columns** (recommended):
- Todo
- In Progress
- Review
- Done

---

### 4. Scope-Specific Boards (Optional)

Create separate boards for each technical scope to track implementation by area.

#### API Board
- Filter: `label:task label:api`
- Track all API-related tasks

#### Web Board
- Filter: `label:task label:web`
- Track all Web UI tasks

#### Domain Board
- Filter: `label:task label:domain`
- Track all Domain logic tasks

#### Database Board
- Filter: `label:task label:db`
- Track all Database tasks

---

### 5. Task Type Boards (Optional)

Track tasks by type across all scopes.

#### Feature Board
- Filter: `label:feature`
- Track all feature implementation tasks

#### Bug Board
- Filter: `label:bug`
- Track all bug fix tasks

#### Kaizen Board
- Filter: `label:kaizen`
- Track all improvement tasks

---

## Burndown Chart

**Note**: Burndown charts are available in the **Insights** tab (beta feature).

**Setup Steps**:
1. Open the project
2. Click the "Insights" tab
3. Click "New chart"
4. Select "Burndown chart"
5. Configure:
   - **Iteration**: Select sprint/iteration field
   - **Count**: Number of issues
   - Save

---

## Label System

The project uses a hierarchical label system based on Epic → Story → Task structure.

### Hierarchy Labels (automatically set by issue templates)
- `epic` - Large features or initiatives spanning multiple Stories
- `story` - User-facing features combining Job Story and User Story formats
- `task` - Technical implementation work

### Task Type Labels (automatically set by task templates)
- `feature` - New feature implementation tasks
- `bug` - Bug fix tasks
- `kaizen` - Improvement tasks

### Scope Labels (manually added to Tasks)
- `api` - API endpoints and backend logic
- `web` - Frontend UI and user interface
- `domain` - Domain logic and business rules
- `db` - Database schema and migrations
- `config` - Configuration and environment setup
- `infra` - Infrastructure, deployment, and CI/CD

### Label Combinations

Examples of how labels combine:
- Epic: `epic`
- Story: `story`
- Feature Task: `task`, `feature`, `api` (or other scope)
- Bug Task: `task`, `bug`, `web` (or other scope)
- Kaizen Task: `task`, `kaizen`, `domain` (or other scope)

---

## Tips

### View Management
- Use **Filters** to create focused views by combining labels:
  - `label:task label:api` - All API tasks
  - `label:feature label:web` - All Web feature tasks
  - `label:story` - All Stories
- Use **Group by** to organize items by Status, Assignee, Labels, or Iteration
- Use **Sort by** to prioritize items by Priority, Updated date, etc.
- Pin frequently used views for quick access

### Workflow Best Practices
- **Epic Board**: Track overall progress of major features
- **Story Board**: Manage user-facing capabilities ready for sprint planning
- **Task Board**: Monitor day-to-day technical implementation
- **Scope Boards**: Enable parallel development across technical areas (api, web, domain, etc.)

### Hierarchy Navigation
- Use issue linking to connect Epic → Story → Task
- Reference parent issues in descriptions: "Part of Epic #123", "Part of Story #456"
- GitHub Projects automatically shows relationships through linked issues

---

## Automation (Future)

Currently, GitHub Projects API does not support View creation via CLI or API.
If this becomes available in the future, we can automate view creation using GitHub CLI or GitHub Actions.

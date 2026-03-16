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

## Recommended Additional Views

### 1. Epic Board

**Purpose**: Track large features and user stories

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

### 2. Task Board

**Purpose**: Track individual tasks (Features, Bugs, Kaizen)

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

### 3. Feature Board (Optional)

**Purpose**: Track only feature tasks

**Setup Steps**:
1. Click "+ New view" button
2. Enter view name: `Feature Board`
3. Select layout: **Board**
4. Click "Create"
5. Configure the view:
   - Click "..." menu → "Filter"
   - Add filter: `label:feature`
   - Save

---

### 4. Bug Board (Optional)

**Purpose**: Track only bug fix tasks

**Setup Steps**:
1. Click "+ New view" button
2. Enter view name: `Bug Board`
3. Select layout: **Board**
4. Click "Create"
5. Configure the view:
   - Click "..." menu → "Filter"
   - Add filter: `label:bug`
   - Save

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

The project uses the following label system:

### Type Labels (automatically set by issue templates)
- `epic` - Large features or user stories
- `feature` - New feature implementation
- `bug` - Bug fixes
- `kaizen` - Improvements
- `task` - Generic task label

### Scope Labels (manually added)
- `api` - API layer
- `web` - Web frontend
- `domain` - Domain logic
- `config` - Configuration
- `infra` - Infrastructure
- `db` - Database

---

## Tips

- Use **Filters** to create focused views by combining labels (e.g., `label:feature label:api`)
- Use **Group by** to organize items by Status, Assignee, or Labels
- Use **Sort by** to prioritize items by Priority, Updated date, etc.
- Pin frequently used views for quick access

---

## Automation (Future)

Currently, GitHub Projects API does not support View creation via CLI or API.
If this becomes available in the future, we can automate view creation using GitHub CLI or GitHub Actions.

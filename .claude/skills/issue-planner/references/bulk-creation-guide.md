# Bulk Creation Guide

This guide explains how to use shell scripts to create multiple Epics, Stories, or Tasks at once.

---

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [First-Time Setup: Create Labels](#first-time-setup-create-labels)
- [Creating Multiple Epics](#creating-multiple-epics)
- [Creating Multiple Stories](#creating-multiple-stories)
- [Creating Multiple Tasks](#creating-multiple-tasks)
- [Benefits](#benefits)
- [Important Notes](#important-notes)

---

## Overview

**Phase 1 (Initial Planning)**: Use `create-epics.sh` and `create-stories.sh` to build your product roadmap.

**Phase 2 (Development Start)**: Use `create-tasks.sh` when ready to start work on a specific Story.

---

## Prerequisites

Install the following tools:

- **`jq`**: JSON processor
  ```bash
  sudo apt-get install jq
  ```

- **`gh`**: GitHub CLI (must be authenticated)
  ```bash
  # Install gh (if not already installed)
  # See: https://cli.github.com/

  # Authenticate
  gh auth login
  ```

---

## First-Time Setup: Create Labels

Before creating any issues, set up all required GitHub labels:

```bash
cd .claude/skills/issue-planner/scripts
./create-labels.sh
```

**What it creates**:
- **Hierarchy labels**: `userIdea`, `epic`, `story`, `task`
- **Type labels**: `feature`, `bug`, `kaizen`
- **Scope labels**: `api`, `web`, `domain`, `db`, `config`, `infra`

Total: **14 labels**

**Update existing labels**:
```bash
./create-labels.sh --force
```

Use `--force` to update label colors/descriptions if definitions change.

---

## Creating Multiple Epics

### Step 1: Prepare Data File

Create a JSON file with Epic data:

```bash
# Create your JSON file
vim my-epics.json
```

**Example JSON structure**:

```json
{
  "epics": [
    {
      "title": "[Epic] User Authentication System",
      "overview": "Implement secure user authentication with OAuth2 and JWT tokens",
      "scope": {
        "in": "- OAuth2 login (Google, GitHub)\n- JWT token management\n- Session handling\n- Password reset flow",
        "out": "- Social media integrations (Twitter, Facebook)\n- Two-factor authentication (separate Epic)"
      },
      "acceptance_criteria": "- [ ] Users can log in with Google/GitHub\n- [ ] Sessions persist across browser restarts\n- [ ] Password reset emails are sent\n- [ ] All authentication endpoints are secured",
      "priority": "High",
      "dependencies": "None",
      "notes": "Must comply with GDPR requirements"
    },
    {
      "title": "[Epic] Payment Processing",
      "overview": "Enable users to make payments using Stripe",
      "scope": {
        "in": "- Stripe integration\n- Payment form UI\n- Receipt generation",
        "out": "- PayPal integration (separate Epic)\n- Subscription management"
      },
      "acceptance_criteria": "- [ ] Users can enter payment details\n- [ ] Payments are processed via Stripe\n- [ ] Receipts are emailed to users",
      "priority": "Medium",
      "dependencies": "Epic #123 (User Authentication)",
      "notes": "Use Stripe test mode initially"
    }
  ]
}
```

**Field definitions**: See `.github/ISSUE_TEMPLATE/1-epic.yml` for authoritative field descriptions.

### Step 2: Run Script

```bash
cd .claude/skills/issue-planner
./scripts/create-epics.sh my-epics.json
```

**Output**:
```
Created Epic #101: [Epic] User Authentication System
Created Epic #102: [Epic] Payment Processing

Summary:
- Created 2 Epics
- All issues labeled with 'epic'
```

---

## Creating Multiple Stories

### Step 1: Prepare Data File

Create a JSON file with Story data:

```bash
# Create your JSON file
vim my-stories.json
```

**Example JSON structure**:

```json
{
  "stories": [
    {
      "title": "[Story] OAuth2 Login with Google",
      "user_story": "As a user\nI want to log in with my Google account\nso that I don't need to create a new password",
      "context": "When I visit the login page\nI want to see a 'Sign in with Google' button\nso I can authenticate quickly",
      "background": "Users prefer social login over creating new accounts. Google is the most popular email provider.",
      "acceptance_criteria": "- [ ] Login page shows 'Sign in with Google' button\n- [ ] Clicking button redirects to Google OAuth consent\n- [ ] Successful auth creates user account if new\n- [ ] User is redirected to dashboard after login",
      "parent_epic": "#101",
      "notes": "Use Google OAuth 2.0 library. Store tokens securely."
    },
    {
      "title": "[Story] Password Reset Flow",
      "user_story": "As a user\nI want to reset my password via email\nso that I can regain access if I forget my password",
      "context": "When I forget my password\nI want to receive a reset link via email\nso I can create a new password",
      "background": "Password reset is a critical security feature for user accounts.",
      "acceptance_criteria": "- [ ] 'Forgot password?' link on login page\n- [ ] Email sent with time-limited reset link\n- [ ] Reset page validates token\n- [ ] User can set new password",
      "parent_epic": "#101",
      "notes": "Reset tokens expire after 1 hour. Rate-limit reset requests."
    }
  ]
}
```

**Field definitions**: See `.github/ISSUE_TEMPLATE/2-story.yml` for authoritative field descriptions.

### Step 2: Run Script

```bash
cd .claude/skills/issue-planner
./scripts/create-stories.sh my-stories.json
```

**Output**:
```
Created Story #103: [Story] OAuth2 Login with Google (Part of Epic #101)
Created Story #104: [Story] Password Reset Flow (Part of Epic #101)

Summary:
- Created 2 Stories
- All issues labeled with 'story'
- Parent-child relationships established
```

**Parent-child relationships**: When `parent_epic` is specified in JSON data, the script automatically links Stories to their parent Epic. GitHub displays this in the issue sidebar.

---

## Creating Multiple Tasks

### Step 1: Prepare Data File

Create a JSON file with Task data:

```bash
# Create your JSON file
vim my-tasks.json
```

**Example JSON structure**:

```json
{
  "tasks": [
    {
      "type": "feature",
      "title": "[Feature] Implement Google OAuth2 API integration",
      "scope": "api",
      "description": "Create API endpoints for Google OAuth2 authentication flow:\n- `/auth/google/login` - Initiate OAuth flow\n- `/auth/google/callback` - Handle OAuth callback\n- JWT token generation after successful auth",
      "acceptance_criteria": "- [ ] OAuth2 flow redirects to Google consent page\n- [ ] Callback endpoint exchanges code for tokens\n- [ ] User profile data is fetched from Google\n- [ ] JWT token is generated and returned\n- [ ] Integration tests pass",
      "parent_story": "#103",
      "notes": "Use `passport-google-oauth20` library. Store client ID/secret in env vars."
    },
    {
      "type": "feature",
      "title": "[Feature] Create Google login UI component",
      "scope": "web",
      "description": "Build frontend component for Google OAuth login:\n- 'Sign in with Google' button\n- Handle OAuth redirect flow\n- Display loading state during auth",
      "acceptance_criteria": "- [ ] Button displays Google logo and text\n- [ ] Clicking button redirects to `/auth/google/login`\n- [ ] Loading spinner shows during auth\n- [ ] User redirected to dashboard on success\n- [ ] Error message shown on failure",
      "parent_story": "#103",
      "notes": "Use Material-UI button component. Match existing design system."
    },
    {
      "type": "feature",
      "title": "[Feature] Google OAuth database schema",
      "scope": "db",
      "description": "Create database tables for OAuth authentication:\n- `oauth_providers` table\n- `oauth_tokens` table\n- Add `oauth_provider_id` to `users` table",
      "acceptance_criteria": "- [ ] Migration script created\n- [ ] Tables include all required fields\n- [ ] Foreign keys properly set up\n- [ ] Indexes on frequently queried columns\n- [ ] Migration runs successfully",
      "parent_story": "#103",
      "notes": "Use Prisma for schema definition. Encrypt OAuth tokens at rest."
    }
  ]
}
```

**Field definitions**: See `.github/ISSUE_TEMPLATE/3-task-*.yml` for authoritative field descriptions.

### Step 2: Run Script

```bash
cd .claude/skills/issue-planner
./scripts/create-tasks.sh my-tasks.json
```

**Output**:
```
Created Feature Task #105: [Feature] Implement Google OAuth2 API integration (Part of Story #103)
Created Feature Task #106: [Feature] Create Google login UI component (Part of Story #103)
Created Feature Task #107: [Feature] Google OAuth database schema (Part of Story #103)

Summary:
- Created 3 Tasks
- All issues labeled with 'task' and type ('feature', 'bug', or 'kaizen')
- Parent-child relationships established

⚠️  IMPORTANT: Manually add scope labels to each Task:

gh issue edit 105 --add-label api
gh issue edit 106 --add-label web
gh issue edit 107 --add-label db
```

### Step 3: Add Scope Labels (Manual)

**Why manual?**: GitHub issue templates don't support dynamic label selection based on form input.

**Run the commands** output by the script:

```bash
gh issue edit 105 --add-label api
gh issue edit 106 --add-label web
gh issue edit 107 --add-label db
```

**Tip**: Copy and paste the commands directly from the script output.

---

## Benefits

- ⚡ **Fast**: Create 5-20 issues in seconds instead of minutes
- ✅ **Consistent**: All issues follow the same format and structure
- 📝 **Reviewable**: Data file can be reviewed before creation (no surprises)
- 🔄 **Reusable**: Save data files as templates for similar projects
- 🔗 **Relationships**: Parent-child links are automatically established

---

## Important Notes

### Relationships

Scripts automatically add parent-child relationships when you specify:
- `parent_epic` (in Stories JSON) → Links Story to Epic
- `parent_story` (in Tasks JSON) → Links Task to Story

GitHub will display these relationships in:
- Issue sidebar (under "Development")
- Issue timeline
- GitHub Projects (as hierarchical views)

### Scope Labels for Tasks

After creating Tasks with `create-tasks.sh`, you **must manually add scope labels**:
- `api`, `web`, `domain`, `db`, `config`, `infra`

The script will output the exact `gh issue edit` commands needed. Copy and run them.

**Why?**: GitHub issue templates cannot dynamically assign labels based on form input (the `scope` field in the Task template is just text, not a label selector).

### Field Definitions

Always refer to `.github/ISSUE_TEMPLATE/*.yml` files for authoritative field descriptions and examples:
- `1-epic.yml` - Epic template
- `2-story.yml` - Story template
- `3-task-feature.yml` - Feature Task template
- `3-task-bug.yml` - Bug Task template
- `3-task-kaizen.yml` - Kaizen (improvement) Task template

### Workflow Phases

- **Phase 1 (Initial Planning)**: Use `create-epics.sh` and `create-stories.sh` to build your product roadmap
- **Phase 2 (Development Start)**: Use `create-tasks.sh` only when ready to start work on a specific Story

Do NOT create all Tasks upfront. Create Tasks just-in-time when starting Story implementation.

---
name: create-issue
description: Guide for creating GitHub Issues (Epic, Story, Task) from user requirements
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

## Step 1: Create an Epic

### When to Create an Epic

Create an Epic when:
- User requests a large feature or initiative
- The work requires multiple Stories
- The feature spans multiple sprints (weeks)
- You need to track a major deliverable

### Epic Template Selection

Use the **Epic** template (`1-epic.yml`)

### Epic Structure

**Title Format:**
```
[Epic] <Brief description of the initiative>
```

**Examples:**
```
[Epic] User Authentication System
[Epic] Trip Search and Filtering
[Epic] Payment Integration with Stripe
```

**Key Fields:**
- **Overview**: High-level description of the Epic
- **Scope**: What's included and excluded
- **Epic Acceptance Criteria**: High-level completion criteria
- **Related Stories**: List of Stories (update as created)
- **Success Metrics**: How to measure success

**Labels:**
- `epic` (automatically set by template)

---

## Step 2: Break Down Epic into Stories

### When to Create a Story

Create a Story when:
- You have a specific user-facing feature or capability
- The work can be completed in 1-2 sprints
- It delivers value independently
- It requires multiple technical Tasks

### Story Template Selection

Use the **Story** template (`2-story.yml`)

### Story Structure (Hybrid Format)

**Title Format:**
```
[Story] <Specific feature description>
```

**Examples:**
```
[Story] User can log in with email and password
[Story] User can search destinations by budget
[Story] User can reset forgotten password
```

**Key Fields:**

1. **User Story** (Required):
   ```
   As a [role/persona],
   I want [feature/capability],
   so that [benefit/value].
   ```

2. **Context & Motivation (Job Story)** (Optional but recommended):
   ```
   When [situation/context],
   I want to [motivation/need],
   so I can [expected outcome].
   ```

3. **Acceptance Criteria** (Required):
   - Specific, testable criteria
   - Use "Given-When-Then" format when possible

4. **Related Tasks**: List technical Tasks (update as created)

5. **Definition of Done**: Checklist of completion items

6. **Parent Epic**: Link to parent Epic (e.g., "Part of Epic #123")

**Labels:**
- `story` (automatically set by template)

---

## Step 3: Break Down Story into Tasks

### Task Breakdown Strategy

**Split by Scope (Technical Layers):**

Each Story should be broken down into Tasks based on the affected technical areas:

| Scope | Description | Label |
|-------|-------------|-------|
| `api` | API endpoints, backend logic | `api` |
| `web` | Frontend UI, user interface | `web` |
| `domain` | Domain logic, business rules | `domain` |
| `db` | Database schema, migrations | `db` |
| `config` | Configuration, environment setup | `config` |
| `infra` | Infrastructure, deployment, CI/CD | `infra` |

**Task Types:**

Choose the appropriate task type:
- **Feature** (`3-task-feature.yml`): New functionality implementation
- **Bug** (`3-task-bug.yml`): Bug fixes
- **Kaizen** (`3-task-kaizen.yml`): Improvements to existing code

---

## Step 4: Create Tasks

### Task Template Selection

- **Feature Task**: `3-task-feature.yml`
- **Bug Task**: `3-task-bug.yml`
- **Kaizen Task**: `3-task-kaizen.yml`

### Task Structure

**Title Format:**
```
[Feature] <Specific technical task>
[Bug] <Bug description>
[Kaizen] <Improvement description>
```

**Examples:**
```
[Feature] Implement user login API endpoint
[Feature] Create login UI component
[Feature] Add authentication domain logic
[Bug] Fix authentication token expiration
[Kaizen] Refactor authentication middleware for better performance
```

**Key Fields:**

1. **Scope** (Required): Select ONE scope (api, web, domain, db, config, infra)
2. **Description** (Required): Technical description of the work
3. **Acceptance Criteria**: Technical completion criteria
4. **Parent Story**: Link to parent Story (e.g., "Part of Story #456")

**Labels:**
- Type label: `feature`, `bug`, or `kaizen` (automatically set)
- `task` (automatically set)
- **Scope label**: `api`, `web`, `domain`, `db`, `config`, or `infra` (MANUALLY ADD)

⚠️ **Important**: After creating each Task, manually add the appropriate scope label.

---

## Complete Example

### User Requirement
> "I want users to be able to log in and log out of the application"

---

### Epic Creation

**Title:** `[Epic] User Authentication System`

**Overview:**
```
Build a complete authentication system that allows users to securely log in,
log out, and manage their sessions. This includes email/password authentication,
session management, and basic security features.
```

**Scope:**
```
### In Scope
- Email/password login
- User logout
- Session management with JWT
- Protected routes

### Out of Scope
- Social login (separate Epic)
- Two-factor authentication (future)
- Password reset (separate Story)
```

**Epic Acceptance Criteria:**
```
- [ ] All authentication Stories are completed
- [ ] Users can log in and log out successfully
- [ ] Sessions are managed securely
- [ ] All tests pass
- [ ] Security review is complete
```

**Labels:** `epic`

---

### Story Breakdown

#### Story 1: User Login

**Title:** `[Story] User can log in with email and password`

**User Story:**
```
As a registered user,
I want to log in with my email and password,
so that I can access my personalized trip planning features.
```

**Context (Job Story):**
```
When I return to the application,
I want to quickly authenticate myself,
so I can continue planning my trips without losing my data.
```

**Acceptance Criteria:**
```
- [ ] Given valid credentials, when user submits login form, then user is authenticated and redirected to dashboard
- [ ] Given invalid credentials, when user submits login form, then error message is displayed
- [ ] Login form works on desktop and mobile browsers
- [ ] Login API responds within 500ms
- [ ] Failed login attempts are rate-limited
```

**Parent Epic:** `Part of Epic #123`

**Labels:** `story`

**Related Tasks:** (to be created)
```
- [ ] #201 - [Feature] Implement login API endpoint (api)
- [ ] #202 - [Feature] Create login UI component (web)
- [ ] #203 - [Feature] Add authentication domain logic (domain)
- [ ] #204 - [Feature] Create users table schema (db)
- [ ] #205 - [Feature] Set up JWT configuration (config)
```

---

#### Story 2: User Logout

**Title:** `[Story] User can log out`

**User Story:**
```
As an authenticated user,
I want to log out of the application,
so that I can secure my account when I'm done.
```

**Acceptance Criteria:**
```
- [ ] Given authenticated user, when user clicks logout, then session is terminated
- [ ] After logout, user is redirected to login page
- [ ] Logout button is visible in navigation
```

**Parent Epic:** `Part of Epic #123`

**Labels:** `story`

---

### Task Breakdown (for Story 1)

#### Task 1: Database

**Title:** `[Feature] Create users table and authentication schema`

**Scope:** `db`

**Description:**
```
Create database schema for user authentication.

Tables needed:
- users: id, email, password_hash, created_at, updated_at
- sessions: id, user_id, token, expires_at

Indexes:
- users.email (unique)
- sessions.token
```

**Parent Story:** `Part of Story #456`

**Labels:** `task`, `feature`, `db` (manual)

---

#### Task 2: Domain Logic

**Title:** `[Feature] Implement user authentication domain logic`

**Scope:** `domain`

**Description:**
```
Implement domain logic for authentication:
- User entity with validation
- Password hashing (bcrypt)
- JWT token generation and validation
- Session management logic
```

**Parent Story:** `Part of Story #456`

**Labels:** `task`, `feature`, `domain` (manual)

---

#### Task 3: API

**Title:** `[Feature] Implement login API endpoint`

**Scope:** `api`

**Description:**
```
Create POST /api/auth/login endpoint:
- Accept email and password
- Validate credentials
- Generate JWT token
- Return user data and token
- Handle errors (invalid credentials, rate limiting)
```

**Parent Story:** `Part of Story #456`

**Labels:** `task`, `feature`, `api` (manual)

---

#### Task 4: Web UI

**Title:** `[Feature] Create login UI component`

**Scope:** `web`

**Description:**
```
Create login form component:
- Email and password input fields
- Submit button
- Error message display
- Loading state
- Form validation
- Redirect after successful login
```

**Parent Story:** `Part of Story #456`

**Labels:** `task`, `feature`, `web` (manual)

---

#### Task 5: Configuration

**Title:** `[Feature] Set up JWT and authentication configuration`

**Scope:** `config`

**Description:**
```
Configure authentication settings:
- JWT secret (environment variable)
- Token expiration (24 hours)
- CORS settings for auth endpoints
- Rate limiting configuration
```

**Parent Story:** `Part of Story #456`

**Labels:** `task`, `feature`, `config` (manual)

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

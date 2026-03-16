---
name: create-issue
description: Guide for creating GitHub Issues (Epic and Tasks) from user requirements
invocable: true
---

# Issue Creation Workflow

This skill provides guidelines for creating GitHub Issues based on user requirements.

## Workflow Overview

```
User Requirement
    ↓
Epic (Large Feature/User Story)
    ↓
Tasks (Split by Scope Labels)
    ↓
Development (Implement by Scope)
```

---

## Step 1: Create an Epic

### When to Create an Epic

Create an Epic when:
- User requests a large feature or user story
- The work requires multiple tasks across different areas (api, web, domain, etc.)
- The feature takes more than 1-2 days to implement

### Epic Template Selection

Use the **Epic** issue template (`epic.yml`)

### Epic Structure

**Title Format:**
```
[Epic] <Brief description of the feature>
```

**Example:**
```
[Epic] User Authentication System
[Epic] Trip Search and Filtering
[Epic] Payment Integration with Stripe
```

**Description:**
- **What**: Describe the feature from a user perspective
- **Why**: Explain the business value or user need
- **Scope**: High-level overview of what's included

**Acceptance Criteria:**
- Define clear criteria for when the Epic is complete
- Use checkboxes for major milestones

**Labels:**
- `epic` (automatically set by template)

---

## Step 2: Break Down Epic into Tasks

### Task Breakdown Strategy

**Split by Scope (Technical Layers):**

Each Epic should be broken down into Tasks based on the affected technical areas:

| Scope | Description | Label |
|-------|-------------|-------|
| `api` | API endpoints, business logic exposed via API | `api` |
| `web` | Frontend UI, user interface components | `web` |
| `domain` | Domain logic, business rules, entities | `domain` |
| `config` | Configuration, environment setup | `config` |
| `infra` | Infrastructure, deployment, CI/CD | `infra` |
| `db` | Database schema, migrations, queries | `db` |

**Task Types:**

Choose the appropriate task type for each task:
- **Feature** (`feature.yml`): New functionality
- **Bug** (`bug.yml`): Bug fixes (if discovered during Epic implementation)
- **Kaizen** (`kaizen.yml`): Improvements to existing code

---

## Step 3: Create Tasks

### Task Template Selection

Most tasks will use the **Feature** template (`feature.yml`)

### Task Structure

**Title Format:**
```
[Feature] <Specific task description>
[Bug] <Bug description>
[Kaizen] <Improvement description>
```

**Examples:**
```
[Feature] Implement user login API endpoint
[Feature] Create login UI component
[Feature] Add user authentication domain logic
[Feature] Set up JWT configuration
[Feature] Create users table schema
```

**Description:**
- Be specific about what needs to be implemented
- Reference the parent Epic (e.g., "Part of #123 User Authentication Epic")

**Scope Selection:**
- Select ONE scope from the dropdown: api, web, domain, config, infra, db, Other
- **Important**: Manually add the corresponding scope label after creating the issue

**Labels:**
- Type label: `feature`, `bug`, or `kaizen` (automatically set)
- `task` (automatically set)
- **Scope label**: `api`, `web`, `domain`, `config`, `infra`, or `db` (MANUALLY ADD)

**Checklist:**
- Break down the task into actionable steps
- Include testing requirements

---

## Complete Example

### User Requirement
> "I want users to be able to log in and log out of the application"

### Epic Creation

**Title:** `[Epic] User Authentication System`

**Description:**
```markdown
As a user, I want to be able to log in and log out of the application so that I can access personalized features.

## Scope
- User login with email and password
- User logout
- Session management
- JWT token-based authentication

## Out of Scope
- Social login (Google, Facebook, etc.)
- Password reset (will be separate Epic)
```

**Acceptance Criteria:**
```markdown
- [ ] Users can log in with email and password
- [ ] Users can log out
- [ ] Sessions are managed securely with JWT
- [ ] Protected routes require authentication
- [ ] All tests pass
```

**Labels:** `epic`

---

### Task Breakdown

#### 1. Database Task
**Title:** `[Feature] Create users table and authentication schema`
**Scope:** `db`
**Labels:** `feature`, `task`, `db`
**Description:**
```markdown
Part of #123 User Authentication Epic

Create database schema for user authentication.

## Requirements
- Users table with id, email, password_hash, created_at, updated_at
- Sessions table for token management
- Indexes on email for fast lookup
```

---

#### 2. Domain Task
**Title:** `[Feature] Implement user authentication domain logic`
**Scope:** `domain`
**Labels:** `feature`, `task`, `domain`
**Description:**
```markdown
Part of #123 User Authentication Epic

Implement domain logic for user authentication.

## Requirements
- User entity with validation
- Password hashing and verification
- JWT token generation and validation
- Session management logic
```

---

#### 3. API Task
**Title:** `[Feature] Implement login and logout API endpoints`
**Scope:** `api`
**Labels:** `feature`, `task`, `api`
**Description:**
```markdown
Part of #123 User Authentication Epic

Implement API endpoints for authentication.

## Requirements
- POST /api/auth/login - User login endpoint
- POST /api/auth/logout - User logout endpoint
- Authentication middleware for protected routes
- Input validation and error handling
```

---

#### 4. Web Task
**Title:** `[Feature] Create login and logout UI components`
**Scope:** `web`
**Labels:** `feature`, `task`, `web`
**Description:**
```markdown
Part of #123 User Authentication Epic

Create user interface for authentication.

## Requirements
- Login form component with email and password fields
- Logout button
- Error message display
- Loading states
- Redirect after successful login
```

---

#### 5. Config Task
**Title:** `[Feature] Set up JWT and authentication configuration`
**Scope:** `config`
**Labels:** `feature`, `task`, `config`
**Description:**
```markdown
Part of #123 User Authentication Epic

Configure authentication settings.

## Requirements
- JWT secret configuration
- Token expiration settings
- CORS settings for auth endpoints
- Environment variables for auth settings
```

---

## Important Notes

### Label Management

**Automatic Labels** (set by templates):
- `epic` for Epic template
- `feature`, `bug`, `kaizen` for task type
- `task` for all tasks

**Manual Labels** (YOU MUST ADD):
- Scope labels: `api`, `web`, `domain`, `config`, `infra`, `db`

⚠️ **Important**: After creating each task, manually add the appropriate scope label to the issue.

### Linking Issues

- Reference the parent Epic in task descriptions (e.g., "Part of #123")
- Use GitHub's issue linking syntax: `#123`
- Consider using GitHub Projects to track Epic → Task relationships

### Task Ordering

Recommended implementation order:
1. `db` - Database schema first
2. `domain` - Business logic second
3. `api` - API layer third
4. `web` - UI last
5. `config` - As needed throughout
6. `infra` - Deploy after implementation

---

## Usage

When a user requests a new feature:

1. **Understand the requirement**
   - Ask clarifying questions if needed

2. **Create Epic**
   - Use Epic template
   - Write clear description and acceptance criteria

3. **Break down into Tasks**
   - Identify which scopes are needed (api, web, domain, db, config, infra)
   - Create one task per scope
   - Choose appropriate task type (Feature/Bug/Kaizen)

4. **Set up labels**
   - Verify automatic labels are set
   - Manually add scope labels to each task

5. **Link issues**
   - Reference Epic in task descriptions
   - Add tasks to GitHub Project board

6. **Start development**
   - Work on tasks in recommended order
   - Update task status as you progress

# Complete Example: User Authentication System

This reference provides a detailed walkthrough of breaking down a user requirement into Epic → Story → Task hierarchy.

## User Requirement
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


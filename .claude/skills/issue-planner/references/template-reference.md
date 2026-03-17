# Template Reference Guide

Detailed reference for each issue template in the Epic → Story → Task hierarchy.

## Table of Contents

1. [Epic Template](#epic-template)
2. [Story Template](#story-template)
3. [Task Templates](#task-templates)
   - [Feature Task](#feature-task)
   - [Bug Task](#bug-task)
   - [Kaizen Task](#kaizen-task)

---

## Epic Template

**File**: `1-epic.yml`
**Label**: `epic`
**When to use**: Large features or initiatives spanning multiple Stories and sprints

### Title Format

```
[Epic] <Brief description of the initiative>
```

### Examples

```
[Epic] User Authentication System
[Epic] Trip Search and Filtering
[Epic] Payment Integration with Stripe
```

### Key Fields

| Field | Required | Description |
|-------|----------|-------------|
| Overview | ✅ | High-level description of the Epic |
| Scope | ✅ | What's included and excluded (In Scope / Out of Scope) |
| Epic Acceptance Criteria | ✅ | High-level completion criteria with checkboxes |
| Related Stories | ⚪ | List of Stories belonging to this Epic (update as created) |
| Priority | ⚪ | High / Medium / Low |
| Success Metrics | ⚪ | How to measure success (e.g., adoption rate, performance) |
| Dependencies | ⚪ | Dependencies or blockers |
| Additional Notes | ⚪ | Design docs, architecture diagrams, references |

### Best Practices

- Keep Overview focused on business value and user impact
- Clearly define In Scope and Out of Scope to prevent scope creep
- Update Related Stories list as Stories are created
- Link to design documents and technical specifications
- Define measurable Success Metrics when possible

---

## Story Template

**File**: `2-story.yml`
**Label**: `story`
**When to use**: Specific user-facing features or capabilities deliverable in 1-2 sprints

### Title Format

```
[Story] <Specific feature description>
```

### Examples

```
[Story] User can log in with email and password
[Story] User can search destinations by budget
[Story] User can reset forgotten password
```

### Hybrid Format

Stories combine two complementary formats:

#### User Story (Required)

```
As a [role/persona],
I want [feature/capability],
so that [benefit/value].
```

**Example:**
```
As a registered user,
I want to log in with my email and password,
so that I can access my personalized trip planning features.
```

#### Job Story / Context (Optional but recommended)

```
When [situation/context],
I want to [motivation/need],
so I can [expected outcome].
```

**Example:**
```
When I return to the application,
I want to quickly authenticate myself,
so I can continue planning my trips without losing my data.
```

### Key Fields

| Field | Required | Description |
|-------|----------|-------------|
| User Story | ✅ | "As a [role], I want [feature], so that [benefit]" |
| Context & Motivation | ⚪ | Job Story format providing situational context |
| Background | ⚪ | Additional context or rationale |
| Acceptance Criteria | ✅ | Specific, testable criteria (use Given-When-Then) |
| Related Tasks | ⚪ | List of Tasks needed (update as created) |
| Definition of Done | ⚪ | Checklist of completion items |
| Parent Epic | ⚪ | Link to parent Epic (e.g., "Part of Epic #123") |
| Design & Technical Notes | ⚪ | Mockups, technical approach, API specs |
| Additional Notes | ⚪ | Other relevant information |

### Best Practices

- Write User Story from the user's perspective, not technical implementation
- Use Job Story to add situational context and motivation
- Make Acceptance Criteria specific and testable (Given-When-Then format)
- Include both functional and non-functional criteria (performance, accessibility)
- Link to parent Epic for traceability
- Update Related Tasks list as Tasks are created

---

## Task Templates

Tasks represent technical implementation work, split by scope.

### Common Fields Across All Task Types

| Field | Required | Description |
|-------|----------|-------------|
| Scope | ✅ | Technical area: api / web / domain / db / config / infra / other |
| Description | ✅ | Technical description of the work |
| Acceptance Criteria | ⚪ | Technical completion criteria |
| Parent Story | ⚪ | Link to parent Story (e.g., "Part of Story #456") |
| Dependencies | ⚪ | Other Tasks that must be completed first |
| Additional Notes | ⚪ | Code snippets, references, helpful information |

### Scope Definitions

| Scope | Description | Examples |
|-------|-------------|----------|
| `api` | API endpoints, backend logic | REST endpoints, GraphQL resolvers |
| `web` | Frontend UI, user interface | React components, forms, pages |
| `domain` | Domain logic, business rules | Entities, validators, business logic |
| `db` | Database schema, migrations | Tables, indexes, queries |
| `config` | Configuration, environment setup | Environment variables, app config |
| `infra` | Infrastructure, deployment, CI/CD | Docker, deployment scripts, pipelines |

---

## Feature Task

**File**: `3-task-feature.yml`
**Labels**: `task`, `feature`
**When to use**: Implementing new functionality

### Title Format

```
[Feature] <Specific technical task>
```

### Examples

```
[Feature] Implement user login API endpoint
[Feature] Create login UI component
[Feature] Add authentication domain logic
[Feature] Create users table schema
[Feature] Set up JWT configuration
```

### Specific Fields

| Field | Required | Description |
|-------|----------|-------------|
| Implementation Notes | ⚪ | Technical details, approach, libraries to use |

### Best Practices

- Be specific about what needs to be built
- Mention which files/modules will be affected
- Include implementation approach or patterns to follow
- Reference existing code or patterns when applicable

---

## Bug Task

**File**: `3-task-bug.yml`
**Labels**: `task`, `bug`
**When to use**: Fixing bugs

### Title Format

```
[Bug] <Bug description>
```

### Examples

```
[Bug] Fix authentication token expiration issue
[Bug] Correct login form validation error
[Bug] Resolve session persistence problem
```

### Specific Fields

| Field | Required | Description |
|-------|----------|-------------|
| Severity | ✅ | Critical / High / Medium / Low |
| Steps to Reproduce | ✅ | Detailed steps to reproduce the bug |
| Expected Behavior | ✅ | What should happen |
| Actual Behavior | ✅ | What actually happens |
| Environment | ⚪ | OS, Browser, Node.js version, App version |
| Error Logs | ⚪ | Relevant error messages or stack traces |
| Screenshots | ⚪ | Visual evidence of the bug |
| Fix Approach | ⚪ | Proposed solution or investigation areas |

### Best Practices

- Provide clear, reproducible steps
- Include environment details for environment-specific bugs
- Attach error logs and screenshots when applicable
- Set appropriate severity level to help with prioritization
- Suggest fix approach if you have insights

---

## Kaizen Task

**File**: `3-task-kaizen.yml`
**Labels**: `task`, `kaizen`
**When to use**: Improving existing code or processes

### Title Format

```
[Kaizen] <Improvement description>
```

### Examples

```
[Kaizen] Refactor authentication middleware for better performance
[Kaizen] Improve error handling in login flow
[Kaizen] Optimize database queries for user lookup
```

### Specific Fields

| Field | Required | Description |
|-------|----------|-------------|
| Improvement Type | ✅ | Performance / Code Quality / DX / Architecture / Security / Accessibility / Documentation / Testing / Other |
| Current State | ✅ | Describe current implementation or problem |
| Proposed Improvement | ✅ | Describe the proposed change |
| Expected Benefits | ✅ | What benefits will this provide |
| Implementation Approach | ⚪ | How to implement the improvement |
| Priority | ⚪ | High / Medium / Low |
| Effort Estimate | ⚪ | Small (<1 day) / Medium (1-3 days) / Large (>3 days) |
| Risks & Considerations | ⚪ | Potential breaking changes, compatibility concerns |

### Best Practices

- Clearly articulate current pain points or inefficiencies
- Quantify expected benefits when possible (e.g., "50% faster", "reduce complexity by 30%")
- Consider risks and backward compatibility
- Estimate effort to help with prioritization
- Link to examples or best practices from other projects

---

## Label Management

### Automatic Labels

Set automatically by templates:
- `epic` - Epic template
- `story` - Story template
- `task` - All Task templates
- `feature` - Feature Task template
- `bug` - Bug Task template
- `kaizen` - Kaizen Task template

### Manual Labels

**MUST be added manually after creating the issue:**
- `api` - API scope
- `web` - Web scope
- `domain` - Domain scope
- `db` - Database scope
- `config` - Configuration scope
- `infra` - Infrastructure scope

⚠️ **Important**: After creating each Task, manually add the appropriate scope label to enable filtering and organization in GitHub Projects.

---

## Linking Issues

Use GitHub's issue linking syntax to create relationships:

```markdown
Part of Epic #123
Part of Story #456
Depends on Task #789
Blocks #321
Related to #654
```

This creates automatic backlinks and helps visualize dependencies in GitHub Projects.

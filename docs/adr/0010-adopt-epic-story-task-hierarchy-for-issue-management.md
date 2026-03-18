# 10. Adopt Epic-Story-Task Hierarchy for Issue Management

Date: 2026-03-17
Status: Accepted

## Context

At the project inception, we needed to establish a clear and consistent structure for managing GitHub Issues to support effective team collaboration and project tracking. The challenge was to design a hierarchy that would:

1. **Enable decomposition of large features** into manageable units of work
2. **Provide clarity** on what constitutes an Epic, Story, or Task
3. **Support scope-based development** where work is split by technical areas (api, web, domain, etc.)
4. **Facilitate planning and tracking** across multiple levels of granularity
5. **Combine user perspective with situational context** in feature descriptions

We needed to decide on:

- The hierarchical structure (number of levels and their relationships)
- The format and content of each level
- How to organize technical implementation work

The initial discussion explored whether to use a two-level (Epic → Task) or three-level (Epic → Story → Task) hierarchy, and how to best describe user-facing features.

## Decision

We adopt a **three-level hierarchy: Epic → Story → Task** for GitHub Issue management with the following characteristics:

### 1. Epic Level

- Represents large bodies of work spanning multiple Stories
- Typically takes multiple sprints to complete
- Template: `1-epic.yml`
- Label: `epic`
- Contains: Overview, Scope (in/out), Acceptance Criteria, Related Stories, Success Metrics

### 2. Story Level (Hybrid Format)

- Represents specific user-facing features or capabilities
- Completes within 1-2 sprints
- Template: `2-story.yml`
- Label: `story`
- **Hybrid format combining:**
  - **User Story**: "As a [role], I want [feature], so that [benefit]" (who, what, why)
  - **Job Story**: "When [situation], I want to [motivation], so I can [outcome]" (when, context, motivation)
- Contains: Both story formats, Acceptance Criteria, Definition of Done, Related Tasks

### 3. Task Level

- Represents technical implementation work
- Split by **scope** (technical area):
  - `api` - API endpoints, backend logic
  - `web` - Frontend UI, user interface
  - `domain` - Domain logic, business rules
  - `db` - Database schema, migrations
  - `config` - Configuration, environment setup
  - `infra` - Infrastructure, deployment, CI/CD
- Three types:
  - **Feature** (`3-task-feature.yml`): New functionality
  - **Bug** (`3-task-bug.yml`): Bug fixes
  - **Kaizen** (`3-task-kaizen.yml`): Improvements
- Labels: `task` + type (`feature`/`bug`/`kaizen`) + scope (manual)

### Template Naming Convention

- File prefixes (1-, 2-, 3-) control display order in GitHub UI
- Sequential numbering ensures consistent presentation

**Alternatives considered:**

- **Option 1: Two-level hierarchy (Epic → Task)**
  - Why rejected: Lacks intermediate level for user-facing features, makes it harder to group related technical work, and doesn't provide clear acceptance criteria at the user story level

- **Option 2: Pure User Story format for Story level**
  - Why rejected: Misses situational context and motivation that Job Story format provides, which is valuable for understanding when and why a feature is needed

- **Option 3: Pure Job Story format for Story level**
  - Why rejected: Loses clarity on user roles and benefits that User Story format provides, which helps with stakeholder communication and prioritization

- **Option 4: No scope-based Task classification**
  - Why rejected: Makes it difficult to parallelize work across technical areas, harder to identify dependencies, and lacks clear ownership boundaries

## Consequences

### Positive

1. **Clear hierarchy and relationships**: Three distinct levels provide appropriate granularity for planning (Epic), delivery (Story), and implementation (Task)

2. **Rich contextual information**: Hybrid Story format captures both user perspective (User Story) and situational context (Job Story), providing comprehensive understanding for developers and stakeholders

3. **Scope-based parallelization**: Task classification by technical area (api, web, domain, etc.) enables:
   - Parallel development across different technical layers
   - Clear ownership and expertise alignment
   - Easier dependency identification
   - Recommended implementation order (db → domain → api → web)

4. **Consistent Issue creation**: Templates with structured fields ensure all Issues contain necessary information, reducing back-and-forth clarification

5. **Integration with GitHub Projects**: Labels and hierarchy map well to GitHub Projects views (Epic Board, Story Board, Task Board)

6. **Flexibility in Story description**: Hybrid format allows teams to emphasize either role-based or context-based aspects depending on the situation

### Negative

1. **Learning curve**: Team members need to understand three different template types and when to use each, which requires training and documentation

2. **Template complexity**: More sophisticated templates with multiple required and optional fields may feel heavyweight for simple changes

3. **Manual label management**: Scope labels must be added manually to Tasks after creation, creating potential for inconsistency

4. **Maintenance overhead**: Multiple template files require updates when the structure evolves, and the `/create-issue` skill must stay synchronized

5. **Potential for misclassification**: Users may struggle to determine whether something should be an Epic, Story, or Task, especially early in the project

### Neutral

1. **Three-level structure is standard in Agile**: Aligns with common practices (Epic/Feature/Story/Task), making it familiar to developers with Agile experience

2. **GitHub Projects configuration required**: Teams need to set up appropriate views and filters to take full advantage of the hierarchy

3. **Suitable for medium-to-large projects**: The three-level structure provides good value for projects with substantial scope; smaller projects might find it overkill

4. **Requires discipline**: Success depends on consistent application of the templates and classification rules by all team members

## Related

- `/create-issue` skill provides detailed guidance on using this hierarchy
- GitHub Project setup guide (`.github/project-setup.md`) documents view configuration
- Template files: `.github/ISSUE_TEMPLATE/1-epic.yml`, `2-story.yml`, `3-task-*.yml`

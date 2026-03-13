# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) for the trip-planner project.

## About ADRs

ADRs document important architectural decisions made during the project, including the context, the decision itself, and its consequences. This helps team members understand why certain choices were made and provides historical context for future decisions.

## Index

| Number | Title | Status | Date |
|--------|-------|--------|------|
| [0001](0001-record-architecture-decisions.md) | Record Architecture Decisions | Accepted | 2026-03-12 |
| [0002](0002-do-not-adopt-adr-tools.md) | Do Not Adopt adr-tools for ADR Management | Accepted | 2026-03-13 |

## ADR Lifecycle

- **Proposed**: Under consideration
- **Accepted**: Approved and ready for implementation
- **Rejected**: Considered but not adopted
- **Deprecated**: No longer applicable
- **Superseded**: Replaced by another ADR (with reference)

## Creating New ADRs

Use the `/adr` command to interactively create a new ADR from your conversation with Claude.

Alternatively, copy the template and follow the naming convention:
```bash
cp docs/adr/0000-template.md docs/adr/XXXX-your-decision.md
```

Replace `XXXX` with the next sequential number (zero-padded to 4 digits).

## Format

Each ADR follows this structure:

```markdown
# {Number}. {Title}

Date: YYYY-MM-DD
Status: {Proposed|Accepted|Rejected|Deprecated|Superseded}

## Context
What is the issue we're facing?

## Decision
What decision have we made?

## Consequences
What are the results of this decision (positive, negative, and neutral)?
```

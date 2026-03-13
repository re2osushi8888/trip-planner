---
name: adr
description: This command should be used when the user asks to "create an ADR", "convert to ADR", "document this decision", "make an architecture decision record", "save this as ADR", or wants to capture architectural decisions from the current conversation.
disable-model-invocation: true
---

# Architecture Decision Record (ADR) Creation

Create an Architecture Decision Record from the current conversation.

## Process

Follow these steps to create an ADR interactively:

### 1. Identify the Decision

Review the recent conversation to identify:
- The architectural question or problem
- The proposed solution or choice
- Any alternatives that were discussed

If unclear, ask the user to clarify what decision should be documented.

### 2. Gather Information

Collect the following through conversation:

**Decision Title:**
- Keep it concise (5-10 words)
- Use present tense ("Use PostgreSQL for primary database")
- Avoid implementation details

**Context:**
- What problem or need motivated this decision?
- What constraints or requirements exist?
- What is the current situation?

**Decision:**
- What specific choice was made?
- Why this option over alternatives?
- What alternatives were considered?

**Consequences:**
- Positive outcomes (benefits, improvements)
- Negative outcomes (trade-offs, limitations)
- Neutral outcomes (other impacts)

Use AskUserQuestion tool to gather missing information.

### 3. Determine ADR Number

1. Read the ADR index at `docs/adr/README.md`
2. Identify the highest existing ADR number
3. Increment by 1 for the new ADR

### 4. Create the ADR Document

Generate the ADR using this structure:

```markdown
# {number}. {Title}

Date: {current-date}
Status: {Proposed|Accepted}

## Context

{Describe the issue, background, driving forces, and constraints}

## Decision

{Describe the chosen solution and why it was selected over alternatives}

**Alternatives considered:**
- **Option 1**: Why rejected
- **Option 2**: Why rejected

## Consequences

**Positive:**
- {Benefit 1}
- {Benefit 2}

**Negative:**
- {Trade-off 1}
- {Drawback 1}

**Neutral:**
- {Other impact 1}
```

**Guidelines:**
- Use clear, professional language
- Write in present tense
- Be specific and concrete
- Avoid ambiguity
- Include enough detail for future readers

### 5. Create the File

Write the ADR to:
- Filename: `docs/adr/{number}-{kebab-case-title}.md`
- Number: Zero-padded to 4 digits (e.g., 0001, 0042, 0123)
- Title: Lowercase with hyphens replacing spaces

Example: `docs/adr/0003-use-react-for-frontend.md`

### 6. Update the Index

Update `docs/adr/README.md` to include the new ADR in the index table:

```markdown
| [{number}]({filename}) | {Title} | {Status} | {Date} |
```

Insert in numerical order.

### 6.5. Validate ADR Invariants

Before finalizing, verify the following invariants are maintained:

**Sequential Numbering:**
- Confirm the new ADR number is exactly `highest_existing_number + 1`
- Check for no gaps or duplicates in the sequence

**File Naming Convention:**
- Verify filename follows: `docs/adr/XXXX-kebab-case-title.md`
- Number is zero-padded to 4 digits
- Title uses lowercase with hyphens (no spaces, underscores, or special characters)

**Required Sections:**
- ADR contains all mandatory sections: Context, Decision, Consequences
- Date is in YYYY-MM-DD format
- Status is one of: Proposed, Accepted, Rejected, Deprecated, Superseded

**Index Consistency:**
- New ADR entry is present in `docs/adr/README.md`
- Entry is in correct numerical order
- All fields (number, title, status, date) are accurate

**Cross-References (if superseding):**
- If this ADR supersedes another, both ADRs reference each other
- Old ADR status is updated to "Superseded"
- New ADR mentions which ADR it supersedes

### 7. Confirm with User

Present a summary:
- ADR number and title
- File location
- Key points from each section
- Offer to make adjustments if needed

## Status Guidelines

**Proposed:** Under active discussion, not yet approved
**Accepted:** Decision approved, ready for implementation
**Rejected:** Considered but not adopted
**Deprecated:** Previously accepted but no longer applicable
**Superseded:** Replaced by a newer ADR

## Best Practices

- One decision per ADR
- Be honest about trade-offs
- Provide context for future readers
- Link to related ADRs
- Don't include implementation details (those belong in code/docs)

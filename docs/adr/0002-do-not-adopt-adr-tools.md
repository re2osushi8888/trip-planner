# 0002. Do Not Adopt adr-tools for ADR Management

Date: 2026-03-13
Status: Accepted

## Context

The project currently uses a manual approach for managing Architecture Decision Records (ADRs) through a `/adr` Claude skill. This skill uses AI-native tools (Write, Edit, Read) to create and maintain ADR files.

We evaluated whether to adopt [adr-tools](https://github.com/npryce/adr-tools), a bash-based CLI tool that provides commands like `adr init`, `adr new`, and `adr new -s` (supersede) for ADR management.

Key considerations:

- **AI usability** is a primary concern since ADRs are created through AI assistance
- Need to maintain invariants: sequential numbering, index consistency, file naming conventions, and cross-references
- Balance between automation and transparency

Investigation revealed that adr-tools, while providing automation benefits, has critical limitations for AI-assisted workflows:

- Requires interactive text editor (VISUAL/EDITOR environment variable)
- Operates as a black box from AI's perspective
- Platform-specific (Unix shell scripts)
- Adds external dependency

## Decision

We will **not adopt adr-tools** and will continue with the manual ADR management approach using AI-native tools.

To maintain ADR invariants without external tooling, we will enhance the `/adr` skill with explicit validation steps:

1. Read `docs/adr/README.md` to determine the next sequential number
2. Verify file naming follows `XXXX-kebab-case-title.md` convention
3. Confirm all required sections are present (Context, Decision, Consequences)
4. Update the index in `README.md` after creating the ADR
5. For superseding ADRs, manually create bidirectional references

**Alternatives considered:**

- **adr-tools**: Rejected because it requires interactive editor integration (incompatible with AI), reduces transparency, and introduces platform-specific dependencies

- **Automated validation script**: Considered but not adopted. User preference is to keep validation embedded in the skill rather than creating separate tooling, favoring simplicity over additional automation

## Consequences

**Positive:**

- AI-friendly: uses transparent, native tools (Write/Edit/Read) that AI can directly control
- No external dependencies or installation required
- Cross-platform compatibility
- Full visibility into the ADR creation process
- Flexible and easily customizable for project-specific needs
- Seamlessly integrates with existing `/adr` skill

**Negative:**

- Requires AI to follow validation steps consistently
- Manual tracking of sequential numbers (though trivial for AI to automate via README parsing)
- Manual cross-referencing when superseding ADRs
- Relies on skill discipline rather than enforced automation

**Neutral:**

- Trade-off accepted: prioritizing transparency and AI-usability over automated tooling
- Validation is embedded in the skill workflow rather than external scripts
- This decision can be revisited if AI tooling evolves to support interactive CLI tools

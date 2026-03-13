# 0007. Adopt oxlint and oxfmt for Linting and Formatting

Date: 2026-03-13
Status: Accepted

## Context

The trip-planner project requires consistent code quality enforcement and formatting across the codebase. As a TypeScript/JavaScript monorepo, several challenges emerge with traditional linting and formatting tools:

- **Performance at scale**: ESLint and Prettier can be slow on large codebases, especially in monorepos with multiple packages
- **Developer experience**: Slow linting/formatting in pre-commit hooks interrupts workflow and reduces productivity
- **CI/CD bottlenecks**: Long-running lint and format checks increase CI pipeline duration
- **Tool fragmentation**: Using separate tools for linting (ESLint) and formatting (Prettier) adds complexity
- **Future compatibility**: Need to support ESLint custom plugins for specialized linting rules

The project needed a fast, modern solution that maintains compatibility with the ESLint ecosystem while providing superior performance.

## Decision

We will adopt **oxlint** for linting and **oxfmt** (part of OXC project) for code formatting.

**Implementation:**
- Use `oxlint` (v1.54.0+) for linting TypeScript and JavaScript files
- Use `oxc format` (v1.0.1+) for code formatting
- Configure via npm scripts in package.json:
  ```json
  {
    "lint": "oxlint .",
    "format": "oxc format --write .",
    "format:check": "oxc format ."
  }
  ```
- Integrate with lefthook for pre-commit validation (ADR 0006)
- Configuration files: `oxlintrc.json` and `oxc.config.js` (when customization needed)

**Key advantages:**

1. **ESLint plugin compatibility**: oxlint is designed to support ESLint custom plugins in the future, enabling migration of existing ESLint configurations and use of community plugins

2. **Superior performance**: Written in Rust, oxlint is significantly faster than Biome and orders of magnitude faster than ESLint
   - Benchmark advantage over Biome in large codebases
   - Near-instant feedback in development and pre-commit hooks
   - Reduces CI/CD pipeline duration

3. **Future potential**: While the tool is not fully mature yet, we accept this trade-off with expectations for rapid improvement:
   - Active development by the Oxide Compiler team
   - Growing adoption in the JavaScript/TypeScript ecosystem
   - Continuous performance and feature improvements

**Alternatives considered:**

- **ESLint + Prettier**: Rejected due to performance concerns. ESLint is notoriously slow on large codebases, and using two separate tools adds complexity and overhead. While mature and widely adopted, the speed impact becomes unacceptable as the project grows.

- **Biome**: Rejected despite being a fast, all-in-one tool (lint + format). While Biome is faster than ESLint + Prettier, benchmarks show oxlint is faster than Biome in many scenarios. More importantly, Biome uses its own rule system and does not support ESLint plugins, limiting future extensibility.

- **Deno lint + deno fmt**: Rejected because it's tightly coupled to the Deno runtime ecosystem. While fast, it lacks ESLint plugin compatibility and would require significant adaptation for Node.js-based projects.

- **Rome (archived)**: Not considered as the project has been sunset and forked into Biome.

- **SWC + custom tooling**: Rejected due to the need to build and maintain custom linting infrastructure. oxlint provides a ready-made solution with better ergonomics.

## Consequences

**Positive:**
- **Dramatic performance improvement**: Linting and formatting complete in milliseconds instead of seconds, enabling near-instant feedback
- **Better developer experience**: Fast pre-commit hooks reduce friction and encourage frequent commits
- **CI/CD efficiency**: Shorter pipeline execution times reduce cloud costs and accelerate deployment cycles
- **Unified toolchain**: oxlint and oxfmt are part of the same OXC project, ensuring consistent behavior and maintenance
- **Future ESLint compatibility**: Planned support for ESLint plugins enables gradual migration and use of custom rules without giving up speed benefits
- **Rust-based reliability**: Memory-safe implementation reduces tool crashes and unexpected behavior
- **Active development**: Regular updates and improvements from the OXC team

**Negative:**
- **Tool immaturity**: oxlint/oxfmt are not yet fully mature compared to ESLint/Prettier
  - Some ESLint rules may not be implemented yet
  - ESLint plugin support is not yet available (planned for future releases)
  - Edge cases and bugs may be discovered as adoption grows
  - Documentation and community resources are still developing
- **Migration risk**: If the OXC project stalls or changes direction, migration back to ESLint/Prettier would be required
- **Limited configuration options**: Fewer customization options compared to mature tools (though this also simplifies setup)
- **Smaller ecosystem**: Fewer community plugins, integrations, and third-party tools compared to ESLint
- **Learning curve**: Team members familiar with ESLint configuration need to learn oxlint conventions

**Neutral:**
- **Maturity trade-off accepted**: We consciously accept the immaturity risk with expectations for rapid improvement based on:
  - Strong technical foundation (Rust-based architecture)
  - Active development and community momentum
  - Clear roadmap for ESLint plugin compatibility
  - Significant performance benefits justify early adoption
- **Gradual migration path**: Can run oxlint alongside ESLint during transition period if needed
- **Configuration simplicity**: Less configuration needed initially, but may require more customization as project grows
- **Community adoption**: As a newer tool, ecosystem maturity will develop over time

**Mitigation strategies for immaturity concerns:**
- Monitor oxlint release notes and changelogs for new features and breaking changes
- Maintain awareness of ESLint plugin support progress
- Document any missing rules or workarounds needed
- Be prepared to contribute bug reports and feature requests to the OXC project
- Keep ESLint/Prettier as fallback option if critical issues arise

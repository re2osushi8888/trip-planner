# 0016. Adopt Vitest for Unit and Integration Testing

Date: 2026-03-18
Status: Accepted

## Context

The project requires a testing framework for unit and integration tests. Following the adoption of Vite+ as our unified toolchain (ADR-0012), we need to formalize our testing strategy.

Vitest is bundled with Vite+ and provides native integration with the development environment. Additionally, test execution performance is a priority for maintaining fast feedback loops during development.

Key considerations:

- Vite+ already includes Vitest as part of its unified toolchain
- Need for fast test execution to support rapid development cycles
- Desire for consistent tooling across the development workflow
- Minimal configuration overhead

## Decision

We will use Vitest as the primary testing framework for unit and integration tests.

Vitest will be accessed through the Vite+ wrapper command `vp test` rather than being installed as a direct dependency. This aligns with the Vite+ philosophy of unified tooling and ensures version consistency across the team.

**Alternatives considered:**

Given the adoption of Vite+ (ADR-0012), no alternatives were formally evaluated. The decision to use Vitest naturally follows from the Vite+ adoption, as Vitest is:

- Pre-bundled with Vite+
- Designed to work seamlessly with Vite's build system
- Already available without additional installation

## Consequences

**Positive:**

- **Fast execution**: Vitest leverages Vite's transformation pipeline, providing significantly faster test execution than traditional frameworks
- **Zero configuration**: No separate test configuration needed; inherits Vite's configuration
- **Native ESM support**: First-class support for ES modules without transformation overhead
- **Consistent tooling**: Uses the same resolver, transforms, and plugins as the development environment
- **Modern API**: Compatible with Jest-like API while offering improved TypeScript support
- **Built-in features**: Includes coverage, mocking, and snapshot testing out of the box
- **Unified versioning**: Vitest version managed through Vite+ upgrades, ensuring consistency

**Negative:**

- **Vite+ coupling**: Testing infrastructure is tightly coupled to Vite+ lifecycle and versioning
- **Ecosystem maturity**: Vitest is newer than Jest, so some third-party integrations may be less mature
- **Migration constraint**: Moving away from Vitest would require moving away from Vite+ or decoupling the test framework

**Neutral:**

- **Learning curve**: Developers familiar with Jest will find Vitest familiar, but there are subtle API differences
- **Documentation**: Must refer to both Vite+ documentation and Vitest documentation for advanced features
- **Command invocation**: Tests are run via `vp test` instead of direct `vitest` commands

## Related ADRs

- [ADR-0012: Adopt Vite+ for Unified Toolchain](0012-adopt-vite-plus-for-unified-toolchain.md) - Parent decision that makes Vitest available

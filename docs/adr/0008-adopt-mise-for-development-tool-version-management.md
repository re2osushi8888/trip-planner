# 0008. Adopt mise for Development Tool Version Management

Date: 2026-03-13
Status: Accepted

## Context

The trip-planner project requires consistent development tool versions across all team members' environments to ensure reproducibility and avoid "works on my machine" issues. Several critical tools need version management:

- **Node.js runtime**: JavaScript/TypeScript execution environment
- **pnpm package manager**: Dependency management for the monorepo
- **Future tools**: Potential additions like Python, Go, or other language runtimes

Without a version management solution, several problems arise:

- **Environment inconsistencies**: Developers using different Node.js versions encounter subtle bugs or incompatibilities
- **Onboarding friction**: New team members must manually install and configure correct tool versions
- **CI/CD alignment**: Local development environments may differ from CI pipelines, causing unexpected failures
- **Version drift**: No enforcement mechanism to prevent accidental upgrades or downgrades
- **Manual maintenance**: Developers must remember to check and update tool versions manually

The project needed a lightweight, developer-friendly solution to standardize development tool versions across all environments.

## Decision

We will adopt **mise** (formerly rtx) for development tool version management.

**Implementation:**

- Configuration stored in `.mise.toml` at repository root
- Explicit version specification for all runtime tools:
  ```toml
  [tools]
  node = "25.8.1"
  pnpm = "10.32.1"
  ```
- Automatic activation via mise shell integration (developers run `mise install` once)
- Version policy enforced via `/version-check` skill and CLAUDE.md guidelines
- CI/CD environments use the same `.mise.toml` for consistency

**Version specification policy:**

- ✅ Always use exact semantic versions (e.g., `25.8.1`, not `25` or `latest`)
- ❌ Never use range specifiers or `latest` keyword
- Rationale: Ensures absolute reproducibility and makes version upgrades explicit in git history

**Why mise over Nix:**

While **Nix** was seriously considered for its superior reproducibility and declarative environment management, we chose mise for its **simplicity and accessibility**:

- **Lower learning curve**: mise has a gentle learning curve similar to nvm/asdf, while Nix requires understanding its unique language and ecosystem
- **Faster onboarding**: New developers can install mise and run `mise install` without learning Nix expressions
- **Pragmatic trade-off**: mise provides "good enough" reproducibility for most development scenarios without Nix's complexity
- **Incremental adoption**: mise can be added to existing projects without major restructuring
- **Familiar workflow**: Developers familiar with nvm, rbenv, or pyenv can adopt mise immediately

**Alternatives considered:**

- **Nix/NixOS**: Rejected despite superior reproducibility and declarative configuration. While Nix provides the gold standard for environment reproducibility, its steep learning curve and complexity outweigh the benefits for this project. Nix requires:
  - Learning Nix expression language
  - Understanding flakes, derivations, and the Nix store
  - Significant time investment for setup and maintenance
  - More complex onboarding for new team members

  We acknowledge Nix's technical superiority but prioritize **developer accessibility and ease of use** for this project.

- **asdf**: Rejected because mise is a faster, Rust-based alternative with better performance and simpler configuration. While asdf has a larger plugin ecosystem, mise supports the essential tools we need (Node.js, pnpm) with superior speed.

- **nvm + separate tools (e.g., corepack)**: Rejected because managing multiple version managers (nvm for Node, corepack for pnpm, etc.) adds complexity. mise provides a unified interface for all tools.

- **Docker development containers**: Rejected as the primary solution because containers add overhead for local development, complicate IDE integration, and are slower for rapid iteration. Docker remains useful for CI/CD and production deployment.

- **Manual installation with documentation**: Rejected because it relies on human discipline and provides no enforcement mechanism. Documentation drifts and developers forget to check versions.

- **volta**: Rejected because it only supports Node.js ecosystem tools. mise supports multiple language runtimes (Python, Ruby, Go, etc.) if needed in the future.

## Consequences

**Positive:**

- **Guaranteed version consistency**: `.mise.toml` ensures all developers and CI/CD use identical tool versions
- **Simple onboarding**: New developers run `mise install` once and have the correct environment automatically
- **Version control**: Tool versions are tracked in git, making changes explicit and auditable
- **Fast performance**: Rust-based implementation provides near-instant version switching
- **Automatic activation**: Shell integration (`.mise.toml` detection) removes manual `mise use` commands
- **Multi-language support**: Can easily add Python, Ruby, Go, or other runtimes as project needs evolve
- **Lower learning curve**: Developers familiar with nvm/asdf can adopt mise immediately without extensive training
- **Minimal configuration**: Simple TOML format is easy to read and maintain
- **CI/CD alignment**: Same `.mise.toml` used in local development and CI pipelines eliminates environment drift

**Negative:**

- **mise installation required**: Developers must install mise itself before starting (one-time setup)
- **Less reproducibility than Nix**: mise manages tool versions but not system dependencies (libraries, compilers, etc.)
  - Acceptable trade-off for this project's needs
  - System dependencies (if needed) can be documented separately
- **Smaller ecosystem than asdf**: Fewer plugins available, though all critical tools (Node, pnpm) are supported
- **Not as comprehensive as Nix**: Cannot guarantee bit-for-bit reproducibility across all environments
  - For JavaScript/TypeScript projects, runtime version consistency is usually sufficient
  - If full environment reproducibility becomes critical, migration to Nix remains possible
- **Manual version updates**: Developers must manually update `.mise.toml` when upgrading tools (though this is intentional for explicit version control)

**Neutral:**

- **Nix trade-off accepted**: We consciously choose simplicity over maximum reproducibility
  - mise provides sufficient reproducibility for typical JavaScript/TypeScript development
  - If future requirements demand Nix-level guarantees (e.g., embedded systems, cryptographic verification), we can migrate
  - For now, developer accessibility takes priority over theoretical purity
- **Shell integration required**: Developers need to configure shell integration (`mise activate`) for automatic version switching
- **Learning investment**: Team members unfamiliar with version managers need brief introduction (though much simpler than Nix)
- **Version policy discipline**: Team must follow exact version specification policy (enforced via `/version-check` and CLAUDE.md)

**Future considerations:**

- Monitor Nix ecosystem developments; reconsider if Nix adoption becomes significantly easier
- Evaluate migration to Nix if reproducibility requirements increase (e.g., compliance, security audits)
- Consider hybrid approach (mise for development, Nix for production deployment) if needed

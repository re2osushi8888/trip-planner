# 0005. Adopt Monorepo Architecture with pnpm Workspaces and Turborepo

Date: 2026-03-13
Status: Accepted

## Context

The trip-planner project is designed to support multiple frontend applications (web, mobile) and backend services (API) that need to share:

- **Code**: Common business logic, TypeScript types, utilities, and configuration
- **Dependencies**: Consistent versions of libraries across all packages
- **Build configuration**: Shared TypeScript, linting, and formatting settings
- **Development workflow**: Coordinated builds, testing, and type checking

Without a unified repository structure, managing these shared concerns becomes challenging:

- **Code duplication**: Shared logic is copied between repositories or published as separate packages
- **Version drift**: Different applications use different versions of shared code, causing bugs
- **Slow iteration**: Changes that span multiple apps require coordinating PRs across repos
- **Complex releases**: Versioning and releasing coordinated changes is error-prone
- **Tooling overhead**: Each repository duplicates configuration, scripts, and CI/CD pipelines
- **Developer experience**: Context switching between repositories slows development

The project needed a repository strategy that enables code sharing while maintaining fast build times as the codebase grows.

## Decision

We will adopt a **monorepo architecture** using **pnpm workspaces** for package management and **Turborepo** for build orchestration.

**Architecture:**
```
trip-planner/
├── apps/
│   ├── api/          # Backend API (Hono)
│   ├── web/          # Web frontend (future)
│   └── mobile/       # Mobile app (future)
├── packages/
│   ├── tsconfig/     # Shared TypeScript configurations
│   ├── types/        # Shared TypeScript types (future)
│   └── utils/        # Shared utility functions (future)
└── turbo.json        # Turborepo pipeline configuration
```

**Implementation:**

1. **pnpm workspaces** (`pnpm-workspace.yaml`):
   - Define workspace packages: `apps/*` and `packages/*`
   - Enable workspace protocol for internal dependencies (`workspace:*`)
   - Single `pnpm-lock.yaml` for entire monorepo
   - Efficient storage via content-addressable package store

2. **Turborepo** (`turbo.json`):
   - Define task pipelines: `build`, `dev`, `lint`, `format`, `type-check`
   - Configure task dependencies: `dependsOn: ["^build"]`
   - Enable local caching for faster rebuilds
   - Support parallel task execution across packages

**Rationale for tooling choices:**

- **pnpm over npm/yarn**: Faster installs, efficient disk usage, strict dependency resolution
- **Turborepo over Nx**: Simpler, less opinionated, easier to adopt incrementally
- **Turborepo over Lerna**: Modern tooling, better caching, active development
- **Monorepo over polyrepo**: Atomic commits, easier refactoring, shared tooling

**Alternatives considered:**

- **Polyrepo (separate repositories)**: Rejected because coordinating changes across repos is slow, version management is complex, and code sharing requires publishing packages

- **Lerna**: Rejected because it's older with less active development, lacks built-in caching, and has slower task execution compared to modern alternatives

- **Nx**: Rejected because it's more opinionated with steeper learning curve, larger footprint, and more complexity than needed for this project's scope

- **pnpm workspaces alone (no build orchestrator)**: Rejected because it lacks smart caching and dependency-aware task execution, leading to unnecessary rebuilds

- **Yarn workspaces + Turborepo**: Rejected in favor of pnpm for better performance, stricter dependency resolution, and more efficient disk usage

## Consequences

**Positive:**
- Code sharing is simple via workspace packages (e.g., `@trip-planner/types`)
- Atomic commits across multiple packages ensure consistency
- Single source of truth for dependencies and tooling configuration
- Turborepo's caching dramatically speeds up repeated builds
- Dependency graph ensures tasks run in correct order
- Parallel execution maximizes build performance
- New packages can be added easily following established patterns
- Refactoring across package boundaries is straightforward
- Developer onboarding is simpler with unified tooling

**Negative:**
- Initial setup complexity compared to single-package repository
- Larger git repository size as project grows
- Need to manage interdependencies carefully to avoid circular references
- CI/CD must understand monorepo structure (changed packages, affected tasks)
- Some tools may not have first-class monorepo support
- Risk of tight coupling between packages if not carefully architected

**Neutral:**
- Team must learn workspace protocol syntax (`workspace:*`)
- Build times scale with project size, though Turborepo caching mitigates this
- Monorepo structure is visible in import paths (e.g., `@trip-planner/utils`)
- Future migration away from monorepo would require significant refactoring

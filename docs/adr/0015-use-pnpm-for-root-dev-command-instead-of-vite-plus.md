# 15. Use pnpm for Root Dev Command Instead of Vite+

Date: 2026-03-18
Status: Accepted

## Context

Vite+ (v0.1.13-alpha) provides a unified task runner through `vp run` that can execute workspace scripts recursively with the `-r` flag. While other root-level commands (build, check, lint, format, type-check) have been successfully migrated to `vp run -r`, the `dev` command presents unique challenges.

The `dev` command differs from other commands in a critical way: it starts long-running processes (development servers) that need to run concurrently and remain active throughout the development session. When we attempted to use `vp run -r dev`:

**Problem observed:**
- Only the first application's dev server starts (apps/api)
- The second application (apps/web) never starts
- Both development servers need to run simultaneously for full-stack development

**Root cause:**
Based on Vite+ documentation and GitHub issues investigation:

1. **Execution Model**: `vp run -r` executes tasks in dependency order, processing each package sequentially. This works well for tasks that complete (build, test, lint), but fails for long-running processes.

2. **Lack of Parallel Execution**: When apps/api's dev server starts and remains running, the task runner doesn't proceed to apps/web. There's no mechanism to fork multiple long-running processes concurrently.

3. **Alpha Status Limitations**: Vite+ (v0.1.13-alpha) is still in alpha with known limitations:
   - GitHub Issue #770: Monorepo root `vp dev` UX is still being designed
   - GitHub Issue #871: Confusion between `vp dev` vs `vp run dev` semantics
   - Official docs show `vp run -r build` examples but lack guidance on concurrent dev servers

4. **Design Intent**: `vp run` appears optimized for batch tasks (build, test, check) rather than orchestrating multiple persistent services.

## Decision

We will use **`pnpm -r --parallel run dev`** for the root dev command instead of `vp run -r dev`.

```json
{
  "scripts": {
    "dev": "pnpm -r --parallel run dev",
    "build": "vp run -r build",
    "check": "vp run -r check",
    "lint": "vp run -r lint",
    "format": "vp run -r format",
    "type-check": "vp run -r type-check"
  }
}
```

**Rationale:**

- **pnpm --parallel**: Explicitly designed for running scripts concurrently across workspaces
- **Proven reliability**: pnpm's parallel execution is stable and well-documented for dev servers
- **Clear separation**: Build tasks use `vp run -r`, dev orchestration uses `pnpm --parallel`

**Alternatives considered:**

- **`vp run -r dev`**: Rejected due to sequential execution model that cannot handle concurrent long-running processes. Not suitable for starting multiple dev servers simultaneously.

- **`vp dev` (no -r flag)**: Rejected because it targets a single project. GitHub Issue #770 shows this is being redesigned for monorepo root UX, but not yet ready.

- **`concurrently` package**: Considered but adds an extra dependency. `pnpm --parallel` provides the same functionality with zero additional dependencies since pnpm is already our package manager.

- **Wait for Vite+ to mature**: Rejected because the limitation is architectural (sequential task execution) rather than a bug. The workaround is simple and aligns with Vite+'s strength in batch tasks.

## Consequences

**Positive:**

- All applications' dev servers start concurrently as expected
- Maintain consistent use of pnpm for package management and parallel execution
- Clear separation of concerns: Vite+ for build tooling, pnpm for dev orchestration
- No additional dependencies needed
- Aligns with pnpm workspace best practices

**Negative:**

- Cannot fully leverage Vite+'s unified command structure for all workflows
- Mixed command patterns: `pnpm dev` vs `pnpm build` (which internally uses `vp run -r build`)
- Need to maintain awareness of which commands use pnpm vs vp

**Neutral:**

- This decision may be revisited when Vite+ matures beyond alpha and adds proper concurrent process management (GitHub Issue #770 resolution)
- Team members need to understand that `dev` command behaves differently from other root commands
- The limitation affects only long-running processes; batch tasks continue to benefit from Vite+ task runner

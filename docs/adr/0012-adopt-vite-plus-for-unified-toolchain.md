# 0012. Adopt Vite+ for Unified Toolchain

Date: 2026-03-18
Status: Accepted (Experimental)

## Context

The trip-planner project currently uses multiple tools for development workflow:

- **Linting and formatting**: oxlint (v1.54.0) and oxc (v1.0.1) - ADR 0007
- **Monorepo management**: Turborepo (v2.8.16) - ADR 0005
- **Package management**: pnpm (v10.32.1) - ADR 0005
- **Development runtime**: tsx watch for API development
- **Build tooling**: tsgo for TypeScript compilation

While each tool performs well individually, managing multiple tools introduces complexity:

- **Fragmented command interface**: Different commands for different tools (turbo, pnpm, oxlint, etc.)
- **Configuration overhead**: Multiple configuration files to maintain
- **Integration challenges**: Ensuring tools work together seamlessly requires manual coordination
- **Tooling evolution**: Keeping up with updates across multiple tools increases maintenance burden
- **Developer onboarding**: New team members must learn multiple tool ecosystems

The JavaScript/TypeScript ecosystem is moving toward unified toolchains that integrate multiple development concerns into a single, cohesive experience.

**Vite+** emerged as a promising solution that unifies:

- Development server and build (Vite + Rolldown)
- Testing (Vitest)
- Linting and formatting (Oxlint + Oxfmt)
- Task running (Vite Task)
- Runtime and package manager management

## Decision

We will **experimentally adopt Vite+** as our unified development toolchain, starting with a trial period to evaluate its suitability for our project.

**Implementation approach:**

1. **Phase 1: Install and evaluate** (Current phase)
   - Install Vite+ globally: `curl -fsSL https://vite.plus | bash`
   - Explore available commands (`vp dev`, `vp check`, `vp test`, `vp run`, etc.)
   - Assess compatibility with existing project structure

2. **Phase 2: Gradual integration** (If Phase 1 is successful)
   - Integrate `vp check` for unified linting + formatting + type checking
   - Evaluate `vp run` as alternative to Turborepo for task orchestration
   - Consider adding frontend applications using `vp create`

3. **Phase 3: Full adoption** (If Phase 2 proves beneficial)
   - Migrate npm scripts to use `vp` commands
   - Remove redundant tool configurations
   - Update documentation and developer workflows

**Rationale for choosing Vite+:**

1. **Unified developer experience**: Single command interface (`vp`) for all development tasks reduces cognitive load and simplifies workflows

2. **Performance**: Built on Rust-based tooling (Oxlint, Rolldown, etc.) provides:
   - 50-100x faster linting compared to ESLint (via Oxlint integration)
   - 10-30x faster builds compared to Webpack (via Rolldown)
   - Near-instant feedback in development

3. **Integrated toolchain**: Vite+ consolidates tools we already use or want to use:
   - Already using oxlint/oxc (ADR 0007) - seamless integration via `vp check`
   - Potential replacement for Turborepo with built-in Vite Task
   - Future-ready for frontend application development

4. **Monorepo support**: Native workspace support with `vp run` provides automatic input tracking and dependency-aware execution

5. **Active development**: Backed by VoidZero (creators of Vite, Rollup, etc.) with strong community momentum and MIT license

**Alternatives considered:**

- **Status quo (multiple tools)**: Continue using oxlint + Turborepo + pnpm separately. Rejected because tooling fragmentation increases over time as project grows, and Vite+ offers compelling integration benefits worth exploring.

- **Nx**: Comprehensive monorepo tool with similar goals. Rejected because it's heavier and more opinionated, whereas Vite+ is lighter-weight and builds on tools we already use (Oxlint, Vite ecosystem).

- **Bun**: Fast all-in-one runtime with built-in package manager, bundler, and test runner. Rejected because it requires full runtime migration and lacks the specialized frontend tooling that Vite+ provides.

## Consequences

**Positive:**

- **Simplified workflow**: Single `vp` command for all development tasks (dev, check, test, build, run) reduces mental overhead
- **Performance benefits**: Rust-based tooling provides dramatically faster linting, formatting, and builds compared to traditional JavaScript tools
- **Better integration**: Tools designed to work together (Vite, Vitest, Oxlint, Rolldown) provide more cohesive experience than mixing disparate tools
- **Future-ready**: Well-positioned for adding frontend applications (`vp create`) when needed
- **Reduced configuration**: Unified configuration approach simplifies project setup and maintenance
- **Ecosystem alignment**: Leverages existing tools we've already adopted (Oxlint/Oxfmt) through seamless integration

**Negative:**

- **Tool immaturity**: Vite+ is in alpha stage (announced 2026-Q1)
  - May contain bugs or incomplete features
  - Breaking changes possible during rapid development
  - Limited production battle-testing
  - Documentation still evolving
- **Experimental risk**: Adopting early-stage tooling may require migration back to separate tools if Vite+ doesn't meet our needs
- **Backend limitations**: Vite+ is primarily designed for Vite-based (frontend) projects:
  - Current `apps/api` (Hono + Node.js) may not benefit from all Vite+ features
  - `vp dev` and `vp build` primarily target frontend applications
  - Backend integration path is unclear
- **Learning curve**: Team needs to learn new `vp` command interface and understand which features apply to our backend-focused project
- **Dependency on single vendor**: Relying on VoidZero's unified toolchain creates vendor lock-in risk if project direction changes
- **Migration effort**: If trial is unsuccessful, reverting to separate tools requires removing Vite+ and restoring previous configurations

**Neutral:**

- **Experimental adoption strategy**: This is explicitly a trial period to evaluate Vite+
  - No immediate commitment to full migration
  - Can continue using existing tools in parallel during evaluation
  - Decision to proceed or roll back will be based on actual experience
- **Selective feature adoption**: Not all Vite+ features need to be used immediately
  - Can start with `vp check` and gradually adopt other commands
  - Backend API can continue using tsx/tsgo while frontend apps use `vp dev/build`
- **Monorepo task running**: `vp run` may or may not replace Turborepo depending on feature parity evaluation
- **Community ecosystem**: As newer tool, community plugins and resources are still developing

**Mitigation strategies:**

- **Parallel tooling**: Keep existing tools (oxlint, Turborepo) functional during trial period as fallback options
- **Phased evaluation**: Test each Vite+ command independently before full adoption
- **Documentation**: Document trial findings, pain points, and benefits for informed decision-making
- **Rollback plan**: Maintain ability to revert to previous tooling if Vite+ proves unsuitable
- **Monitor development**: Track Vite+ releases, changelogs, and community feedback during trial period
- **Limit scope**: Focus initial trial on low-risk areas (linting/formatting) before migrating critical workflows

**Success criteria for trial period:**

- `vp check` successfully runs linting, formatting, and type checking across monorepo
- Performance improvements are measurable and significant
- Developer experience is improved or at least equivalent to current workflow
- No major blockers or incompatibilities with existing project structure
- Documentation and error messages are clear enough for team adoption

**Decision to proceed beyond trial will be made based on:**

- Overall developer experience improvement
- Performance benefits in real-world usage
- Stability and maturity of tool during trial period
- Community adoption and long-term viability signals

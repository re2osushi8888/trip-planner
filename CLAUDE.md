# Development Guidelines

## Version Management

### Runtime Tools Version Specification

Runtime tool versions in `.mise.toml` MUST be explicitly specified with exact version numbers.

**Rules for .mise.toml:**

- ❌ Never use `latest`, `*`, or range specifiers (e.g., `^`, `~`)
- ❌ Never use major-only versions (e.g., `25`)
- ✅ Always specify exact full semantic versions (e.g., `25.8.1`)

**Rationale:**

- Ensures reproducible development environments across all machines
- Prevents "works on my machine" issues
- Makes runtime upgrades explicit and traceable in git history
- Simplifies debugging by eliminating environment-related ambiguity

**Rules for package.json:**

- ✅ Exact versions (e.g., `"hono": "4.12.7"`) are allowed
- ✅ Range specifiers (e.g., `"hono": "^4.12.7"`, `"hono": "~4.12.7"`) are allowed
- ❌ Never use `latest` keyword
- ❌ Never use wildcard `*` alone (except `workspace:*` for monorepo)

**Rationale:**

- Range specifiers allow automatic security patches and minor updates
- Aligns with standard Node.js/pnpm ecosystem practices
- Reduces maintenance burden for dependency updates
- Maintains flexibility while preventing breaking changes

**Examples:**

```toml
# .mise.toml - Good ✅
[tools]
node = "25.8.1"
pnpm = "10.32.1"

# .mise.toml - Bad ❌
[tools]
node = "25"        # Missing patch version
pnpm = "latest"    # Using 'latest' keyword
```

```json
// package.json - Good ✅
{
  "dependencies": {
    "hono": "4.12.7",          // Exact version (fine)
    "@hono/node-server": "^1.15.0"  // Caret range (fine)
  },
  "devDependencies": {
    "typescript": "~5.9.0"     // Tilde range (fine)
  }
}

// package.json - Bad ❌
{
  "dependencies": {
    "hono": "latest",          // 'latest' keyword not allowed
    "@hono/node-server": "*"   // Wildcard alone not allowed
  }
}
```

### Version Updates

**For Runtime Tools (.mise.toml):**

1. Find the latest version with `mise ls-remote <tool>`
2. Update to the specific exact version number
3. Run `mise install` to apply changes
4. Test thoroughly in development
5. Commit runtime updates separately from feature changes

**For Package Dependencies (package.json):**

1. Find the latest version with `pnpm view <package> version`
2. Update version number (preserving or changing range specifier as needed)
3. Run `pnpm install` to apply changes
4. Test thoroughly with `pnpm run type-check` and `pnpm run lint`
5. Document any breaking changes or migration steps
6. Commit dependency updates separately from feature changes

## Skills Usage

### Skill Invocation Transparency

When using the Skill tool, ALWAYS clearly indicate which skill is being invoked.

**Rules:**

- ✅ Always mention the skill name before or after invoking it (e.g., "Using the `/version-check` skill to validate versions")
- ✅ Explain briefly what the skill will do or why it's being used
- ✅ Display the results or outcomes from the skill execution
- ❌ Never silently invoke a skill without telling the user

**Examples:**

```
Good ✅:
"I'll use the `/version-check` skill to verify that all version specifications follow the project guidelines."
[invokes Skill tool]
[displays results]

Bad ❌:
[invokes Skill tool without explanation]
```

## Git Commit Guidelines

### Commit Message Language

All commit messages MUST be written in English only.

**Rules:**

- ✅ Write commit messages in English (subject, body, footer)
- ✅ Use proper English grammar and spelling
- ✅ Follow the Conventional Commits format (enforced by commitlint)
- ❌ Never use non-English characters (Japanese, Chinese, etc.)
- ❌ Never mix languages in commit messages

**Rationale:**

- Ensures commit history is accessible to international contributors
- Maintains consistency across the project
- Facilitates code review and collaboration
- Enables better integration with automated tools

**Examples:**

```bash
# Good ✅
git commit -m "feat: add user authentication"
git commit -m "fix: resolve database connection timeout"
git commit -m "docs: update installation guide"

# Bad ❌
git commit -m "feat: ユーザー認証を追加"
git commit -m "fix: データベース接続のタイムアウトを解決"
git commit -m "機能追加: add user feature"  # Mixed language
```

**Note:** This rule is technically enforced by commitlint's custom rule, which will reject commits with non-ASCII characters.

### Commit Message Scopes

Scopes provide context about which part of the codebase is affected by a change. Follow the Conventional Commits format: `<type>(<scope>): <subject>`

**Rules:**

- ✅ Use predefined scopes from the approved list below
- ✅ Use kebab-case for multi-word scopes
- ✅ Keep scopes concise (1-2 words)
- ✅ Scope is optional but recommended for clarity
- ❌ Do not create arbitrary scopes without team discussion

**Available Scopes:**

**Application Layers:**

- `api` - API related changes
- `web` - Web frontend changes
- `mobile` - Mobile app changes

**Features:**

- `auth` - Authentication and authorization
- `trip` - Trip planning features
- `booking` - Booking and reservation features
- `search` - Search functionality
- `user` - User management
- `notification` - Notification system
- `payment` - Payment processing

**Technical & Tools:**

- `deps` - Dependencies updates
- `config` - Configuration files
- `ci` - CI/CD pipeline
- `docker` - Docker related changes
- `test` - Testing infrastructure
- `scripts` - Build and utility scripts
- `lint` - Linting and formatting

**Documentation:**

- `docs` - Documentation
- `readme` - README file
- `claude` - Claude Code configuration

**Database & Infrastructure:**

- `db` - Database changes
- `cache` - Caching system
- `queue` - Queue system

**Monorepo Packages:**

- `shared` - Shared/common code
- `utils` - Utility functions

**Examples:**

```bash
# Application layers
feat(api): add trip search endpoint
fix(web): correct responsive layout

# Features
feat(auth): implement OAuth2 login
fix(booking): resolve duplicate reservation issue

# Technical
chore(deps): update commitlint to 20.4.4
ci(github-actions): add deployment workflow

# Documentation
docs(readme): update installation guide
docs(claude): add scope guidelines

# Multiple scopes (if change affects multiple areas)
feat(api,auth): add authenticated endpoints
```

**Note:** Scopes are enforced by commitlint. Use `pnpm commit` for interactive scope selection.

<!--VITE PLUS START-->

# Using Vite+, the Unified Toolchain for the Web

This project is using Vite+, a unified toolchain built on top of Vite, Rolldown, Vitest, tsdown, Oxlint, Oxfmt, and Vite Task. Vite+ wraps runtime management, package management, and frontend tooling in a single global CLI called `vp`. Vite+ is distinct from Vite, but it invokes Vite through `vp dev` and `vp build`.

## Vite+ Workflow

`vp` is a global binary that handles the full development lifecycle. Run `vp help` to print a list of commands and `vp <command> --help` for information about a specific command.

### Start

- create - Create a new project from a template
- migrate - Migrate an existing project to Vite+
- config - Configure hooks and agent integration
- staged - Run linters on staged files
- install (`i`) - Install dependencies
- env - Manage Node.js versions

### Develop

- dev - Run the development server
- check - Run format, lint, and TypeScript type checks
- lint - Lint code
- fmt - Format code
- test - Run tests

### Execute

- run - Run monorepo tasks
- exec - Execute a command from local `node_modules/.bin`
- dlx - Execute a package binary without installing it as a dependency
- cache - Manage the task cache

### Build

- build - Build for production
- pack - Build libraries
- preview - Preview production build

### Manage Dependencies

Vite+ automatically detects and wraps the underlying package manager such as pnpm, npm, or Yarn through the `packageManager` field in `package.json` or package manager-specific lockfiles.

- add - Add packages to dependencies
- remove (`rm`, `un`, `uninstall`) - Remove packages from dependencies
- update (`up`) - Update packages to latest versions
- dedupe - Deduplicate dependencies
- outdated - Check for outdated packages
- list (`ls`) - List installed packages
- why (`explain`) - Show why a package is installed
- info (`view`, `show`) - View package information from the registry
- link (`ln`) / unlink - Manage local package links
- pm - Forward a command to the package manager

### Maintain

- upgrade - Update `vp` itself to the latest version

These commands map to their corresponding tools. For example, `vp dev --port 3000` runs Vite's dev server and works the same as Vite. `vp test` runs JavaScript tests through the bundled Vitest. The version of all tools can be checked using `vp --version`. This is useful when researching documentation, features, and bugs.

## Common Pitfalls

- **Using the package manager directly:** Do not use pnpm, npm, or Yarn directly. Vite+ can handle all package manager operations.
- **Always use Vite commands to run tools:** Don't attempt to run `vp vitest` or `vp oxlint`. They do not exist. Use `vp test` and `vp lint` instead.
- **Running scripts:** Vite+ commands take precedence over `package.json` scripts. If there is a `test` script defined in `scripts` that conflicts with the built-in `vp test` command, run it using `vp run test`.
- **Do not install Vitest, Oxlint, Oxfmt, or tsdown directly:** Vite+ wraps these tools. They must not be installed directly. You cannot upgrade these tools by installing their latest versions. Always use Vite+ commands.
- **Use Vite+ wrappers for one-off binaries:** Use `vp dlx` instead of package-manager-specific `dlx`/`npx` commands.
- **Import JavaScript modules from `vite-plus`:** Instead of importing from `vite` or `vitest`, all modules should be imported from the project's `vite-plus` dependency. For example, `import { defineConfig } from 'vite-plus';` or `import { expect, test, vi } from 'vite-plus/test';`. You must not install `vitest` to import test utilities.
- **Type-Aware Linting:** There is no need to install `oxlint-tsgolint`, `vp lint --type-aware` works out of the box.

## Review Checklist for Agents

- [ ] Run `vp install` after pulling remote changes and before getting started.
- [ ] Run `vp check` and `vp test` to validate changes.
<!--VITE PLUS END-->

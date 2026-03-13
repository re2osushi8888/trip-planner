# 0004. Adopt ls-lint for File Naming Conventions

Date: 2026-03-13
Status: Accepted

## Context

Consistent file naming conventions are critical for maintainability and team collaboration. Without enforcement, projects often develop inconsistent naming patterns:

- **Mixed conventions**: camelCase, PascalCase, snake_case, and kebab-case coexist
- **Navigation difficulty**: Inconsistent names make files harder to locate and predict
- **Import confusion**: Different naming styles create cognitive overhead when importing modules
- **Merge conflicts**: Case-insensitive filesystems (macOS, Windows) can cause subtle bugs
- **Onboarding friction**: New contributors struggle to understand which convention to use

In a monorepo with multiple packages and teams, these issues compound. The project needed automated enforcement of file naming standards that:
- Runs fast enough for pre-commit hooks
- Supports multiple file types
- Allows for necessary exceptions (package.json, README.md, etc.)
- Provides clear error messages when violations occur

## Decision

We will adopt **ls-lint** to enforce kebab-case naming conventions across the codebase.

**Implementation:**
- Use `@ls-lint/ls-lint` v2.3.1
- Enforce kebab-case for all file types and directories:
  - `.ts`, `.js` - TypeScript and JavaScript files
  - `.json`, `.yaml`, `.yml` - Configuration files
  - `.md` - Documentation files
  - `.dir` - All directories
- Integrate with lefthook pre-commit hook for automatic validation
- Define comprehensive ignore patterns for files that must follow different conventions:
  - Build artifacts: `**/node_modules`, `**/dist`, `**/.turbo`
  - Standard config files: `package.json`, `tsconfig.json`, `pnpm-lock.yaml`
  - Root documentation: `**/README.md`, `CLAUDE.md`
  - Tool configurations: `.gitignore`, `commitlint.config.js`, etc.

**Rationale for kebab-case:**
- Most URL-friendly (no encoding needed)
- Commonly used in web development and modern JavaScript projects
- Clear word separation without uppercase complexity
- Compatible with all filesystems (case-insensitive and case-sensitive)
- Matches common CLI tool naming conventions

**Alternatives considered:**

- **Manual code review**: Rejected because it's not scalable, catches issues late, and is inconsistent across reviewers

- **ESLint filename rules**: Rejected because ESLint only validates import paths, not actual filesystem names, and would miss files not imported anywhere

- **Custom shell scripts**: Rejected due to maintenance burden, lack of configurability, and poor error messages compared to dedicated tools

- **No enforcement**: Rejected because inconsistent naming accumulates technical debt and increases cognitive load for all contributors

- **Other naming conventions** (camelCase, PascalCase, snake_case): Rejected in favor of kebab-case for URL-friendliness and web development alignment

## Consequences

**Positive:**
- Consistent file naming across the entire codebase
- Automated enforcement prevents new violations at commit time
- Predictable file locations improve navigation and discoverability
- Better autocomplete and fuzzy search in IDEs
- Eliminates debates about naming during code review
- Fast execution (<1 second) suitable for pre-commit hooks
- Clear, actionable error messages when violations occur
- Case-sensitivity issues are avoided (important for cross-platform development)

**Negative:**
- Existing files with non-kebab-case names must be renamed (one-time migration cost)
- Contributors need to learn and remember kebab-case convention
- Some standard files (README.md, package.json) require exceptions
- Ignore list needs maintenance as new tools/conventions are added
- Pre-commit hook can block commits if files violate naming rules

**Neutral:**
- Kebab-case is subjective; teams could choose other conventions
- The ignore list documents which files are exceptions to the rule
- File renames may briefly disrupt git history, but `git log --follow` mitigates this

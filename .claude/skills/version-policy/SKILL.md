---
name: version-policy
description: Project version management guidelines and conventions for dependencies and runtime
user-invocable: false
---

# Version Management Policy

This project enforces strict version specification for all dependencies and runtime tools.

## Core Principle

**Runtime tool versions MUST be explicitly specified with exact version numbers.**
**Package dependencies MAY use range specifiers for flexibility.**

## Rules

### Runtime Tools (.mise.toml)

#### ❌ Prohibited
- `latest` keyword
- Wildcard `*`
- Caret range `^` (e.g., `^1.2.3`)
- Tilde range `~` (e.g., `~1.2.3`)
- Major-only versions (e.g., `node = "25"`)
- Any other range specifiers

#### ✅ Required
- Exact versions with full semantic versioning (e.g., `25.8.1`)
- Pin all runtime tool versions in `.mise.toml`

### Package Dependencies (package.json)

#### ✅ Allowed
- Exact versions (e.g., `"hono": "4.12.7"`)
- Caret range `^` (e.g., `"hono": "^4.12.7"`)
- Tilde range `~` (e.g., `"hono": "~4.12.7"`)
- Other semantic version ranges as needed

#### ❌ Prohibited
- `latest` keyword (use specific version or range)
- Wildcard `*` alone (except `workspace:*`)

#### Exception
- `workspace:*` is allowed for monorepo internal dependencies

## Rationale

### Runtime Tools (strict versioning)
1. **Reproducible Environments**: Same runtime versions across all developers
2. **No Environment Drift**: Prevents "works on my machine" issues
3. **Explicit Runtime Upgrades**: Runtime changes are intentional and visible in git
4. **Easier Debugging**: Eliminates runtime version-related ambiguity

### Package Dependencies (flexible versioning)
1. **Automatic Security Fixes**: Range specifiers allow patch updates
2. **Dependency Flexibility**: Compatible with semver ecosystem practices
3. **Reduced Maintenance**: Don't need to manually update patch versions
4. **Standard Practice**: Aligns with common Node.js/pnpm conventions

## Examples

### .mise.toml

**Good ✅**
```toml
[tools]
node = "25.8.1"
pnpm = "10.32.1"
```

**Bad ❌**
```toml
[tools]
node = "25"
pnpm = "latest"
```

### package.json

**Good ✅**
```json
{
  "dependencies": {
    "hono": "4.12.7",           // Exact version (fine)
    "@hono/node-server": "^1.19.11"  // Caret range (fine)
  },
  "devDependencies": {
    "typescript": "~5.9.0",     // Tilde range (fine)
    "@trip-planner/tsconfig": "workspace:*"  // Workspace (fine)
  }
}
```

**Bad ❌**
```json
{
  "dependencies": {
    "hono": "*",               // Wildcard alone not allowed
    "@hono/node-server": "latest"   // 'latest' keyword not allowed
  }
}
```

## Version Update Process

When updating versions:

1. **Find the latest version** - Use `mise ls-remote` or `pnpm view`
2. **Update to specific version** - Never use `latest` or ranges
3. **Test thoroughly** - Run tests, type-check, and lint
4. **Document breaking changes** - Note any migration steps needed
5. **Commit separately** - Version updates separate from features

## When You See Version Violations

### For .mise.toml
If you encounter runtime tools with incomplete versions or `latest`:
1. Flag them immediately
2. Suggest running `/version-check` to find all violations
3. Offer to fix them by replacing with exact full versions
4. After fixing, verify with `mise install`

### For package.json
Only flag if you see:
- `latest` keyword
- Wildcard `*` alone (except `workspace:*`)
- Other clearly problematic patterns

Range specifiers (`^`, `~`) are allowed and do not need fixing.

## Integration with Workflows

- Before adding dependencies: Specify exact version
- Before updating dependencies: Use `/version-update`
- In code review: Check for version specification violations
- In CI/CD: Version specifications should be reproducible

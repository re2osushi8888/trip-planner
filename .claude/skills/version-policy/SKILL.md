---
name: version-policy
description: Project version management guidelines and conventions for dependencies and runtime
user-invocable: false
---

# Version Management Policy

This project enforces strict version specification for all dependencies and runtime tools.

## Core Principle

**All versions MUST be explicitly specified with exact version numbers.**

## Rules

### ❌ Prohibited
- `latest` keyword
- Wildcard `*`
- Caret range `^` (e.g., `^1.2.3`)
- Tilde range `~` (e.g., `~1.2.3`)
- Major-only versions (e.g., `node = "25"`)
- Any other range specifiers

### ✅ Required
- Exact versions with full semantic versioning (e.g., `1.2.3`)
- Pin runtime versions in `.mise.toml` (e.g., `node = "25.8.1"`)
- Pin package dependencies in `package.json` (e.g., `"hono": "4.12.7"`)

### Exception
- `workspace:*` is allowed for monorepo internal dependencies

## Rationale

1. **Reproducible Builds**: Same code produces same output everywhere
2. **No Surprise Updates**: Prevents unexpected breaking changes
3. **Explicit Upgrades**: Version changes are intentional and traceable in git
4. **Easier Debugging**: Eliminates version-related ambiguity

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
    "hono": "4.12.7",
    "@hono/node-server": "1.19.11"
  },
  "devDependencies": {
    "typescript": "5.9.3",
    "@trip-planner/tsconfig": "workspace:*"
  }
}
```

**Bad ❌**
```json
{
  "dependencies": {
    "hono": "^4.12.7",
    "@hono/node-server": "~1.19.0"
  },
  "devDependencies": {
    "typescript": "latest"
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

If you encounter files with range specifiers or `latest`:
1. Flag them immediately
2. Suggest running `/version-check` to find all violations
3. Offer to fix them by replacing with exact versions
4. After fixing, verify with tests

## Integration with Workflows

- Before adding dependencies: Specify exact version
- Before updating dependencies: Use `/version-update`
- In code review: Check for version specification violations
- In CI/CD: Version specifications should be reproducible

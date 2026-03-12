---
name: version-update
description: Update dependency or runtime versions following project versioning guidelines
disable-model-invocation: true
argument-hint: "[package-name or 'runtime']"
allowed-tools: Read, Edit, Bash, Grep
---

# Version Update Workflow

Update versions following the project's strict versioning policy.

## Arguments

- `runtime` - Update Node.js and pnpm to latest versions
- `<package-name>` - Update specific package to latest version
- No arguments - Guide user through what to update

## Workflow

### For Runtime Updates (mise)

1. **Check current versions**
   ```bash
   mise ls | grep -E "(node|pnpm)"
   ```

2. **Find latest versions**
   ```bash
   mise ls-remote node | tail -5
   mise ls-remote pnpm | tail -5
   ```

3. **Ask user**: "Update to node X.Y.Z and pnpm A.B.C?"

4. **Update .mise.toml**
   - Edit with exact versions (no ranges)
   - Format: `node = "X.Y.Z"`, `pnpm = "A.B.C"`

5. **Install new versions**
   ```bash
   mise install
   ```

6. **Verify installation**
   ```bash
   mise ls | grep -E "(node|pnpm)"
   ```

### For Package Updates

1. **Check current version**
   - Read package.json
   - Show current version and range specifier if present

2. **Find latest version**
   ```bash
   pnpm view <package-name> version
   ```

3. **Ask user**: "Update <package-name> from X.Y.Z to A.B.C?"
   - Ask if they want to keep existing range specifier (^, ~) or use exact version
   - Recommend keeping range specifier for automatic patch updates

4. **Update package.json**
   - Update version number preserving or modifying range specifier as requested
   - Update in all affected package.json files if monorepo

5. **Install and test**
   ```bash
   pnpm install
   pnpm run type-check
   pnpm run lint
   ```

## Important Rules

### Runtime Tools (.mise.toml)
- ✅ Always use exact versions (e.g., `25.8.1`)
- ❌ Never use `latest`, `^`, `~`, `*`, or major-only versions

### Package Dependencies (package.json)
- ✅ Exact versions (e.g., `1.2.3`) or range specifiers (e.g., `^1.2.3`, `~1.2.3`)
- ❌ Never use `latest` or wildcard `*` alone
- ✅ Recommend using `^` for most dependencies (allows patch and minor updates)

### General
- ✅ Test after updating
- ✅ Document breaking changes if any
- ✅ Commit version updates separately from feature changes

## Commit Message Format

For runtime tools:
```
chore(config): update node from X.Y.Z to A.B.C

[Optional: describe any breaking changes or migration steps needed]

Co-Authored-By: Claude Sonnet 4.5 (1M context) <noreply@anthropic.com>
```

For packages:
```
chore(deps): update <package-name> from ^X.Y.Z to ^A.B.C

[Optional: describe any breaking changes or migration steps needed]

Co-Authored-By: Claude Sonnet 4.5 (1M context) <noreply@anthropic.com>
```

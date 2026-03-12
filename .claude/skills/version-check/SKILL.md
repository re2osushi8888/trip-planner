---
name: version-check
description: Check for version specification violations in package.json and mise.toml files
allowed-tools: Read, Grep, Glob, Bash
---

# Version Specification Checker

This skill validates that all version specifications follow the project's strict versioning policy.

## What to Check

### 1. Check .mise.toml
- Read `.mise.toml`
- Verify all tool versions use full semantic versions (e.g., `25.8.1`)
- Flag any versions using major-only format (e.g., `25`) or `latest`

### 2. Check package.json Files
- Find all `package.json` files in the project
- Check `dependencies`, `devDependencies`, and `peerDependencies`
- Flag any version with range specifiers: `^`, `~`, `*`, `latest`, `x`
- Exceptions: `workspace:*` is allowed for monorepo internal dependencies

## Violations to Report

Report findings in this format:

```
❌ Version Specification Violations Found:

File: .mise.toml
- Line X: node = "25" (should be full version like "25.8.1")

File: package.json
- Line Y: "hono": "^4.12.7" (remove ^ to use exact version "4.12.7")
- Line Z: "typescript": "latest" (specify exact version)

File: apps/api/package.json
- Line N: "react": "~18.0.0" (remove ~ to use exact version "18.0.0")
```

If no violations found:
```
✅ All version specifications follow project guidelines
```

## After Reporting

If violations are found, ask the user if they want you to fix them automatically.

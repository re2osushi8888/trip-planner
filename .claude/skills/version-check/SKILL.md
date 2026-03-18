---
name: version-check
description: Check for version specification violations in package.json and mise.toml files
allowed-tools: Read, Grep, Glob, Bash
---

# Version Specification Checker

This skill validates that all version specifications follow the project's strict versioning policy.

## What to Check

### 1. Check .mise.toml (Strict)

- Read `.mise.toml`
- Verify all tool versions use full semantic versions (e.g., `25.8.1`)
- Flag any versions using major-only format (e.g., `25`) or `latest`

### 2. Check package.json Files (Lenient)

- Find all `package.json` files in the project
- Check `dependencies`, `devDependencies`, and `peerDependencies`
- Only flag problematic patterns:
  - `latest` keyword
  - Wildcard `*` alone (except `workspace:*` which is allowed)
- **Do NOT flag**: `^`, `~`, or other semver range specifiers (these are allowed)

## Violations to Report

Report findings in this format:

```
❌ Version Specification Violations Found:

File: .mise.toml
- Line X: node = "25" (should be full version like "25.8.1")
- Line Y: pnpm = "latest" (specify exact version like "10.32.1")

File: package.json
- Line Z: "typescript": "latest" (use specific version or range like "^5.9.0")
- Line W: "react": "*" (use specific version or range like "^18.0.0")
```

If no violations found:

```
✅ All version specifications follow project guidelines
```

**Note**: Range specifiers like `^` and `~` in package.json are NOT violations.

## After Reporting

If violations are found, ask the user if they want you to fix them automatically.

# Development Guidelines

## Version Management

### Explicit Version Specification
All dependencies, tools, and runtime versions MUST be explicitly specified with exact version numbers.

**Rules:**
- ❌ Never use `latest`, `*`, or range specifiers (e.g., `^`, `~`) for production dependencies
- ✅ Always specify exact versions (e.g., `1.2.3`)
- ✅ Pin runtime versions in `.mise.toml` with full semantic versions
- ✅ Pin package dependencies in `package.json` with exact versions

**Rationale:**
- Ensures reproducible builds across all environments
- Prevents unexpected breaking changes from automatic updates
- Makes version upgrades explicit and traceable in git history
- Simplifies debugging by eliminating version-related ambiguity

**Examples:**

```toml
# .mise.toml - Good ✅
[tools]
node = "25.8.1"
pnpm = "10.32.1"

# .mise.toml - Bad ❌
[tools]
node = "25"
pnpm = "latest"
```

```json
// package.json - Good ✅
{
  "dependencies": {
    "hono": "4.12.7"
  }
}

// package.json - Bad ❌
{
  "dependencies": {
    "hono": "^4.12.7"
  }
}
```

### Version Updates
When updating versions:
1. Update to the specific latest version number
2. Test thoroughly in development
3. Document any breaking changes or migration steps
4. Commit version updates separately from feature changes

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

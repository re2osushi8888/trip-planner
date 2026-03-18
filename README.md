# trip-planner

A trip planning application built with TypeScript and Hono.

## Quick Start

### Automated Setup

Run the setup script to install all required tools and dependencies:

```bash
./setup.sh
```

This will install:

- **mise** - Development tool version manager
- **Node.js & pnpm** - Runtime and package manager (versions from `.mise.toml`)
- **Vite+** - Unified toolchain for linting, formatting, testing, and building
- **Aikido Safe Chain** - Supply chain protection against malicious packages
- **Project dependencies** - All npm packages
- **Git hooks** - Pre-commit hooks with lefthook

After setup completes, restart your terminal and verify:

```bash
npm safe-chain-verify  # Should output "OK: Safe-chain works!"
```

### Manual Setup

If you prefer to install components manually:

1. **Install mise:**

   ```bash
   curl https://mise.run | sh
   ```

2. **Install development tools:**

   ```bash
   mise install
   ```

3. **Install Vite+ (unified toolchain):**

   ```bash
   curl -fsSL https://vite.plus | bash
   ```

   Then restart your terminal or run `source ~/.zshrc` (or `~/.bashrc`)

4. **Install Aikido Safe Chain:**

   ```bash
   npm install -g @aikidosec/safe-chain
   safe-chain setup
   ```

5. **Install dependencies:**

   ```bash
   pnpm install
   ```

6. **Setup Git hooks:**
   ```bash
   pnpm exec lefthook install
   ```

## Development

### Using Vite+ Commands (Recommended)

Vite+ provides a unified CLI (`vp`) for common development tasks:

```bash
# Unified check (format + lint + type-check)
vp check

# Run linter only
vp lint

# Format code
vp fmt

# Run tasks across monorepo
vp run build
vp run dev
vp run type-check
```

### Using pnpm Scripts

```bash
# Start development server
pnpm dev

# Build for production
pnpm build

# Unified check (format + lint + type-check)
pnpm check

# Run linter
pnpm lint

# Format code
pnpm format

# Type check
pnpm type-check

# Commit (interactive with commitlint)
pnpm commit
```

## Project Structure

This is a monorepo managed with pnpm workspaces and Turborepo:

- `apps/` - Application packages
- `packages/` - Shared packages
- `docs/` - Documentation including ADRs

## Documentation

- [Architecture Decision Records](docs/adr/README.md) - Important architectural decisions

# 0009. Adopt Aikido Safe Chain for Supply Chain Protection

Date: 2026-03-13
Status: Accepted

## Context

The npm ecosystem faces ongoing supply chain attacks, most notably the **Shai Hulud** campaign, which has compromised thousands of packages and repositories. This sophisticated attack:

- **Exploits GitHub Actions vulnerabilities**: Attackers leverage `pull_request_target` triggers to execute malicious code during CI runs
- **Steals credentials**: Malicious scripts extract environment variables containing CI tokens, cloud credentials, and package manager tokens
- **Self-propagates**: Compromised packages inject malware into lifecycle hooks (install, postinstall, prepare, prepublish)
- **Evolves continuously**: Multiple variants (1.0, 2.0, 3.0) have been detected, each more sophisticated than the last

According to security research:

- **26,000+ GitHub repositories** created using stolen developer credentials
- **187+ npm packages** compromised during known Shai Hulud attacks
- Attacks targeting major projects like AsyncAPI, PostHog, and Postman

Traditional dependency scanning tools are insufficient because:

- They scan after installation, when malicious code may have already executed
- They rely on known vulnerability databases, missing zero-day attacks
- They don't protect against compromised dependencies deep in the dependency tree
- They can't prevent malware execution during npm install lifecycle hooks

The project needs real-time protection that blocks malicious packages **before** they reach the local machine or CI/CD environment.

## Decision

We will adopt **Aikido Safe Chain** as a protective layer for all package manager operations.

**Implementation:**

- Install `@aikidosec/safe-chain` globally on all development machines
- Configure shell integration to intercept npm, pnpm, yarn, and npx commands
- Set up CI/CD integration for GitHub Actions workflows
- No changes required to existing package.json or workflows

**How it works:**

1. Runs a lightweight local proxy server
2. Intercepts all package downloads from npm registry
3. Verifies packages in real-time against Aikido Intel threat database
4. Blocks download if malware is detected in any package (including deep dependencies)
5. Allows safe packages to install normally

**Key features:**

- **Zero configuration**: Works transparently with existing workflows
- **Real-time protection**: Checks packages before installation
- **Deep dependency scanning**: Analyzes entire dependency tree
- **Free and open source**: No tokens or accounts required
- **Multi-package-manager support**: Works with npm, pnpm, yarn, bun, pip, poetry, etc.

**Installation steps:**

```bash
# 1. Install globally
npm install -g @aikidosec/safe-chain

# 2. Setup shell integration
safe-chain setup

# 3. Restart terminal and verify
npm safe-chain-verify
```

**CI/CD setup:**

```bash
# In GitHub Actions workflows
npm i -g @aikidosec/safe-chain
safe-chain setup-ci
```

**Alternatives considered:**

- **Socket.dev**: Rejected because it requires account setup, integrates primarily through GitHub app, and adds friction to the development workflow

- **Snyk/Dependabot**: Rejected because they scan after installation and rely on known vulnerability databases, missing zero-day attacks like Shai Hulud

- **Manual package auditing**: Rejected because it's not scalable for projects with hundreds of dependencies and doesn't protect against sophisticated supply chain attacks

- **npm audit**: Rejected because it only checks known vulnerabilities in the npm advisory database and runs after package installation

- **Firewall/network blocking**: Rejected because it would block all npm traffic and break the development workflow completely

## Consequences

**Positive:**

- Real-time protection against supply chain attacks before code execution
- Detects malicious packages in the entire dependency tree, not just direct dependencies
- Zero friction for developers - works transparently with existing commands
- Protects both local development environments and CI/CD pipelines
- Free and open source with no vendor lock-in
- Regularly updated threat intelligence from Aikido Security research
- Blocks threats that traditional scanners miss (zero-day, polymorphic malware)
- No performance impact on development workflow (proxy is lightweight)

**Negative:**

- Requires global installation on all developer machines (onboarding step)
- Depends on Aikido's threat intelligence service availability
- May produce false positives that block legitimate packages (can be bypassed with `--unsafe`)
- Adds an external dependency to the development toolchain
- Requires shell restart after installation for aliases to take effect
- Limited offline functionality (proxy needs internet to verify packages)

**Neutral:**

- Developers must run `safe-chain setup` on new machines or environments
- Team needs to understand how to bypass blocks if legitimate packages are flagged
- CI/CD workflows require an additional installation step (minimal overhead)
- Proxy server runs locally in the background (minimal resource usage)
- Works alongside existing security tools (Dependabot, npm audit) as an additional layer

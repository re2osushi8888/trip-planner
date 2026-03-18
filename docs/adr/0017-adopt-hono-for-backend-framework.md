# 0017. Adopt Hono for Backend Framework

Date: 2026-03-18
Status: Accepted

## Context

The project requires a backend framework for building the API server. The framework must support:

- High performance with minimal overhead for efficient request handling
- Edge runtime compatibility for deployment flexibility (Cloudflare Workers, Deno Deploy, etc.)
- First-class TypeScript support with strong type safety
- Simple, modern API that is easy to learn and maintain

Key considerations:

- The backend needs to be lightweight and fast to handle API requests efficiently
- Potential deployment to edge platforms requires framework compatibility
- Strong TypeScript integration is essential for type safety across the stack
- Developer experience and simplicity are priorities for rapid development

## Decision

We will use Hono as the backend framework for the API server.

Hono is a small, fast web framework designed for edge runtimes, with excellent TypeScript support and a clean, intuitive API. It runs on multiple platforms (Node.js, Cloudflare Workers, Deno, Bun) and provides built-in middleware and utilities.

Key features:

- Ultra-fast routing with minimal overhead
- Built-in TypeScript support with type-safe routing and middleware
- Multi-runtime support (Node.js, edge, serverless)
- Middleware ecosystem for common tasks (CORS, JWT, logging, etc.)
- Small bundle size (~12KB)
- Express-like API for familiarity

**Alternatives considered:**

- **Express.js**: Industry standard with large ecosystem, but lacks native TypeScript support, heavier runtime overhead, and not optimized for modern platforms. Express's callback-based design feels dated compared to modern frameworks.

- **Fastify**: Excellent performance and plugin architecture, but more complex than needed for this project. While faster than Express, Fastify is primarily Node.js-focused and lacks edge runtime support.

- **NestJS**: Full-featured framework with dependency injection and architectural patterns, but significantly heavier and more opinionated. NestJS's enterprise features (decorators, modules, DI) add complexity that isn't required for this API. Not suitable for edge deployments.

## Consequences

**Positive:**

- **Excellent performance**: Hono's minimal overhead provides fast request handling and low latency
- **Edge-ready**: Can deploy to Cloudflare Workers, Deno Deploy, or traditional Node.js without code changes
- **Type safety**: Full TypeScript support with type inference for routes, middleware, and context
- **Simple API**: Clean, intuitive API reduces learning curve and development time
- **Modern design**: Built for modern JavaScript runtimes and deployment patterns
- **Lightweight**: Small bundle size reduces deployment footprint
- **Active development**: Growing ecosystem with regular updates and community support

**Negative:**

- **Smaller ecosystem**: Fewer third-party plugins compared to Express, though core middleware covers common needs
- **Less mature**: Newer framework with less battle-testing in production at scale
- **Community size**: Smaller community means fewer Stack Overflow answers and tutorials
- **Migration risk**: Moving away from Hono in the future would require rewriting route handlers

**Neutral:**

- **Multi-runtime support**: While beneficial, adds complexity to testing across different runtimes if full compatibility is needed
- **Learning curve**: Developers familiar with Express will need to learn Hono's patterns, though the API is similar
- **Documentation**: Documentation is good but less comprehensive than established frameworks

## Related ADRs

- [ADR-0016: Adopt Vitest for Unit and Integration Testing](0016-adopt-vitest-for-testing.md) - Vitest will be used to test Hono API endpoints

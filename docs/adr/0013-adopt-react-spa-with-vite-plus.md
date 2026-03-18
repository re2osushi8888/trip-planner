# 0013. Adopt React SPA with Vite+

Date: 2026-03-18
Status: Accepted

## Context

The trip-planner project requires a frontend application to provide user interface for trip planning features. Currently, the project only has a backend API (`apps/api`) built with Hono and Node.js.

Key requirements for the frontend:

- **Interactive user experience**: Trip planning requires dynamic, interactive UI (map visualization, itinerary building, real-time updates)
- **Development velocity**: Need fast iteration cycles and hot module replacement (HMR) for rapid development
- **Modern tooling**: Leverage latest frontend technologies and best practices
- **Team familiarity**: Team has experience with React ecosystem
- **Consistent toolchain**: Align with existing project tooling decisions (ADR 0012: Vite+)

Architectural considerations:

- **SPA vs SSR/SSG**: Need to choose between Single Page Application (SPA), Server-Side Rendering (SSR), or Static Site Generation (SSG)
- **Framework selection**: React, Vue, Svelte, or others
- **Build tooling**: Must integrate with monorepo structure and existing development workflow
- **Type safety**: TypeScript support is mandatory for consistency with backend

## Decision

We will adopt **React SPA (Single Page Application)** built with **Vite+** as our frontend technology stack.

**Technology Stack:**

- **Framework**: React 19+ with TypeScript
- **Build Tool**: Vite+ (vp CLI) - ADR 0012
- **Architecture**: Single Page Application (SPA)
- **Routing**: React Router v7+
- **State Management**: TBD (React Context, Zustand, or Redux based on complexity)
- **Styling**: TBD (Tailwind CSS, CSS Modules, or styled-components)

**Project Structure:**

```
apps/
├── api/              # Existing Hono backend
└── web/              # New React SPA frontend
    ├── src/
    │   ├── pages/    # Page components
    │   ├── components/ # Reusable components
    │   ├── hooks/    # Custom hooks
    │   ├── utils/    # Utility functions
    │   └── main.tsx  # Entry point
    ├── public/       # Static assets
    └── vite.config.ts # Vite+ configuration
```

**Rationale:**

1. **React**: Industry-standard, mature ecosystem
   - Large community and extensive library ecosystem
   - Team familiarity reduces onboarding time
   - Excellent TypeScript support
   - Strong integration with Vite and modern tooling

2. **SPA Architecture**: Best fit for our use case
   - Interactive trip planning requires rich client-side interactions
   - Better UX for dynamic content (map visualization, drag-and-drop itineraries)
   - Simpler deployment model (static files + API)
   - Lower infrastructure complexity compared to SSR

3. **Vite+**: Aligns with ADR 0012
   - Already adopted for backend tooling
   - Unified developer experience across monorepo
   - Lightning-fast HMR (hot module replacement)
   - Built-in TypeScript, JSX, and CSS support
   - Optimized production builds with Rolldown

**Alternatives Considered:**

- **Next.js (React SSR/SSG)**: Rejected for current phase
  - Overkill for SPA use case
  - SEO benefits not critical for authenticated trip planning app
  - Added complexity with server components and API routes
  - May reconsider if public marketing pages are needed

- **Vue 3 + Vite**: Rejected due to team familiarity
  - Excellent framework but team lacks Vue experience
  - React ecosystem familiarity accelerates development
  - Both have similar capabilities for our use case

- **Svelte + Vite**: Rejected due to ecosystem maturity
  - Smaller ecosystem compared to React
  - Less community support and third-party libraries
  - Team unfamiliar with Svelte's compilation model

- **Astro (SSG)**: Rejected for current needs
  - Optimized for content-heavy sites, not interactive apps
  - Our app is primarily dynamic, not static content
  - May consider for marketing/documentation site in future

- **Remix (React SSR)**: Rejected for complexity
  - Full-stack framework adds unnecessary complexity
  - Already have separate backend API (Hono)
  - SPA model is simpler for our current needs

## Consequences

**Positive:**

- **Unified tooling**: Vite+ (`vp`) commands work for both backend and frontend development
- **Fast development**: Vite's instant HMR provides excellent developer experience
- **Type safety**: TypeScript across full stack (API + frontend) ensures type safety and better refactoring
- **Rich ecosystem**: Access to vast React ecosystem (libraries, components, tools)
- **Simple deployment**: Frontend compiles to static assets, can be served from CDN
- **Developer productivity**: Team's React familiarity enables rapid feature development
- **Consistent patterns**: Same language (TypeScript) and similar patterns across backend and frontend

**Negative:**

- **SEO limitations**: SPA has poor SEO without additional tooling
  - Mitigated by: App is primarily for authenticated users, not public content
  - Can add prerendering or SSG later if needed
- **Initial load time**: SPA bundles can be larger than SSR first-page loads
  - Mitigated by: Code splitting, lazy loading, and Vite's optimized builds
- **JavaScript requirement**: App requires JavaScript enabled
  - Acceptable trade-off: Modern web app users expect JavaScript
- **State complexity**: Client-side state management can become complex
  - Mitigated by: Start simple with React Context, upgrade to Zustand/Redux only if needed
- **Framework lock-in**: React-specific code not easily portable
  - Accepted risk: React's stability and ecosystem make migration unlikely

**Neutral:**

- **SSR migration path**: Can migrate to Next.js or Remix later if SSR becomes necessary
  - React components are largely reusable
  - Routing and state management would need refactoring
- **Monorepo complexity**: Frontend and backend in separate apps
  - Already established pattern with Turborepo (ADR 0005)
  - Vite+ provides unified task running across apps
- **API design**: Backend API must be designed for SPA consumption
  - RESTful or GraphQL API with proper CORS configuration
  - Authentication/authorization handled via tokens (JWT, sessions)

**Implementation Notes:**

- Create `apps/web` using `vp create` command
- Configure Vite+ for React with TypeScript
- Setup API proxy in development for CORS handling
- Configure build output for production deployment
- Integrate with Turborepo task pipeline
- Add E2E testing with Playwright (Story #58)

**Future Considerations:**

- If SEO becomes critical: Evaluate Next.js migration or prerendering solutions
- If server-side logic grows: Consider Remix or Next.js with API routes
- For marketing pages: Consider Astro or Next.js SSG for static content
- State management: Start with Context, evaluate Zustand or Redux as complexity grows
- Styling solution: Evaluate Tailwind CSS vs CSS Modules in separate ADR

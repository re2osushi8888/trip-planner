# 0019. Standardize Local Development Ports

Date: 2026-03-20
Status: Accepted

## Context

During local development, the default ports used by various tools and frameworks frequently conflict with each other and with other projects running on the same development machine. Common conflicts include:

- Port 3000: Next.js, Express, and many Node.js tutorials
- Port 5173: Vite default dev server
- Port 8000: Python Django, Go applications
- Port 8080: Common HTTP alternative, Tomcat, many Java applications

These conflicts force developers to:

- Manually override ports via command-line flags or environment variables each time
- Stop other running services to free up ports
- Remember which ports are used by which projects

The project needs a standardized port allocation strategy that:

- Avoids conflicts with commonly used development tools
- Is easy to remember and switch between in the browser
- Scales as new applications are added to the project
- Provides a consistent developer experience

## Decision

We will standardize local development ports using the **4000 range starting at 4000**, with the following allocation:

- **Frontend (React/Vite): Port 4000**
- **Backend API (Hono): Port 4001**

**Port Selection Rationale:**

1. **Avoid common conflicts**: The 4000 range avoids the heavily-used 3000, 5000, and 8000 ranges
2. **Easy to type**: Port 4000 is simpler and faster to type than 4100
3. **Sequential allocation**: Frontend and backend use consecutive ports (4000, 4001), making it easy to remember and switch in the browser
4. **Ruby on Rails conflict acceptable**: While Rails defaults to port 4000, this project does not use Rails, so the conflict is not a concern
5. **Future scalability**: Additional services can use sequential ports (4002, 4003, etc.)

**Known conflicts in 4000 range:**

- Port 4000: Ruby on Rails default (acceptable since this project does not use Rails)
- Port 4200: Angular CLI default (well above our current allocation)

**Future expansion:**

- Additional frontend: Port 4002
- WebSocket server: Port 4003
- Admin dashboard: Port 4004
- Mobile API: Port 4005

## Consequences

**Positive:**

- **No port conflicts**: 4000 range is relatively unused, minimizing conflicts with other tools
- **Easy to type**: Port 4000 is simple and quick to type in the browser
- **Sequential and memorable**: Consecutive ports (4000, 4001) are easy to remember and switch between
- **Scalable**: Clear pattern for adding new services (sequential from 4100)
- **Consistent developer experience**: All developers use the same ports
- **Reduces cognitive load**: No need to remember or look up port assignments
- **Works across projects**: Developers can run multiple projects simultaneously without conflicts

**Negative:**

- **Non-standard ports**: Developers accustomed to 3000/5173 may need adjustment
- **Documentation requirement**: Port configuration must be documented and updated as services are added
- **Initial setup**: Existing configurations need to be updated

**Neutral:**

- **Environment variable configuration**: Ports remain configurable via environment variables for flexibility
- **Browser bookmarks**: Developers may need to update existing localhost bookmarks

## Implementation Guidelines

1. **Configuration files:**
   - Set Vite dev server to port 4000 in `vite.config.ts`
   - Set Hono server to port 4001 in application startup code
   - Document port configuration in `.env.example`

2. **Documentation:**
   - Update README.md with port information
   - Document port allocation in development setup guide
   - Maintain port allocation table as new services are added

3. **Environment variables:**
   - `VITE_PORT=4000` for frontend dev server
   - `API_PORT=4001` for backend API server
   - Allow override via local `.env` if needed

4. **Port allocation table:**
   | Service | Port | Status |
   |---------|------|--------|
   | Frontend (React/Vite) | 4000 | Active |
   | Backend API (Hono) | 4001 | Active |
   | (Reserved for future) | 4002+ | Available |

## Related ADRs

- [ADR-0017: Adopt Hono for Backend Framework](0017-adopt-hono-for-backend-framework.md) - Defines the backend framework requiring port configuration

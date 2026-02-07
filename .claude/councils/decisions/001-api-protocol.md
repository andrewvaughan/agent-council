# Architecture Council Decision: API Protocol Selection

**Date:** February 7, 2026
**Decision ID:** 001
**Council:** Architecture Council

## Request

Should we use tRPC or REST for API communication between the Vite React frontend and NestJS backend for Lawnsignal?

**Context:**
- Building a full-stack application with TypeScript throughout
- Vite + React 19 frontend (SPA)
- NestJS backend with Prisma ORM
- Self-hosted deployment on homelab (Docker)
- Team values type safety, developer experience, and shipping speed

## Evaluation

### Principal Engineer
- **Vote:** ☑ Approve (tRPC)
- **Rationale:** tRPC provides end-to-end type safety between frontend and backend, reducing runtime errors and improving developer experience. Since we're using TypeScript in both React and NestJS, tRPC is a natural fit. The type safety eliminates an entire class of bugs and makes refactoring safer.
- **Recommendations:**
  - Ensure tRPC setup is well-documented for team onboarding
  - Consider the learning curve for developers unfamiliar with tRPC
  - Plan for API versioning strategy if needed in future

### Platform Engineer
- **Vote:** ☑ Concern (REST)
- **Rationale:** tRPC adds complexity to deployment and monitoring. REST is more standard, easier to debug with standard HTTP tools, and better supported by infrastructure tools (load balancers, API gateways, monitoring). For self-hosted homelab deployment, simpler is often better.
- **Recommendations:**
  - If choosing tRPC, ensure proper logging and monitoring are configured
  - Document how to debug tRPC calls in production
  - Consider using OpenTelemetry for observability
  - Setup health check endpoints that work with standard HTTP monitoring

### Security Engineer
- **Vote:** ☑ Approve (either - slight preference for tRPC)
- **Rationale:** Both approaches can be secured properly. tRPC's type safety actually reduces some attack surfaces (input validation is enforced by TypeScript compiler). REST requires more manual validation. Both need proper authentication, rate limiting, and CORS configuration.
- **Recommendations:**
  - Whichever we choose, implement rate limiting and authentication middleware
  - Use Zod for runtime validation even with tRPC (TypeScript types are compile-time only)
  - Ensure HTTPS/TLS for all API communication
  - Implement proper CORS policies

### Backend Specialist
- **Vote:** ☑ Approve (tRPC)
- **Rationale:** NestJS has excellent tRPC integration via nestjs-trpc library. Type safety from backend to frontend eliminates an entire class of bugs where API contracts drift. API contracts are automatically enforced by TypeScript compiler. Developer experience is significantly better - autocomplete works across the full stack.
- **Recommendations:**
  - Use Zod for runtime validation in addition to TypeScript types
  - Structure tRPC routers by feature/module (auth, users, etc.)
  - Setup proper error handling with custom error types
  - Consider implementing request/response interceptors for logging

## Decision

- **Status:** ☑ Approved (tRPC) with action items
- **Consensus:** 3 Approve (1 with preference for tRPC, 2 strong approve for tRPC), 1 Concern (REST). No blocks. Platform Engineer's concerns about monitoring and debugging are valid and should be addressed.

### Action Items

1. **Setup comprehensive logging for tRPC requests**
   - Implement request/response logging middleware
   - Add OpenTelemetry instrumentation
   - Document debugging process for production

2. **Document tRPC setup for team**
   - Create onboarding guide in docs/
   - Include examples of common patterns
   - Document error handling strategy

3. **Implement Zod validation**
   - Use Zod schemas for all tRPC procedures
   - Share schemas between frontend and backend
   - Add runtime validation even though TypeScript provides compile-time safety

4. **Configure rate limiting and authentication**
   - Setup rate limiting middleware (express-rate-limit)
   - Implement JWT-based authentication
   - Add proper CORS configuration

5. **Setup health check endpoints**
   - Create standard HTTP health check endpoint
   - Ensure it works with Docker/Kubernetes health probes
   - Document monitoring strategy

## Rationale

tRPC provides significant developer experience and type safety benefits that align with our tech stack (TypeScript throughout). The platform engineer's concerns about monitoring and debugging are valid but can be mitigated with proper logging, documentation, and tooling. The team should invest time upfront to address these concerns.

## Next Steps

1. Setup NestJS with nestjs-trpc integration
2. Create initial tRPC router structure
3. Implement logging and monitoring
4. Document the setup process
5. Begin with a simple endpoint (health check) to validate the approach

## References

- [tRPC Documentation](https://trpc.io/)
- [NestJS tRPC Integration](https://github.com/KevinEdry/nestjs-trpc)
- [tRPC with React](https://trpc.io/docs/client/react)

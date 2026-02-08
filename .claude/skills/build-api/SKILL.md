---
name: build-api
description: Build backend API endpoints, services, and database changes. Use for backend-only work like new API routes, business logic, database schema changes, or microservice patterns. Activates the Architecture Council for significant API decisions.
user-invocable: true
---

# Backend API Development Workflow

Build backend API endpoints, services, and database changes following NestJS patterns, Prisma schema design, and the project's clean architecture conventions.

## Step 1: Define API Requirements

Ask the user (or read from the decision record if `/plan-feature` was run first):
- What resource(s) or endpoint(s) are being created or modified?
- What operations are needed (CRUD, custom actions, queries)?
- Are there database schema changes?
- Is this a tRPC procedure or REST endpoint?
- Are there authentication or authorization requirements?

If a decision record exists in `.claude/councils/decisions/`, read it for the task breakdown.

## Step 2: Design API Contract

Invoke `/backend-development:api-design-principles` for API design guidance.

Design the full API contract:
- **Endpoint paths and HTTP methods** (REST) or **procedure names** (tRPC)
- **Request types**: Full TypeScript interfaces with all fields, optional/required markers
- **Response types**: Success responses, error responses, pagination if applicable
- **Validation rules**: Using Zod schemas for runtime validation
- **Error format**: Standardized error response structure
- **Auth requirements**: Which endpoints need authentication, role-based access

If this represents a **significant API decision** (new resource type, breaking change to existing API, new architectural pattern), activate the Architecture Council using `.claude/councils/architecture-council.md`:

> **Model Selection**: For each council member, read their agent definition from `.claude/agents/<agent-name>.md` and use the model specified in their `## Model` section when spawning Task subagents. Match the context (routine vs. critical) to select the appropriate model when an agent lists multiple options.

### Principal Engineer — consult: full-stack-orchestration
- **Vote**: Approve / Concern / Block
- **Rationale**: Architectural soundness, scalability, maintainability
- **Recommendations**: Patterns to follow, trade-offs to consider

### Platform Engineer — consult: cloud-infrastructure
- **Vote**: Approve / Concern / Block
- **Rationale**: Operational implications, deployment considerations
- **Recommendations**: Infrastructure concerns, monitoring needs

### Security Engineer — consult: security-scanning
- **Vote**: Approve / Concern / Block
- **Rationale**: Security risks, attack surface, compliance
- **Recommendations**: Security hardening steps, input validation

### Backend Specialist — consult: backend-development
- **Vote**: Approve / Concern / Block
- **Rationale**: API design quality, NestJS patterns, developer experience
- **Recommendations**: Implementation approach, ecosystem integration

### CHECKPOINT: Present the API contract (and Architecture Council evaluation if activated) to the user. Wait for approval before implementation begins.

## Step 3: Database Layer (if needed)

If schema changes are required:

1. Invoke `/database-design:postgresql` for PostgreSQL schema design guidance

2. Design the Prisma schema changes:
   - Model definitions with proper field types
   - Relations and foreign keys
   - Indexes for query performance
   - Unique constraints and validations
   - Enums where appropriate

3. Invoke `/database-migrations:sql-migrations` for migration generation guidance

### CHECKPOINT: Present the Prisma schema changes and migration plan to the user. Wait for approval before running the migration.

4. Generate and apply the migration:
   ```bash
   pnpm db:migrate
   ```

5. If seed data is needed, update the seed script.

## Step 4: Implement Backend

Follow NestJS patterns and `/backend-development:architecture-patterns` for clean architecture:

### Types and DTOs
- Define request/response TypeScript interfaces
- Create Zod validation schemas for runtime validation
- Export types for frontend consumption (via tRPC or shared packages)

### Repository / Data Access Layer
- Create or update Prisma queries
- Implement data access patterns (repository pattern if used)
- Add query optimization (select specific fields, use includes wisely)

### Service Layer
- Implement business logic in NestJS services
- Add input validation and business rule enforcement
- Handle error cases with typed exceptions
- Keep services testable (inject dependencies)

### Controller / Router Layer
- Create tRPC procedures or NestJS controllers
- Wire up validation, auth guards, and services
- Implement proper HTTP status codes (REST) or error codes (tRPC)
- Add rate limiting if needed for public endpoints

### Guards and Middleware
- Add authentication guards where required
- Add authorization checks (role-based or resource-based)
- Add request logging for debugging

Use `/javascript-typescript:typescript-advanced-types` for complex type scenarios (generics, conditional types, mapped types).

## Step 5: Write Tests

Following the QA Lead testing strategy:

### Unit Tests
- Test each service method in isolation
- Mock Prisma client and external dependencies
- Test business logic, validation rules, error handling
- Cover happy paths and edge cases

### Integration Tests
- Test endpoints against a real (test) database
- Verify request validation rejects bad input
- Verify authentication and authorization enforcement
- Test error responses for various failure modes

### Validation Tests
- Boundary conditions (empty strings, max lengths, special characters)
- Invalid input formats
- Missing required fields
- Type coercion and casting

Run tests and verify coverage:
```bash
pnpm test
```

Ensure coverage meets the >80% target.

## Step 6: Generate API Documentation

Invoke `/documentation-generation:openapi-spec-generation` to generate or update API documentation for the new endpoints.

If using tRPC, document the procedure signatures and usage examples.
If using REST, generate or update the OpenAPI/Swagger specification.

## Step 7: Self-Review

Before presenting to the user, verify:
```bash
pnpm type-check
pnpm lint
pnpm test
```

Check for common issues:
- No hardcoded secrets or credentials
- Proper error handling (no swallowed errors)
- Input validation on all external-facing endpoints
- Proper use of TypeScript strict mode (no `any` types)

## Step 8: Commit

### CHECKPOINT: Present a summary of all changes — files modified, API contract implemented, test results, and documentation. Wait for user approval.

Commit with conventional commit format:
```
feat(api): add <resource> endpoints
```

Or if modifying existing endpoints:
```
feat(api): update <resource> with <change-description>
```

**Next step**: Run `/review-code` for a comprehensive security and quality review before creating a PR.

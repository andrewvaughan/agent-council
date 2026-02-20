---
name: build-api
description: Build backend API endpoints, services, and database changes. Use for backend-only work like new API routes, business logic, database schema changes, or microservice patterns. Activates the Architecture Council for significant API decisions.
---

# Backend API Development Workflow

Build backend API endpoints, services, and database changes following your project's backend framework conventions and architecture patterns. Read the project's `AGENTS.md` for tech stack details (framework, ORM, API style, test runner, etc.).

> [!CAUTION]
> **Scope boundary**: This skill implements backend code and commits it. It does **NOT** create pull requests, push to remote, run code reviews, or submit anything for merge. When implementation and commits are complete, **stop** and suggest the user run `/review-code` next.

> [!WARNING]
> **Checkpoint protocol.** When this workflow reaches a `### CHECKPOINT`, you **must** actively prompt the user for a decision — do not simply present information and continue. Use your agent's interactive prompting mechanism (e.g., `AskUserQuestion` in Claude Code) to require an explicit response before proceeding. This prevents queued or in-flight messages from being misinterpreted as approval. If your agent lacks interactive prompting, output the checkpoint content and **stop all work** until the user explicitly responds.

> [!WARNING]
> **Tech stack required.** This skill adapts to your project's technology choices. If `AGENTS.md` does not specify a backend framework, ORM, API style, validation library, or test runner, **stop and ask the user** what their project uses. Then update `AGENTS.md` with a `## Tech Stack` section so future skills can reference it automatically. Example:
>
>     ## Tech Stack
>     - Backend: Express with TypeScript
>     - ORM: Prisma with PostgreSQL
>     - API style: REST
>     - Validation: Zod
>     - Test runner: Vitest
>     - Package manager: npm

## Step 1: Define API Requirements

Verify we are on a feature branch (not `main`). If on `main`:

```bash
git checkout main && git pull origin main
git checkout -b feature/<feature-slug>
```

Ask the user (or read from the decision record if `/plan-feature` was run first):

- What resource(s) or endpoint(s) are being created or modified?
- What operations are needed (CRUD, custom actions, queries)?
- Are there database schema changes?
- What API style does the project use (REST, RPC, etc.)?
- Are there authentication or authorization requirements?

If a decision record exists in `docs/decisions/`, read it for the task breakdown.

## Step 2: Design API Contract

Design the full API contract following your project's API conventions:

- **Endpoints or procedures**: Paths, methods, or procedure names per your API style
- **Request types**: Typed interfaces with all fields, optional/required markers
- **Response types**: Success responses, error responses, pagination if applicable
- **Validation rules**: Using your project's validation library for runtime validation
- **Error format**: Standardized error response structure
- **Auth requirements**: Which endpoints need authentication, role-based access

If this represents a **significant API decision** (new resource type, breaking change to existing API, new architectural pattern), activate the Architecture Council using the skill's `councils/architecture-council.md`:

> **Model Selection**: For each council member, read their agent definition from the skill's `agents/<agent-name>.md` and use the model specified in their `## Model` section when spawning Task subagents. Match the context (routine vs. critical) to select the appropriate model when an agent lists multiple options.

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
- **Rationale**: API design quality, framework patterns, developer experience
- **Recommendations**: Implementation approach, ecosystem integration

### CHECKPOINT: Present the API contract (and Architecture Council evaluation if activated) to the user. Wait for approval before implementation begins.

## Step 3: Database Layer (if needed)

If schema changes are required:

1. Design the schema changes using your project's ORM or data access layer:
   - Model definitions with proper field types
   - Relations and foreign keys
   - Indexes for query performance
   - Unique constraints and validations
   - Enums where appropriate

### CHECKPOINT: Present the schema changes and migration plan to the user. Wait for approval before running the migration.

2. Generate and apply the migration using your project's migration tool.

3. If seed data is needed, update the seed script.

## Step 4: Implement Backend

Follow your project's backend framework patterns and conventions:

### Types and DTOs

- Define typed request/response interfaces
- Create validation schemas for runtime validation
- Export types for frontend consumption if applicable

### Repository / Data Access Layer

- Create or update data access queries using your project's ORM
- Implement data access patterns (repository pattern if used)
- Add query optimization (select specific fields, use eager loading wisely)

### Service Layer

- Implement business logic in service classes/modules
- Add input validation and business rule enforcement
- Handle error cases with typed exceptions
- Keep services testable (inject dependencies)

### Controller / Router Layer

- Create API handlers following your project's routing conventions
- Wire up validation, auth guards, and services
- Implement proper status codes and error formats
- Add rate limiting if needed for public endpoints

### Guards and Middleware

- Add authentication guards where required
- Add authorization checks (role-based or resource-based)
- Add request logging for debugging

## Step 5: Write Tests

Following the QA Lead testing strategy:

### Unit Tests

- Test each service method in isolation
- Mock database client and external dependencies
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

Run tests using your project's test runner and verify coverage meets the >80% target.

## Step 6: Generate API Documentation

Generate or update API documentation for the new endpoints. If your project uses an API specification format (OpenAPI, AsyncAPI, etc.), update it to reflect the new endpoints.

## Step 7: Self-Review

Before presenting to the user, run your project's quality checks:

- Type checking (no type errors)
- Linting (no violations)
- Formatting (no style issues)
- Tests (all pass)

If formatting fails, run the auto-formatter on the reported files before proceeding.

Check for common issues:

- No hardcoded secrets or credentials
- Proper error handling (no swallowed errors)
- Input validation on all external-facing endpoints
- Strict typing (no untyped escape hatches)

## Step 8: Update Documentation

If this API change alters how the project is set up, built, or run, update the relevant documentation **before committing**:

1. **AGENTS.md Tech Stack** — If this implementation introduces or changes any technology (new database, new library, new API pattern), update the `## Tech Stack` section in `AGENTS.md` so future skills reference the correct stack
2. **README.md** — Update Quick Start, Installation, Usage, or Project Structure sections if the change introduces new infrastructure, services, environment variables, or commands
3. **Other docs** — Update any relevant documentation files as needed

### CHECKPOINT: If the Tech Stack section in AGENTS.md needs updating, present the proposed changes to the user and wait for approval. The tech stack definition affects all future skill runs.

> [!IMPORTANT]
> A developer cloning the repo fresh must be able to get the project running by following README.md alone. If your API change adds a service, database, new environment variable, or external dependency, the docs MUST reflect it.

## Step 9: Commit

### CHECKPOINT: Present a summary of all changes — files modified, API contract implemented, test results, and documentation. Wait for user approval.

Commit with conventional commit format:

```
feat(api): add <resource> endpoints
```

Or if modifying existing endpoints:

```
feat(api): update <resource> with <change-description>
```

## Step 10: Hand Off — STOP Here

> [!CAUTION]
> **This skill's work is done.** Do NOT proceed to create a pull request, push to remote, or run a code review. Those are separate skills with their own workflows and checkpoints.

Present the next step to the user:

- **Recommended**: Run `/review-code` for multi-perspective security and quality review before submitting
- **If more work remains**: Continue with remaining tasks, then run `/review-code`

If working from a GitHub issue, remind the user:

- The PR should reference the issue with `Closes #<number>` so it auto-closes when merged
- `/submit-pr` will detect related issues from commit messages

**Pipeline**: `/plan-feature` → `/build-feature` or **`/build-api`** → `/review-code` → `/submit-pr`

**Do not push the branch, create a PR, or invoke `/submit-pr` from within this skill.**

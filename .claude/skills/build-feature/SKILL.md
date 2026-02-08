---
name: build-feature
description: Implement a full-stack feature following an approved plan. Builds database layer, backend API, frontend components, and tests. Use after plan-feature has produced an approved implementation plan, or when you have a clear set of tasks to implement across the stack.
user-invocable: true
---

# Full-Stack Feature Implementation Workflow

Execute a full-stack feature implementation across database, backend, frontend, and testing layers. This skill follows the implementation plan produced by `/plan-feature` and builds all layers with integrated testing.

## Step 1: Load Implementation Plan

Check for an existing implementation plan:

1. Read the most recent decision record from `.claude/councils/decisions/` that matches the current feature
2. If no decision record exists, ask the user what to build

From the plan (or user description), identify:
- **Database changes**: Schema modifications, migrations, seed data
- **Backend tasks**: API endpoints, services, business logic
- **Frontend tasks**: Components, routing, state management, styling
- **Testing requirements**: Coverage goals, E2E scenarios, edge cases
- **Feature flag**: Whether to wrap behind a flag

Verify we are on a feature branch (not `main`). If on `main`:
```bash
git checkout main && git pull origin main
git checkout -b feature/<feature-slug>
```

## Step 2: Database Layer

If database changes are required:

1. Invoke `/database-design:postgresql` for schema design guidance

2. Design the Prisma schema changes:
   - Models with proper field types and defaults
   - Relations with referential integrity
   - Indexes for query performance
   - Constraints and validations
   - Enums where appropriate

3. Invoke `/database-migrations:sql-migrations` for migration best practices

### CHECKPOINT: Present the schema changes and migration plan to the user. Wait for approval before running.

4. Generate and apply the migration:
   ```bash
   pnpm db:migrate
   ```

## Step 3: Backend Implementation

Invoke `/backend-development:feature-development` for backend scaffolding guidance.

For each backend task from the plan:

### Types and Validation
- Define TypeScript interfaces for request/response types
- Create Zod schemas for runtime validation
- Export shared types for frontend consumption

### Service Layer
- Implement business logic in NestJS services
- Add proper error handling with typed exceptions
- Validate business rules and enforce invariants
- Keep services testable (dependency injection)

### API Layer
- Create tRPC procedures or NestJS controllers
- Wire up validation, auth guards, and rate limiting
- Return proper status codes and error formats

### Backend Tests
- Unit tests for services (mock dependencies)
- Integration tests for API endpoints
- Test validation, auth, and error handling

Run backend tests:
```bash
pnpm test
```

### CHECKPOINT: Present the API contract (endpoints, request/response types) to the user. Confirm the contract before building the frontend against it.

## Step 4: Frontend Implementation

For each frontend task from the plan:

### Component Creation
Invoke `/ui-design:create-component` for guided component creation with:
- Full TypeScript prop interfaces
- Tailwind CSS + shadcn/ui styling (invoke `/frontend-mobile-development:tailwind-design-system` for patterns)
- Keyboard navigation and ARIA attributes
- Responsive design
- Dark mode support (if applicable)

### State Management
If the feature requires client-side state:
- Invoke `/frontend-mobile-development:react-state-management` for state patterns
- Use React Query / tRPC hooks for server state
- Use local state (useState/useReducer) for UI state
- Use context or Zustand for shared client state

### Routing
If new pages or routes are needed:
- Add route definitions
- Create page components
- Add navigation links

### API Integration
- Wire components to backend via tRPC client or API hooks
- Handle loading states, error states, and empty states
- Add optimistic updates where appropriate

### Feature Flag (if applicable)
If the plan specifies a feature flag:
```typescript
const isEnabled = useFeatureFlag('FEATURE_NAME');
if (!isEnabled) return <ExistingComponent />;
return <NewFeature />;
```

### Frontend Tests
- Component render tests (React Testing Library)
- User interaction tests (click, type, submit)
- Integration tests with mocked API responses

### CHECKPOINT: Present the frontend implementation to the user. Describe what was built, show the component structure and key interactions.

## Step 5: End-to-End Testing

Write E2E test outlines for critical user flows:
- Happy path: User completes the main flow successfully
- Error path: User encounters validation errors, API failures
- Edge cases: Empty states, boundary conditions, concurrent actions

If E2E test infrastructure exists, implement the tests.

Run the full test suite:
```bash
pnpm test
```

Report coverage and any failures.

## Step 6: Self-Review

Before presenting to the user, perform a comprehensive self-review:

```bash
pnpm type-check    # No TypeScript errors
pnpm lint          # No linting violations
pnpm test          # All tests pass
```

Check for:
- No hardcoded secrets or credentials
- Input validation on all user-facing inputs
- Proper error handling (no swallowed errors)
- Accessible components (ARIA, keyboard nav)
- No `any` types in TypeScript
- Proper loading and error states in UI

## Step 7: Commit

### CHECKPOINT: Present a complete summary to the user:
- Files created and modified (organized by layer)
- Database changes (if any)
- API endpoints added (if any)
- Components created (if any)
- Test results and coverage
- Any known limitations or deferred items

Wait for user approval before committing.

Create atomic, conventional commits. If the feature is small enough for one commit:
```
feat(<scope>): implement <feature-name>
```

If the feature is large, break into logical commits:
```
feat(db): add <model> schema and migration
feat(api): add <resource> endpoints
feat(web): add <feature> components and pages
test: add tests for <feature>
```

## Step 8: Next Steps

Suggest the appropriate next step:
- **Code review**: Run `/review-code` for multi-perspective review
- **More implementation**: Continue with remaining tasks, then review
- **Design review**: If UI-heavy, consider running `/ui-design:design-review`

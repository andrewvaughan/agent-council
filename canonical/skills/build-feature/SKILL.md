---
name: build-feature
description: Implement a full-stack feature following an approved plan. Builds database layer, backend API, frontend components, and tests. Use after plan-feature has produced an approved implementation plan, or when you have a clear set of tasks to implement across the stack.
---

# Full-Stack Feature Implementation Workflow

Execute a full-stack feature implementation across database, backend, frontend, and testing layers. This skill follows the implementation plan produced by `/plan-feature` and builds all layers with integrated testing. Read the project's `AGENTS.md` for tech stack details (frameworks, ORM, UI library, test runner, etc.).

> [!CAUTION]
> **Scope boundary**: This skill implements code and commits it. It does **NOT** create pull requests, push to remote, run code reviews, or submit anything for merge. When implementation and commits are complete, **stop** and suggest the user run `/review-code` next. Do not proceed to PR creation — that is `/submit-pr`'s job.

> [!WARNING]
> **Tech stack required.** This skill adapts to your project's technology choices. If `AGENTS.md` does not specify your project's frameworks, ORM, UI library, or test runner, **stop and ask the user** what their project uses. Then update `AGENTS.md` with a `## Tech Stack` section so future skills can reference it automatically. Example:
>
>     ## Tech Stack
>     - Frontend: React with TypeScript
>     - Backend: Express with TypeScript
>     - ORM: Prisma with PostgreSQL
>     - UI: Tailwind CSS + shadcn/ui
>     - State: React Query for server state, Zustand for client state
>     - Test runner: Vitest
>     - E2E: Playwright
>     - Package manager: npm

## Step 1: Load Implementation Plan

Check for an implementation plan using the following priority:

> [!NOTE]
> GitHub issues created by `/plan-feature` are task-oriented work items — the decision record remains the authoritative source of council evaluations, rationale, and architectural context. When loading from an issue, always read the referenced decision record for full context.

### Option A: GitHub Issue (Primary)

If the user provides a GitHub issue number (e.g., `/build-feature 42` or `/build-feature #42`):

1. Fetch the issue details:

   ```bash
   gh issue view <number> --json title,body,labels,state,number
   ```

2. Validate the issue:
   - Confirm it has the `feature-implementation` label (warn if not — it may not be a `/plan-feature` issue)
   - If the issue is closed, warn the user and ask whether to proceed

3. Parse the issue body to extract:
   - **Implementation Plan**: Task checkboxes organized by layer (Frontend, Backend, Database, Testing)
   - **Technical Context**: Architecture decisions, API contracts, schema changes
   - **Decision Record path**: Read the referenced decision record for full council context
   - **Feature Flag**: Flag name if applicable
   - **Success Metrics**: Measurable outcomes

4. Read the referenced decision record from the path specified in the issue for complete council rationale.

5. Signal work is in progress:

   ```bash
   gh issue edit <number> --add-label "in-progress"
   ```

### Option B: Decision Record (Fallback)

If no issue number is given:

1. Read the most recent decision record from `docs/decisions/` that matches the current feature
2. If no decision record exists, fall through to Option C

### Option C: User Description (Last Resort)

If no decision record exists, ask the user what to build.

> [!WARNING]
> No GitHub issue or decision record found. This means the planning pipeline (`/plan-feature`) was skipped — no council evaluation, no documented rationale, no structured task breakdown. Consider running `/plan-feature` first. Proceeding without a plan risks unreviewed architecture decisions.

### Extract Tasks

From the plan (regardless of source), identify:

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

1. Design the schema changes using your project's ORM or data access layer:
   - Models with proper field types and defaults
   - Relations with referential integrity
   - Indexes for query performance
   - Constraints and validations
   - Enums where appropriate

### CHECKPOINT: Present the schema changes and migration plan to the user. Wait for approval before running.

2. Generate and apply the migration using your project's migration tool.

## Step 3: Backend Implementation

For each backend task from the plan, follow your project's backend framework conventions:

### Types and Validation

- Define typed request/response interfaces
- Create validation schemas for runtime validation
- Export shared types for frontend consumption

### Service Layer

- Implement business logic in service classes/modules
- Add proper error handling with typed exceptions
- Validate business rules and enforce invariants
- Keep services testable (dependency injection)

### API Layer

- Create API handlers following your project's routing conventions
- Wire up validation, auth guards, and rate limiting
- Return proper status codes and error formats

### Backend Tests

- Unit tests for services (mock dependencies)
- Integration tests for API endpoints
- Test validation, auth, and error handling

Run backend tests using your project's test runner.

### CHECKPOINT: Present the API contract (endpoints, request/response types) to the user. Confirm the contract before building the frontend against it.

## Step 4: Frontend Implementation

For each frontend task from the plan, follow your project's frontend framework conventions:

### Component Creation

Create components following your project's UI patterns:

- Typed prop interfaces
- Styling per your project's design system
- Keyboard navigation and ARIA attributes
- Responsive design
- Dark mode support (if applicable)

### State Management

If the feature requires client-side state, follow your project's state management patterns:

- Server state (data fetching, caching, revalidation)
- UI state (local component state)
- Shared client state (global stores if needed)

### Routing

If new pages or routes are needed:

- Add route definitions
- Create page components
- Add navigation links

### API Integration

- Wire components to backend via your project's API client
- Handle loading states, error states, and empty states
- Add optimistic updates where appropriate

### Feature Flag (if applicable)

If the plan specifies a feature flag, wrap the new feature behind the flag so it can be toggled without redeployment.

### Frontend Tests

- Component render tests
- User interaction tests (click, type, submit)
- Integration tests with mocked API responses

### CHECKPOINT: Present the frontend implementation to the user. Describe what was built, show the component structure and key interactions.

## Step 5: End-to-End Testing

Write E2E test outlines for critical user flows:

- Happy path: User completes the main flow successfully
- Error path: User encounters validation errors, API failures
- Edge cases: Empty states, boundary conditions, concurrent actions

If E2E test infrastructure exists, implement the tests.

Run the full test suite and report coverage and any failures.

## Step 6: Self-Review

Before presenting to the user, run your project's quality checks:

- Type checking (no type errors)
- Linting (no violations)
- Formatting (no style issues)
- Tests (all pass)

If formatting fails, run the auto-formatter on the reported files before proceeding.

Check for:

- No hardcoded secrets or credentials
- Input validation on all user-facing inputs
- Proper error handling (no swallowed errors)
- Accessible components (ARIA, keyboard nav)
- Strict typing (no untyped escape hatches)
- Proper loading and error states in UI

## Step 7: Update Documentation

If this feature changes how the project is set up, built, or run, update the relevant documentation **before committing**:

1. **AGENTS.md Tech Stack** — If this implementation introduces or changes any technology (new framework, new database, new UI library), update the `## Tech Stack` section in `AGENTS.md` so future skills reference the correct stack
2. **README.md** — Update Quick Start, Installation, Usage, or Project Structure sections if the feature introduces new infrastructure, services, environment variables, or commands
3. **Other docs** — Update any relevant documentation files as needed

### CHECKPOINT: If the Tech Stack section in AGENTS.md needs updating, present the proposed changes to the user and wait for approval. The tech stack definition affects all future skill runs.

> [!IMPORTANT]
> A developer cloning the repo fresh must be able to get the project running by following README.md alone. If your feature adds a service, database, new dev server, or environment variable, the docs MUST reflect it.

## Step 8: Commit

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

### Update GitHub Issue

If implementation was initiated from a GitHub issue, comment on it with progress:

```bash
gh issue comment <number> --body "Implementation committed on branch \`<branch-name>\`. Proceeding to code review via \`/review-code\`."
```

## Step 9: Track Deferred Work

If the implementation plan, council decisions, or self-review identified items that were **explicitly deferred** (not forgotten — intentionally postponed), document them now so they don't get lost.

### Check for Deferred Items

Review the following sources for deferred work:

1. **Implementation plan**: Items marked as "Future Iterations" or "Post-MVP"
2. **Council decisions**: Recommendations tagged as "not for this increment"
3. **Self-review findings**: Items you noticed but chose not to address in this PR
4. **CHECKPOINT notes**: Any "known limitations or deferred items" from Step 8

### Document Deferred Work

For each deferred item, draft a GitHub issue:

```bash
gh issue create \
  --title "<type>: <deferred item description>" \
  --body "<context on why it was deferred, what needs to happen, and any relevant references>" \
  --label "enhancement"
```

If the deferred items are small, a single tracking issue with a checklist is sufficient. If they represent distinct features, create separate issues.

### Link to Current Work

Add a comment on the current feature's GitHub issue (if one exists) noting the deferred work issues:

```bash
gh issue comment <current-issue-number> --body "Deferred work tracked in #<new-issue-1>, #<new-issue-2>."
```

> [!TIP]
> Not every feature generates deferred work. If nothing was explicitly deferred, skip this step entirely. Don't manufacture follow-up issues just to have them.

## Step 10: Hand Off — STOP Here

> [!CAUTION]
> **This skill's work is done.** Do NOT proceed to create a pull request, push to remote, or run a code review. Those are separate skills with their own workflows and checkpoints.

Present the next step to the user:

- **Recommended**: Run `/review-code` for multi-perspective review before submitting
- **If more work remains**: Continue with remaining tasks from the implementation plan, then run `/review-code`

If working from a GitHub issue, remind the user:

- The PR should reference the issue with `Closes #<number>` so it auto-closes when merged
- `/submit-pr` will detect related issues from commit messages

**Do not push the branch, create a PR, or invoke `/submit-pr` from within this skill.**

---
name: plan-feature
description: Plan a new feature from concept to approved implementation plan. Activates Product Council for strategic evaluation, then Feature Council for technical planning. Produces a documented decision and scoped task breakdown. Use when starting any new feature work.
user-invocable: true
---

# Feature Planning Workflow

Take a feature idea from concept to an approved implementation plan with lean scope, council consensus, and a documented decision record. This skill ensures every feature is evaluated from product, design, and technical perspectives before any code is written.

## Step 1: Gather Feature Context

Ask the user to describe:
- **What** the feature does (user-facing behavior)
- **Who** it is for (target users)
- **Why** it matters (business or product value)
- **Constraints** (time, technical, budget, dependencies)

If the user provides a GitHub issue number, fetch the issue details:
```bash
gh issue view <number>
```

If the user provides a brief description, that's sufficient — the councils will flesh out the details.

## Step 2: Activate the Product Council

Read the Product Council template from `.claude/councils/product-council.md` and evaluate the feature from all 6 member perspectives.

> **Model Selection**: For each council member, read their agent definition from `.claude/agents/<agent-name>.md` and use the model specified in their `## Model` section when spawning Task subagents. Match the context (routine vs. critical) to select the appropriate model when an agent lists multiple options.

### Product Strategist (Lead)
- **User Value**: Does this solve a real user problem? Market fit?
- **Priority**: Is this the right thing to build now?
- **Recommendations**: Strategic considerations, positioning

### Lean Delivery Lead
- **Lean Scope**: What is the smallest version we can ship to get feedback?
- **Speed to Feedback**: How quickly can we get this in front of users?
- **Feature Flag Strategy**: Should this be prototyped behind a feature flag?
- **Recommendations**: How to ship faster and learn faster

### Design Lead — consult: ui-design
- **Design Quality**: Brand consistency? UX intuitiveness?
- **Accessibility**: WCAG compliance requirements?
- **Recommendations**: Design approach, component needs

### Business Operations Lead
- **Cost Analysis**: Budget required? Infrastructure costs?
- **ROI Potential**: Expected return on investment?
- **Recommendations**: Cost optimizations or budget concerns

### Principal Engineer — consult: full-stack-orchestration
- **Technical Feasibility**: Can we build this? Complexity level?
- **Architectural Fit**: Does this align with the current tech stack?
- **Recommendations**: Technical constraints or alternative approaches

### Frontend Specialist — consult: frontend-mobile-development
- **Implementation Assessment**: UX feasibility? Component complexity?
- **User Experience**: Implementation challenges?
- **Recommendations**: Frontend implementation approach

Present the full Product Council evaluation with all votes and recommendations.

### CHECKPOINT: Present the Product Council results to the user. Wait for approval of scope and priority before proceeding to technical planning.

## Step 3: Define Lean Scope

Based on Product Council feedback, clearly define:

- **MVP Scope**: What ships in the first increment (1-2 weeks max). List specific user-facing capabilities.
- **Future Iterations**: What comes after MVP validation. List deferred capabilities.
- **Feature Flag Strategy**: Whether this should ship behind a flag, and the flag name.
- **Success Metrics**: How will we know this feature works? Define 2-3 measurable outcomes.

## Step 4: Activate the Feature Council

Read the Feature Council template from `.claude/councils/feature-council.md` and create the technical implementation plan.

> **Model Selection**: For each council member, read their agent definition from `.claude/agents/<agent-name>.md` and use the model specified in their `## Model` section when spawning Task subagents. Match the context (routine vs. critical) to select the appropriate model when an agent lists multiple options.

### Principal Engineer (Lead) — consult: full-stack-orchestration
- **Architecture Fit**: Does this align with system design?
- **Complexity Assessment**: Is this appropriately scoped?
- **Recommendations**: Architectural considerations, patterns to follow

### Frontend Specialist — consult: frontend-mobile-development
- **UI/UX Approach**: Component structure, user interaction flow
- **Design Integration**: Tailwind/shadcn components needed? New or existing?
- **Recommendations**: Frontend implementation strategy

### Backend Specialist — consult: backend-development
- **API Design**: Endpoints, contracts, data flow
- **Database Changes**: Schema modifications needed?
- **Recommendations**: Backend implementation strategy

If the feature involves API work, invoke `/backend-development:api-design-principles` for detailed API design guidance.

### QA Lead
- **Testing Strategy**: Unit, integration, E2E approach
- **Edge Cases**: Scenarios to test, boundary conditions
- **Recommendations**: Quality gates and acceptance criteria

### Implementation Plan
Based on council input, produce a structured task breakdown:

**Frontend Tasks**: Component development, routing, state management, styling
**Backend Tasks**: API endpoints, services, business logic, validation
**Database Tasks**: Schema changes, migrations, seed data
**Testing Tasks**: Test creation, coverage goals, E2E scenarios
**Estimated Complexity**: Small / Medium / Large

### CHECKPOINT: Present the Feature Council implementation plan to the user. Wait for approval of the task breakdown before proceeding.

## Step 5: Generate Decision Record

Determine the next decision number by reading existing files in `.claude/councils/decisions/`.

Using the template from `.claude/councils/decisions/001-example-architecture-decision.md`, create a decision record that includes:

- **Date**: Today's date
- **Council**: Product Council + Feature Council
- **Status**: Approved (after user approval)
- **Question**: The feature being evaluated
- **Context**: Current situation, requirements, constraints
- **Council Votes**: All votes from both Product and Feature councils
- **Decision**: Approved scope (MVP + future)
- **Rationale Summary**: Synthesized perspectives from all council members
- **Action Items**: Task breakdown with clear owners (frontend, backend, testing)
- **Timeline**: Target dates based on complexity
- **Follow-up**: When to revisit, what to validate post-launch
- **References**: Related issues, documentation, prior decisions

Invoke `/documentation-generation:architecture-decision-records` for ADR formatting guidance if the decision involves architectural choices.

### CHECKPOINT: Present the decision record to the user for final review before saving.

## Step 6: Create Branch and Save Artifacts

1. Create a feature branch following CONTRIBUTING.md conventions:
   ```bash
   git checkout main && git pull origin main
   git checkout -b feature/<feature-slug>
   ```

2. Save the decision record:
   ```
   .claude/councils/decisions/NNN-<feature-slug>.md
   ```

3. Commit with:
   ```
   docs(council): document feature plan for <feature-name>
   ```

## Step 7: Output Summary

Present a clear summary:

- **Approved Scope**: MVP capabilities and deferred items
- **Task Breakdown**: Frontend, backend, database, and testing tasks
- **Feature Flag**: Name and strategy (if applicable)
- **Success Metrics**: How we'll measure outcomes
- **Branch**: Feature branch name ready for implementation
- **Decision Record**: File path for reference

**Next step**: Run `/build-feature` for full-stack implementation, or `/build-api` for backend-only work.

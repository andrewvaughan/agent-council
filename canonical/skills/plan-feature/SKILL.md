---
name: plan-feature
description: Plan a new feature from concept to approved implementation plan. Activates Product Council for strategic evaluation, then Feature Council for technical planning. Produces a documented decision and scoped task breakdown. Use when starting any new feature work.
---

# Feature Planning Workflow

Take a feature idea from concept to an approved implementation plan with lean scope, council consensus, and a documented decision record. This skill **challenges assumptions, asks hard questions, and pushes back** at every stage — before councils review, after councils vote, and before final approval. The goal is to arrive at the strongest possible plan, not to rubber-stamp the first idea.

> [!CAUTION]
> **Scope boundary**: This skill produces a _plan_, a decision record, and issue(s) in your project tracker. It does **NOT** write application code, create components, modify database schemas, run tests, create branches for implementation, or perform any build work. If the user asks to start building after the plan is approved, direct them to run `/build-feature <issue-number>` — do not begin implementation yourself.

## Step 1: Gather Feature Context

Ask the user to describe:

- **What** the feature does (user-facing behavior)
- **Who** it is for (target users)
- **Why** it matters (business or product value)
- **Constraints** (time, technical, budget, dependencies)

If the user provides an issue number, fetch the issue details from your project's issue tracker.

If the user provides a brief description, that's sufficient — but do NOT simply accept it at face value. Proceed to Step 2.

## Step 2: Critical Analysis & Challenge

Before sending the feature to council, **act as a skeptical advisor**. Your job is to stress-test the idea and help the user arrive at the strongest possible version of their feature.

### Challenge Assumptions

Identify and question the implicit assumptions in the feature request:

- **Problem validity**: Is this solving the right problem? Could the user's stated problem be a symptom of a deeper issue?
- **Solution fit**: Is this the best solution, or is the user anchored on the first idea that came to mind? Present 1-2 alternative approaches if viable.
- **Scope creep risk**: Is the user asking for more than they need? What's the smallest thing that would validate the core hypothesis?
- **Timing**: Is this the right thing to build now, given the current state of the project? Are there prerequisites or dependencies that should come first?

### Ask Clarifying Questions

Ask 2-4 pointed questions that expose gaps or weak spots in the proposal. Examples:

- "What happens if [edge case]? Have you considered...?"
- "You mentioned X — but how does that interact with the existing Y?"
- "What's the user's current workaround? How painful is it really?"
- "What would you cut if this had to ship in half the time?"

### Make Recommendations

Based on your analysis, present:

- **What's strong** about the proposal (validate what works)
- **What concerns you** (risks, blind spots, over-engineering)
- **What you'd change** (concrete suggestions, not vague warnings)
- **Alternative framing** (if the problem could be solved differently)

### CHECKPOINT: Present your critical analysis and questions to the user. Wait for their responses and any scope adjustments before proceeding to the Product Council. Do NOT rubber-stamp — if the answers don't satisfy your concerns, push back again.

## Step 3: Activate the Product Council

Read the Product Council template from the skill's `councils/product-council.md` and evaluate the feature from all 6 member perspectives. For each council member, read their agent definition from the skill's `agents/` directory and use the complexity tier specified to calibrate review depth.

### Product Strategist (Lead)

- **User Value**: Does this solve a real user problem? Market fit?
- **Priority**: Is this the right thing to build now?
- **Recommendations**: Strategic considerations, positioning

### Lean Delivery Lead

- **Lean Scope**: What is the smallest version we can ship to get feedback?
- **Speed to Feedback**: How quickly can we get this in front of users?
- **Feature Flag Strategy**: Should this be prototyped behind a feature flag?
- **Recommendations**: How to ship faster and learn faster

### Design Lead

- **Design Quality**: Brand consistency? UX intuitiveness?
- **Accessibility**: WCAG compliance requirements?
- **Recommendations**: Design approach, component needs

### Business Operations Lead

- **Cost Analysis**: Budget required? Infrastructure costs?
- **ROI Potential**: Expected return on investment?
- **Recommendations**: Cost optimizations or budget concerns

### Principal Engineer

- **Technical Feasibility**: Can we build this? Complexity level?
- **Architectural Fit**: Does this align with the project's established architecture?
- **Recommendations**: Technical constraints or alternative approaches

### Frontend Specialist

- **Implementation Assessment**: UX feasibility? Component complexity?
- **User Experience**: Implementation challenges?
- **Recommendations**: Frontend implementation approach

Present the full Product Council evaluation with all votes and recommendations.

### Post-Council Synthesis

After the council votes, **do not simply pass their results through**. Add your own analysis:

- **Where do you agree with the council?** Reinforce the strongest points.
- **Where do you disagree?** If a council member's assessment seems off, say so and explain why.
- **What did the council miss?** Identify blind spots — topics no member raised that matter.
- **Groupthink check**: If all members agree, play devil's advocate. What's the strongest argument against this feature?
- **Refined recommendation**: Based on both the council input and your own critical analysis from Step 2, give your honest recommendation — build as proposed, modify scope, defer, or reconsider entirely.

### CHECKPOINT: Present the Product Council results AND your synthesis to the user. If you have concerns the council didn't surface, raise them now. Wait for approval of scope and priority before proceeding to technical planning.

## Step 4: Define Lean Scope

Based on Product Council feedback, clearly define:

- **MVP Scope**: What ships in the first increment (1-2 weeks max). List specific user-facing capabilities.
- **Future Iterations**: What comes after MVP validation. List deferred capabilities.
- **Feature Flag Strategy**: Whether this should ship behind a flag, and the flag name.
- **Success Metrics**: How will we know this feature works? Define 2-3 measurable outcomes.

## Step 5: Activate the Feature Council

Read the Feature Council template from the skill's `councils/feature-council.md` and create the technical implementation plan. For each council member, read their agent definition from the skill's `agents/` directory and use the complexity tier specified to calibrate review depth.

### Principal Engineer (Lead)

- **Architecture Fit**: Does this align with system design?
- **Complexity Assessment**: Is this appropriately scoped?
- **Recommendations**: Architectural considerations, patterns to follow

### Frontend Specialist

- **UI/UX Approach**: Component structure, user interaction flow
- **Design Integration**: Components from the design system needed? New or existing?
- **Recommendations**: Frontend implementation strategy

### Backend Specialist

- **API Design**: Endpoints, contracts, data flow
- **Database Changes**: Schema modifications needed?
- **Recommendations**: Backend implementation strategy

If the feature involves API work, evaluate the API design against these principles:

<details>
<summary>API Design Guidance</summary>

- Are resource names following consistent conventions?
- Are request/response contracts explicitly typed?
- Do error responses follow a standardized format?
- Are authentication requirements defined per endpoint?
- Are input validation rules specified for all user input?
- Is versioning strategy considered?
- Are idempotency requirements identified for write operations?

</details>

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

### Post-Council Synthesis

After the Feature Council votes, add your own technical analysis:

- **Implementation risks**: What's the hardest part of this plan? Where are teams most likely to get stuck or underestimate effort?
- **Sequencing concerns**: Is the task breakdown in the right order? Are there hidden dependencies between frontend and backend work?
- **Over-engineering check**: Is the council proposing more infrastructure than this feature needs? Could we do less and still validate the hypothesis?
- **Under-engineering check**: Is anything missing that will bite us later — error handling, migration rollback, accessibility, performance?
- **Honest assessment**: Given everything discussed, rate your confidence that this plan will succeed as written (High / Medium / Low) and explain why.

### CHECKPOINT: Present the Feature Council implementation plan AND your technical synthesis to the user. Flag any concerns about sequencing, risk, or scope. Wait for approval of the task breakdown before proceeding.

## Step 6: Generate Decision Record

Determine the next decision number by reading existing files in `docs/decisions/`.

Using the template from the skill's `templates/decision-record.md`, create a decision record that includes:

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

### GFM Formatting Requirements

Decision records render in GitHub Flavored Markdown. Follow these rules:

- **Metadata blocks** must use bullet points (`- **Key**: value`), never consecutive bold lines.
- **Use GitHub alerts** (`> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]`) for callouts instead of bold/italic emphasis.
- **Include a mermaid diagram** when the decision involves multiple components, services, or data flows. Place it in the Context or Rationale Summary section to visualize the architecture.
- **Use collapsible `<details>` sections** for lengthy council evaluations if the record would otherwise exceed ~150 lines of votes.
- **Use tables** for structured comparisons (e.g., options considered with trade-offs).

<details>
<summary>ADR Format Checklist</summary>

Ensure the decision record includes all required sections:

- [ ] Title with decision number prefix (e.g., `003-feature-name`)
- [ ] Date, Council, and Status metadata
- [ ] Question section clearly stating what was decided
- [ ] Context section with background and constraints
- [ ] Council Votes section with all member assessments
- [ ] Decision section with approved scope
- [ ] Rationale Summary synthesizing council perspectives
- [ ] Action Items with task breakdown
- [ ] Timeline with target dates
- [ ] Follow-up criteria for post-launch validation
- [ ] References to related issues and documents

</details>

### CHECKPOINT: Present the decision record to the user for final review before saving.

## Step 7: Create Branch and Save Artifacts

1. Create a feature branch following your project's branch naming conventions:

   ```bash
   git checkout main && git pull origin main
   git checkout -b feature/<feature-slug>
   ```

2. Save the decision record:

   ```
   docs/decisions/NNN-<feature-slug>.md
   ```

3. Commit with:
   ```
   docs(council): document feature plan for <feature-name>
   ```

## Step 8: Pre-Issue Validation

Before creating issue(s), validate the planning artifacts:

1. **Decision record completeness**: Verify the decision record file exists and contains all required sections (Question, Context, Council Votes, Decision, Rationale Summary, Action Items, Timeline). If any section is missing, stop and add it before proceeding.

2. **Council consensus**: Scan both council vote sections for any "Block" votes. If a Block vote exists:

   > [!WARNING]
   > A council member voted to Block this feature. Creating an implementation issue with unresolved Block votes is unusual. Consider addressing the concern before proceeding.

   Ask the user whether to proceed or resolve the concern first.

3. **Task breakdown present**: Verify the Action Items section contains at least one task (checkbox line). If empty, stop and ask the user to define the implementation tasks.

4. **Approval status**: Verify the Decision section shows `Status: Approved`. If not approved, warn the user before proceeding.

## Step 9: Create Issue(s)

> [!IMPORTANT]
> Issues are **actionable work items** derived from the decision record — they do NOT replace it. The decision record (Step 6) remains the authoritative project-level record of council evaluations, rationale, and architectural context. Issues reference the decision record and provide a task-oriented view for `/build-feature` to consume.

Create issue(s) containing the full implementation plan so that `/build-feature` can be run from an issue at any time — immediately or days later.

Include these sections in the issue body:

**Problem Statement**: From the decision record's Question and Context sections. Explain what is being solved and why.

**Council Decisions**: Summarize both councils:

- Product Council vote tally and key decisions
- Feature Council vote tally and architecture decisions
- Any dissenting opinions or conditions

Use a collapsible `<details>` section for full council votes if they exceed ~30 lines.

**Implementation Plan**: The Action Items from the decision record, organized by layer (Frontend, Backend, Database, Testing) with checkboxes. This is the primary content that `/build-feature` will consume.

**Success Metrics**: The measurable outcomes from the lean scope definition (Step 4).

**Technical Context**: Key technical decisions — architecture patterns, API contracts, schema changes, component structure.

**Decision Record Reference**: Link to the decision record file.

**Feature Branch**: The branch name created in Step 7.

**Feature Flag**: Flag name and strategy, if applicable.

**Estimated Complexity**: Small / Medium / Large from the Feature Council assessment.

### Multi-Issue Option

If the implementation plan has multiple distinct phases, ask the user:

> The implementation plan has N phases. Would you like:
>
> 1. A single issue with all phases as task groups
> 2. Separate issues per phase (cross-referenced)

If separate issues, create them in sequence with "Part X of N" and links to sibling issues.

### CHECKPOINT: Present the issue title and full body to the user for review. Allow edits to any section, title changes, or splitting decisions before creating.

### Create the Issue

Use your project's issue tracker CLI. Using GitHub CLI as an example:

```bash
gh issue create \
  --title "<title>" \
  --body "<body>" \
  --label "enhancement" \
  --label "feature-implementation"
```

Report the created issue number(s) and URL(s).

## Step 10: Output Summary

Present a clear summary:

- **Approved Scope**: MVP capabilities and deferred items
- **Task Breakdown**: Frontend, backend, database, and testing tasks
- **Feature Flag**: Name and strategy (if applicable)
- **Success Metrics**: How we'll measure outcomes
- **Branch**: Feature branch name ready for implementation
- **Decision Record**: File path for reference
- **Issue(s)**: Issue number(s) and URL(s) for the implementation plan

**Next step**: Run `/build-feature <issue-number>` for full-stack implementation, or `/build-api` for backend-only work.

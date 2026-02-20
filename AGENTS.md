# Agent Council

Multi-perspective AI development workflows using councils of specialized agents. Install these skills to add structured planning, implementation, review, and security workflows to your AI coding agent.

    npx skills add andrewvaughan/agent-council

## Skills

| Skill | Purpose |
|-------|---------|
| plan-feature | Plan a feature with Product + Feature council evaluation |
| build-feature | Full-stack implementation (database, API, frontend, tests) |
| build-api | Backend-only API development and database changes |
| review-code | Multi-perspective code review with security scanning |
| submit-pr | Quality checks, PR creation, and deployment review |
| security-audit | SAST scanning, STRIDE threat modeling, attack trees |

### Development Pipeline

Skills compose into an end-to-end development workflow:

    plan-feature --> build-feature or build-api --> review-code --> submit-pr

    plan-feature    Scope and plan the feature with council review
         |          Creates issue(s) with implementation plan
         v
    build-feature   Implement from issue or decision record
      or build-api  (for backend-only work)
         |
         v
    review-code     Multi-perspective code review + security scan
         |
         v
    submit-pr       Quality checks, PR creation, deployment review

Standalone skills can be run at any point:

- security-audit: comprehensive security audit (before releases, after changes, or on a regular cadence)

Each skill suggests the next skill when it completes.

### Skill Descriptions

**plan-feature**: Takes a feature idea from concept to approved plan. Activates the Product Council (6 members) for strategic evaluation, then the Feature Council (4 members) for technical planning. Produces a decision record, implementation task breakdown, and tracking issue(s). Does NOT write code.

**build-feature**: Executes a full-stack implementation across database, backend, frontend, and testing layers. Loads the plan from a tracking issue or decision record. Includes checkpoints for schema approval, API contract review, and final commit approval. Does NOT create PRs.

**build-api**: Backend-only implementation for API endpoints, services, and database changes. Optionally activates the Architecture Council for significant API decisions. Does NOT create PRs.

**review-code**: Runs automated security scanning (SAST, hardening, accessibility) then activates the Review Council (4 members). Produces a consolidated report organized by severity. Fixes approved items and commits. Does NOT create PRs.

**submit-pr**: Pre-submission quality checks, change analysis, and PR creation. Optionally activates the Deployment Council for production-impacting changes. Monitors CI and fixes failures. Does NOT implement features.

**security-audit**: Combines SAST scanning, security hardening review, STRIDE threat modeling, and attack tree analysis. Activates a security-focused subset of the Architecture Council. Produces a prioritized audit report with remediation steps. Can run independently of the pipeline.

## Councils

Councils are groups of agent personas that evaluate decisions from multiple perspectives. Skills activate the appropriate council automatically, but you can also activate councils directly for ad-hoc decisions.

| Council | Members | Purpose |
|---------|---------|---------|
| Product | Product Strategist, Lean Delivery Lead, Design Lead, Business Ops Lead, Principal Engineer, Frontend Specialist | Feature scoping, priority, user value |
| Feature | Principal Engineer, Frontend Specialist, Backend Specialist, QA Lead | Technical planning, task breakdown |
| Architecture | Principal Engineer, Platform Engineer, Security Engineer, Backend Specialist | API design, schema changes, patterns |
| Review | Security Engineer, QA Lead, DevX Engineer, Domain Specialist | Code quality, security, documentation |
| Deployment | Platform Engineer, Security Engineer, QA Lead | Release readiness, infrastructure |

### Activating a Council Directly

For ad-hoc decisions outside of a skill workflow, ask your agent to activate a council:

    Activate the Architecture Council to evaluate:
    Should we use a synchronous or asynchronous API pattern?
    Context: [describe your project context]

Council templates are in the skill's councils/ directory. Each member votes Approve, Concern, or Block with rationale and recommendations.

### Decision Records

Document council decisions for future reference:

1. Review each agent's vote and rationale
2. Save the record using the decision record template
3. Reference the record in related issues and PRs

## Agents

11 specialized agent personas provide diverse perspectives across councils.

| Agent | Role | Focus |
|-------|------|-------|
| Principal Engineer | Technical leadership | Architecture, scalability, trade-offs |
| Frontend Specialist | UI/UX implementation | Components, state, accessibility, performance |
| Backend Specialist | API and services | Endpoints, business logic, data access |
| Security Engineer | Application security | OWASP, auth, secrets, vulnerability assessment |
| QA Lead | Quality assurance | Testing strategy, coverage, edge cases |
| Platform Engineer | Infrastructure | Deployment, containers, CI/CD, monitoring |
| DevX Engineer | Developer experience | Documentation, tooling, onboarding |
| Product Strategist | Product direction | User value, market fit, priority |
| Lean Delivery Lead | Delivery optimization | Scope reduction, speed to feedback, feature flags |
| Design Lead | Design quality | UX patterns, accessibility, design system |
| Business Ops Lead | Business analysis | Cost, ROI, operational impact |

Each agent has a Complexity section with two tiers:

- **Standard**: Routine work (most tasks)
- **Advanced**: Critical decisions (architecture, security, major features)

Use the Standard tier by default. Escalate to Advanced when the decision has broad or lasting impact.

Agent definitions are in the skill's agents/ directory.

## Rules

These rules govern how skills and councils operate. Your AI agent should follow them when executing skills.

### Skill Boundaries

Each skill owns a specific phase. Never skip ahead to the next skill's work:

| Skill | Owns | Does NOT do |
|-------|------|-------------|
| plan-feature | Planning, council review, decision record, issues | Writing code, building |
| build-feature | Implementation, tests, commits | PRs, pushing, code review |
| build-api | Backend implementation, tests, commits | PRs, pushing, code review |
| review-code | Code review, applying fixes, committing fixes | PRs, pushing |
| submit-pr | Pushing, PR creation, CI monitoring, CI fixes | Feature implementation |

When a skill finishes, it suggests the next skill. Stop and let the user invoke the next skill -- do not chain automatically.

### Pipeline State Tracking

Always remind the user where they are in the pipeline:

- At the end of every skill
- After a tangent or side task during a skill
- When resuming a conversation that was interrupted
- When the user seems unsure what to do next

### Work Routing

When the user describes an idea or request, determine the right approach:

- **Quick fix**: Small changes (bug fixes, config tweaks, docs, refactors under ~100 lines). Work directly on a fix/ or chore/ branch without the full planning pipeline.
- **plan-feature**: New features, significant changes, or anything touching multiple layers. Invokes council evaluation and creates a structured plan.

### Code Conventions

- Branch naming: feature/, fix/, docs/, refactor/, test/, chore/
- Commits: Conventional Commits format -- type(scope): subject
- Merge strategy: Squash and merge (default)
- PR size: Under 400 lines ideal, under 1000 maximum
- Test coverage: Above 80%

### Quality Standards

- Avoid untyped code without justification
- All async operations must have error handling
- Follow OWASP security guidelines, no secrets in code
- Accessibility compliance for UI (WCAG 2.1 AA)
- Required tests: unit (logic), integration (APIs), E2E (critical flows)

### Documentation Standards

Every change that alters how the project is set up, built, or run must include documentation updates. A new contributor should be able to get the project running from documentation alone.

## Customization

Skills, agents, and councils can be customized for your project:

- **Agents**: Edit agent definitions in canonical/agents/ to adjust focus areas, complexity tiers, or add new personas
- **Councils**: Edit council templates in canonical/councils/ to change membership or evaluation criteria
- **Skills**: Edit skill workflows in .claude/skills/ to modify steps, checkpoints, or guidance
- **Build**: Run scripts/build.sh to regenerate the distributable skills/ directory after changes

See CONTRIBUTING.md for detailed instructions on adding or modifying skills, agents, and councils.

## File Reference

After installation, the package provides:

    skills/
      plan-feature/
        SKILL.md              Skill workflow definition
        agents/               Agent personas used by this skill
        councils/             Council templates used by this skill
        templates/            Shared templates (decision records, etc.)
      review-code/
        SKILL.md
        agents/
        councils/
      submit-pr/
        SKILL.md
        agents/
        councils/
      security-audit/
        SKILL.md
        agents/
        councils/

    canonical/                Source of truth (for contributors)
      agents/                 All 11 agent definitions
      councils/               All 5 council templates
      templates/              Shared templates

    scripts/
      build.sh                Generates skills/ from canonical + sources
      skill-manifest.json     Maps skills to required resources

# Councils of Agents & Workflow Skills

> Multi-perspective decision-making and end-to-end development workflows using specialized AI agents

## Workflow Skills

Skills are executable workflows you invoke as slash commands in Claude Code. Each skill orchestrates councils, plugins, and human checkpoints into a structured, multi-step development pipeline. Skills automate the full development lifecycle while keeping you in control at every critical decision point.

### How to Use Skills

Type `/` in Claude Code to see available skills in the autocomplete menu, or invoke a skill directly by typing its name with an optional description:

```
/plan-feature Add user authentication with OAuth2 providers

/review-code

/security-audit Focus on the API authentication layer
```

Each skill follows a structured workflow with numbered steps. At human checkpoint steps, the skill pauses and presents its findings or work for your review. You decide whether to approve, request changes, or skip before the skill proceeds.

### Development Pipeline

Skills compose into a natural development flow. The typical end-to-end workflow is:

```
/plan-feature       Scope and plan the feature with council review
       |            Creates GitHub issue(s) with implementation plan
       v
/build-feature      Implement from GitHub issue (or decision record)
  or /build-api     (for backend-only work)
       |
       v
/review-code        Multi-perspective code review + security scan
       |
       v
/submit-pr          Quality checks, PR creation, deployment review
```

Standalone skills can be run at any point:

- `/security-audit` - Comprehensive security audit (before releases, after security changes, or on a regular cadence)
Each skill suggests the next skill to run when it completes, so you always know what comes next.

---

### `/plan-feature` - Feature Planning

**Purpose**: Take a feature idea from concept to an approved implementation plan with lean scope, council consensus, and a documented decision record. This ensures every feature is evaluated from product, design, and technical perspectives before any code is written.

**When to use**: At the start of any new feature work, before writing code.

**What it does**:

1. **Gathers context** from you about what the feature does, who it's for, why it matters, and any constraints. Can also pull context from a GitHub issue number.

2. **Activates the Product Council** (all 6 members) to evaluate:
   - Product Strategist: User value, market fit, priority
   - Lean Delivery Lead: Smallest shippable version, feature flag strategy
   - Design Lead: UX approach, accessibility, design system alignment
   - Business Operations Lead: Cost and ROI analysis
   - Principal Engineer: Technical feasibility, architecture fit
   - Frontend Specialist: Implementation complexity, component needs

3. **CHECKPOINT**: Presents the Product Council evaluation. You approve the scope and priority.

4. **Defines lean scope**: MVP capabilities (1-2 week increment), future iterations, feature flag strategy, success metrics.

5. **Activates the Feature Council** (4 members) for technical planning:
   - Principal Engineer: Architecture fit, complexity
   - Frontend Specialist: Component structure, routing, state
   - Backend Specialist: API endpoints, database changes, business logic
   - QA Lead: Testing strategy, edge cases, acceptance criteria

   Invokes `/backend-development:api-design-principles` for API design guidance when the feature involves backend work.

6. **CHECKPOINT**: Presents the implementation plan with task breakdown. You approve the plan.

7. **Generates a decision record** using the template from `.claude/councils/decisions/001-example-architecture-decision.md`, invoking `/documentation-generation:architecture-decision-records` for formatting. Includes all council votes, rationale, action items, and timeline.

8. **CHECKPOINT**: Presents the decision record for final review.

9. **Creates a feature branch** and saves the decision record to `.claude/councils/decisions/NNN-<feature-slug>.md`.

10. **Pre-issue validation**: Verifies the decision record is complete, council consensus has no Block votes, and the task breakdown is present.

11. **CHECKPOINT**: Presents the assembled GitHub issue content for review before creation.

12. **Creates GitHub issue(s)** via `gh issue create` with the implementation plan, council decisions, success metrics, and decision record reference. Supports single-issue or multi-issue (per-phase) creation.

**Outputs**: Decision record (authoritative project-level record of council evaluations and rationale), feature branch, GitHub issue(s) (actionable work items referencing the decision record), task breakdown ready for implementation.

**Next step**: `/build-feature <issue-number>` or `/build-api`

---

### `/build-feature` - Full-Stack Implementation

**Purpose**: Execute a full-stack feature implementation across database, backend, frontend, and testing layers. Follows the implementation plan produced by `/plan-feature`.

**When to use**: After `/plan-feature` has produced an approved plan, or when you have a clear set of tasks spanning multiple layers.

**What it does**:

1. **Loads the implementation plan** from a GitHub issue number (primary), the most recent decision record (fallback), or asks you what to build. When given an issue number, fetches the issue via `gh issue view`, extracts the task breakdown, and reads the referenced decision record for full context. Verifies you're on a feature branch.

2. **Database layer** (if schema changes needed):
   - Invokes `/database-design:postgresql` for schema design
   - Designs Prisma schema changes (models, relations, indexes, constraints)
   - Invokes `/database-migrations:sql-migrations` for migration best practices
   - **CHECKPOINT**: Presents schema and migration plan for approval before running

3. **Backend implementation**:
   - Invokes `/backend-development:feature-development` for scaffolding guidance
   - Builds types/DTOs with Zod validation
   - Implements service layer (business logic, error handling)
   - Creates tRPC procedures or NestJS controllers
   - Writes backend unit and integration tests
   - **CHECKPOINT**: Presents API contract for approval before frontend work begins

4. **Frontend implementation**:
   - Invokes `/ui-design:create-component` for guided component creation
   - Uses `/frontend-mobile-development:tailwind-design-system` for Tailwind + shadcn/ui styling
   - Uses `/frontend-mobile-development:react-state-management` for state patterns
   - Builds components with TypeScript, responsive design, accessibility
   - Wires up API integration via tRPC client
   - Implements feature flag wrapper if specified in the plan
   - Writes component tests with React Testing Library
   - **CHECKPOINT**: Presents the frontend implementation for visual review

5. **End-to-end testing**: Writes E2E test outlines for critical user flows.

6. **Self-review**: Runs `pnpm type-check`, `pnpm lint`, and `pnpm test`. Checks for security issues, TypeScript `any` types, and missing error handling.

7. **CHECKPOINT**: Presents a complete summary of all changes (files, tests, coverage) for approval before committing.

**Outputs**: Implemented feature with tests, committed to feature branch.

**Next step**: `/review-code`

---

### `/build-api` - Backend API Development

**Purpose**: Build backend-only API endpoints, services, and database changes. For cases where only backend work is needed without frontend changes.

**When to use**: When building new API endpoints, business logic, database schema changes, or when the frontend will be built separately.

**What it does**:

1. **Defines API requirements** from the decision record or user description: resources, operations, schema changes, tRPC vs REST.

2. **Designs the API contract**:
   - Invokes `/backend-development:api-design-principles` for design guidance
   - Defines endpoints/procedures, request/response types, validation rules, auth requirements
   - If this is a **significant API decision** (new resource type, breaking change, new pattern), activates the **Architecture Council** with all 4 members evaluating the design
   - **CHECKPOINT**: Presents API contract (and council evaluation if activated) for approval

3. **Database layer** (if needed):
   - Invokes `/database-design:postgresql` for schema guidance
   - Designs Prisma schema changes
   - Invokes `/database-migrations:sql-migrations` for migration generation
   - **CHECKPOINT**: Presents schema and migration for approval before running

4. **Backend implementation**:
   - Follows `/backend-development:architecture-patterns` for clean architecture
   - Builds in layers: Types/DTOs, Repository/Data layer, Service layer, Controller/Router layer, Guards/Middleware
   - Uses `/javascript-typescript:typescript-advanced-types` for complex type scenarios

5. **Tests**: Unit tests (mocked dependencies), integration tests (real database), validation tests (edge cases). Targets >80% coverage.

6. **API documentation**: Invokes `/documentation-generation:openapi-spec-generation` to generate OpenAPI specs or document tRPC procedures.

7. **Self-review**: Runs type-check, lint, and test. Checks for hardcoded secrets, missing validation, `any` types.

8. **CHECKPOINT**: Presents implementation summary with test results and documentation for approval.

**Outputs**: API endpoints with tests and documentation, committed to feature branch.

**Next step**: `/review-code`

---

### `/review-code` - Code Review

**Purpose**: Run a comprehensive, multi-perspective code review combining automated security scanning with the Review Council's human-perspective evaluation. Catches security, quality, documentation, and domain-specific issues before they reach a PR.

**When to use**: After implementation is complete, before creating a pull request. Also useful mid-development for a quality check.

**What it does**:

1. **Analyzes current changes**: Runs `git diff origin/main...HEAD` and categorizes changed files by layer (frontend, backend, database, config, docs, tests).

2. **Automated security scanning**:
   - Invokes `/security-scanning:security-sast` on all changed files (SQL injection, XSS, CSRF, secrets, dependencies)
   - If backend files changed, invokes `/security-scanning:security-hardening` for API security, auth, input validation, error leakage

3. **Accessibility audit** (if frontend files changed):
   - Invokes `/ui-design:accessibility-audit` for WCAG compliance on modified components
   - Checks contrast, keyboard nav, ARIA, focus management, semantic HTML

4. **Activates the Review Council** (all 4 members from `.claude/councils/review-council.md`):
   - **Security Engineer** (Lead): Reviews SAST findings, checks OWASP Top 10, validates input sanitization, auth patterns, secrets management. Votes Approve/Concern/Block.
   - **QA Lead**: Assesses test coverage for changed files, identifies untested edge cases, checks >80% coverage target. Votes Approve/Concern/Block.
   - **DevX Engineer**: Checks documentation is updated, reviews code readability, verifies README/docs reflect changes. Votes Approve/Concern/Block.
   - **Domain Specialist** (Frontend Specialist and/or Backend Specialist based on changed files): Reviews domain-specific patterns, architecture adherence, performance. Votes Approve/Concern/Block.

5. **Presents consolidated review report** organized by severity:
   - Critical/Blocking issues (Block votes, Critical SAST findings)
   - High priority issues (High findings, security Concerns)
   - Medium priority issues (code quality, documentation gaps)
   - Low priority / suggestions
   - Overall status: Approved / Needs Changes / Blocked

6. **CHECKPOINT**: Presents all findings. You decide which items to address and which to accept.

7. **Applies fixes** for approved items, re-runs relevant checks to verify each fix.

8. **CHECKPOINT**: Presents applied fixes for confirmation before committing.

**Outputs**: Review report, fixes committed.

**Next step**: `/submit-pr`

---

### `/submit-pr` - Pull Request Submission

**Purpose**: Create a well-documented pull request with pre-submission quality checks, auto-generated description from the PR template, and optional Deployment Council review for production-impacting changes.

**When to use**: When your feature branch is ready to merge to main, typically after `/review-code`.

**What it does**:

1. **Pre-submission checks**:
   - Verifies you're on a feature branch (not `main`)
   - Rebases on `origin/main` to ensure you're up to date (helps resolve conflicts)
   - Runs `pnpm type-check`, `pnpm lint`, `pnpm test`, and `pnpm build`
   - Runs a final `/security-scanning:security-sast` scan
   - Reports any failures and asks whether to fix or proceed

2. **Analyzes changes**: Reads all commits and diffs since diverging from main. Determines change type (feature, fix, docs), scope (frontend, backend, full-stack), whether migrations/infra/security changes are included.

3. **Deployment Council review** (conditional - activated only if the PR includes database migrations, Docker/infrastructure changes, environment variable modifications, auth code changes, or CI/CD pipeline changes):
   - **Platform Engineer** (Lead): Docker builds, env vars, health checks, resource limits, logging, rollback strategy
   - **Security Engineer**: Secrets management, TLS, API auth, CORS, security headers, vulnerability check
   - **QA Lead**: E2E tests, critical flows, performance, regressions, smoke tests
   - Produces a deployment decision: Approved / Not Ready / Blocked
   - **CHECKPOINT**: Presents deployment readiness assessment for confirmation

4. **Generates PR description** using the template from `.github/PULL_REQUEST_TEMPLATE.md`:
   - Auto-fills: Description, Type of Change, Related Issues, Changes Made, Testing, Checklist, Breaking Changes, Deployment Notes
   - Invokes `/documentation-generation:changelog-automation` for changelog entry
   - **CHECKPOINT**: Presents the PR title and full body for review and editing

5. **Pushes and creates PR**: Pushes branch with `-u` flag, creates PR via `gh pr create` targeting `main`.

6. **Post-PR summary**: Displays PR URL, changelog entry, CI monitoring reminder, and branch cleanup reminder.

**Outputs**: Pull request created on GitHub.

---

### `/security-audit` - Security Audit

**Purpose**: Run a comprehensive security audit combining automated SAST scanning, STRIDE threat modeling, attack tree analysis, and council review. Produces a prioritized audit report with actionable remediation steps.

**When to use**: Before major releases, after security-sensitive changes, after dependency updates, or on a regular cadence. Can target the full codebase or specific directories.

**What it does**:

1. **Defines scope**: You specify full codebase or specific area, the trigger (routine, pre-release, incident), and focus areas (auth, API, data protection, infra, frontend, all).
   - **CHECKPOINT**: Confirms scope before proceeding.

2. **Automated SAST scanning**: Invokes `/security-scanning:security-sast` scanning for injection, XSS, CSRF, auth issues, secrets, dependency CVEs, deserialization, prototype pollution. Every finding includes severity, OWASP category, file location, description, evidence, and remediation.

3. **Security hardening review**: Invokes `/security-scanning:security-hardening` reviewing HTTP security headers, CORS, cookies, API security (rate limiting, input validation, output encoding), authentication/authorization patterns, data protection (encryption, logging, error messages), and infrastructure security (Docker, env vars, network).

4. **STRIDE threat modeling**: Invokes `/security-scanning:stride-analysis-patterns` to systematically evaluate Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, and Elevation of Privilege threats. Each threat gets a likelihood, impact, risk score, existing mitigations, and gap analysis.

5. **Attack tree analysis**: For the top 3 highest-risk threats, invokes `/security-scanning:attack-tree-construction` to build attack trees showing goals, paths, sub-goals, required resources, existing defenses, and weakest links.

6. **Architecture Council security review** (subset):
   - Security Engineer: Validates findings, prioritizes remediation, identifies false positives, assesses overall posture
   - Principal Engineer: Assesses architectural implications, identifies systemic vulnerability patterns
   - Backend Specialist: Evaluates API security patterns, database access injection risks

7. **Presents audit report**: Executive summary, all findings by severity with remediation steps, STRIDE results, attack trees, and prioritized action plan (Immediate/This Sprint/Next Sprint/Backlog).
   - **CHECKPOINT**: You decide which findings to remediate now vs. track for later.

8. **Remediation** (optional): Fixes findings in priority order, re-runs scans to verify each fix, commits with `fix(security):` prefix.

**Outputs**: Security audit report, optional remediation commits.

---

## Councils

Councils are groups of AI agents that evaluate decisions from multiple perspectives. Skills automatically activate the appropriate council at the right time, but you can also activate councils directly for ad-hoc decisions.

### 5 Councils

| Council                                            | Members                                                                                                         | When to Use                                     |
| -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| [Architecture](./councils/architecture-council.md) | Principal Engineer, Platform Engineer, Security Engineer, Backend Specialist                                    | Tech stack, DB schema, APIs, monorepo structure |
| [Feature](./councils/feature-council.md)           | Principal Engineer, Frontend Specialist, Backend Specialist, QA Lead                                            | New features, major refactoring                 |
| [Review](./councils/review-council.md)             | Security Engineer, QA Lead, DevX Engineer, Domain Specialist                                                    | Code review, security, quality                  |
| [Deployment](./councils/deployment-council.md)     | Platform Engineer, Security Engineer, QA Lead                                                                   | Production releases, infrastructure changes     |
| [Product](./councils/product-council.md)           | Product Strategist, Lean Delivery Lead, Design Lead, Business Ops Lead, Principal Engineer, Frontend Specialist | Strategy, design, roadmap, feature flags        |

### Activating Councils Directly

For ad-hoc decisions outside of a skill workflow:

```
I need to activate the Architecture Council to evaluate:

Should we use tRPC or REST for our API layer?

Context: TypeScript monorepo with React + NestJS

Please use the decision template from .claude/councils/architecture-council.md
```

### Documenting Decisions

1. Review each agent's vote and rationale
2. Create `.claude/councils/decisions/NNN-title.md`
3. Use the template from [001-example](./councils/decisions/001-example-architecture-decision.md)

---

## Installed Plugins

Skills invoke these 19 plugins at the appropriate moments. You can also invoke any plugin command directly:

**Development**: `full-stack-orchestration`, `backend-development`, `frontend-mobile-development`, `javascript-typescript`

**Security**: `security-scanning`, `backend-api-security`, `frontend-mobile-security`

**Testing & Quality**: `unit-testing`, `code-review-ai`, `api-testing-observability`

**Design**: `ui-design`, `database-design`

**Infrastructure**: `cloud-infrastructure`, `database-migrations`

**Documentation**: `code-documentation`, `documentation-generation`

**Utilities**: `git-pr-workflows`, `dependency-management`, `debugging-toolkit`

---

## Quick Reference

| Situation                   | What to Do                        |
| --------------------------- | --------------------------------- |
| Starting a new feature      | `/plan-feature` (creates issue)   |
| Building from planned issue | `/build-feature <issue-number>`   |
| Building frontend + backend | `/build-feature`                  |
| Building API only           | `/build-api`                      |
| Ready for code review       | `/review-code`                    |
| Ready to create PR          | `/submit-pr`                      |
| Need security check         | `/security-audit`                 |
| Ad-hoc tech decision        | Activate a council directly       |
| Product/design decision     | Activate Product Council directly |

## Best Practices

1. **Plan before code** - Run `/plan-feature` before implementation
2. **Review before PR** - Run `/review-code` before `/submit-pr`
3. **Audit regularly** - Run `/security-audit` before major releases
4. **Respect checkpoints** - Don't skip human review points in workflows
5. **Document decisions** - Council decisions go in `councils/decisions/`
6. **Activate early** - Councils should be consulted before implementation, not after

## Reference

- **Skills**: `skills/*/SKILL.md`
- **Council templates**: `councils/*.md`
- **Decision records**: `councils/decisions/*.md`
- **Agent personas**: `agents/*.md`

# {PROJECT_NAME} Project Instructions <!-- TODO: Replace {PROJECT_NAME} with your project name -->

> **This file** defines project rules, conventions, and standards. For skill workflow details, council reference, and plugin documentation, see [`.claude/README.md`](.claude/README.md).

## Table of Contents

- [GitHub Repository](#github-repository)
- [Documentation Standards](#documentation-standards)
- [Code Conventions](#code-conventions)
- [Tech Stack](#tech-stack)
- [Infrastructure Philosophy](#infrastructure-philosophy)
- [Documentation Requirements](#documentation-requirements)
- [Development Workflow](#development-workflow)
  - [Routing: Quick Fix vs. Plan Feature](#routing-quick-fix-vs-plan-feature)
  - [Skill Boundaries](#skill-boundaries)
  - [Pipeline State Tracking](#pipeline-state-tracking)
  - [Project & Roadmap Integration](#project--roadmap-integration)
  - [GitHub Milestones](#github-milestones)
  - [Parent Issues and Sub-Issues](#parent-issues-and-sub-issues)
  - [Issue Scheduling and Dates](#issue-scheduling-and-dates)
  - [GitHub API Usage](#github-api-usage)
  - [Label Management](#label-management)
  - [Pull Request CI Requirements](#pull-request-ci-requirements)
- [Security Audit Scope](#security-audit-scope)
- [Quality Standards](#quality-standards)
  - [Scientific Citation Requirements](#scientific-citation-requirements)
- [REST API Standards](#rest-api-standards)
- [User-Facing Content Style](#user-facing-content-style)
- [Agent Collaboration Matrix](#agent-collaboration-matrix)
- [Council Conflict Resolution](#council-conflict-resolution)
- [Agent & Tooling Changes](#agent--tooling-changes)

## GitHub Repository

> [!IMPORTANT]
> <!-- TODO: Replace {OWNER}/{REPO} with your actual GitHub owner and repository name (e.g., "myorg/myproject"). The local directory name may not match the GitHub repo name. **Always use `--repo {OWNER}/{REPO}`** with `gh` commands, or omit `--repo` to let `gh` infer from the git remote. -->
> The GitHub repository for this project is **`{OWNER}/{REPO}`**. The local directory name may not match the GitHub repo name. **Always use `--repo {OWNER}/{REPO}`** with `gh` commands, or omit `--repo` to let `gh` infer from the git remote.

When using the `gh` CLI:

- **Do NOT guess the repo name** from the directory path. The git remote is the source of truth.
- **Preferred**: Omit `--repo` so `gh` auto-detects from the git remote
- **If specifying explicitly**: Always use `--repo {OWNER}/{REPO}` <!-- TODO: Replace {OWNER}/{REPO} with your GitHub owner/repo -->
- **Project board**: "{PROJECT_BOARD_NAME}" (project #{PROJECT_NUMBER}, owner: `{OWNER}`) <!-- TODO: Replace {PROJECT_BOARD_NAME}, {PROJECT_NUMBER}, and {OWNER} with your GitHub Projects board name, number, and owner -->

## Documentation Standards

**NEVER create non-standard markdown files in project root** (e.g., RUN.md, INSTALL.md, SETUP.md, QUICKSTART.md).

Allowed root markdown files: README.md, CONTRIBUTING.md, CHANGELOG.md, AGENTS.md, LICENSE

Where to put documentation:

- Project overview, setup, usage: README.md
- Contribution workflow: CONTRIBUTING.md
- Technical deep-dives: docs/ directory with descriptive names
- Decision records: docs/decisions/NNN-title.md
- Master document index: docs/INDEX.md

If content doesn't fit in README.md, create a file in docs/ and link from README.md.

**When adding new files to `docs/`**, add them to the appropriate table in `docs/INDEX.md` so agents can discover them. Include the document type and a one-line description.

### Markdown Frontmatter

**All project documentation files must include YAML frontmatter** to help agents quickly identify and understand each document's purpose. This applies to `README.md`, `CONTRIBUTING.md`, `CHANGELOG.md`, and files in `docs/`.

Required fields:

```yaml
---
type: <document type>
description: <one-line summary of the document's purpose>
---
```

**`type` values:**

| Type        | Used for                         | Examples                                 |
| ----------- | -------------------------------- | ---------------------------------------- |
| `guide`     | Tutorials, walkthroughs, how-tos | `docs/DEVELOPMENT.md`, `CONTRIBUTING.md` |
| `overview`  | Project-level summaries          | `README.md`                              |
| `reference` | API docs, specs, lookup tables   | `docs/api.md`                            |

When creating new project documentation, always include the appropriate frontmatter block before any content.

### Markdown Rendering

All project markdown is intended to be read in **GitHub Flavored Markdown (GFM)** renderers. Use GFM features actively to improve readability and communication.

#### Formatting Rules

- **Never place consecutive bold-label lines** without a blank line or list syntax between them. GFM collapses adjacent lines into a single paragraph.
- **Use bullet points (`-`)** for structured metadata, key-value pairs, and any multi-field blocks (e.g., Date/Council/Status headers in decision records).
- **Use blank lines** between paragraphs, after headings, and before/after lists.
- **Use tables** for structured data with 3+ columns.

Bad (collapses into one line):

```markdown
**Date**: 2026-02-15
**Council**: Product Council
**Status**: Approved
```

Good (renders as separate lines):

```markdown
- **Date**: 2026-02-15
- **Council**: Product Council
- **Status**: Approved
```

#### GitHub Alerts

Use [GitHub alert blockquotes](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts) to highlight important information:

```markdown
> [!NOTE]
> Useful background information or context.

> [!TIP]
> Helpful advice for better outcomes.

> [!IMPORTANT]
> Key information users must not miss.

> [!WARNING]
> Urgent information that needs immediate attention.

> [!CAUTION]
> Potential risks or negative outcomes to be aware of.
```

**When to use each type:**

| Alert       | Use for                         | Example                                   |
| ----------- | ------------------------------- | ----------------------------------------- |
| `NOTE`      | Context, background, FYI        | Template usage notes, non-blocking info   |
| `TIP`       | Best practices, recommendations | Performance tips, pattern suggestions     |
| `IMPORTANT` | Must-read information           | Breaking changes, required config         |
| `WARNING`   | Failure risks, urgent needs     | Security concerns, data loss potential    |
| `CAUTION`   | Negative consequences           | Irreversible actions, deprecated patterns |

#### Mermaid Diagrams

Use [Mermaid diagrams](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams) in fenced code blocks to visualize architecture, flows, and relationships. GitHub renders these natively.

Common diagram types for this project:

`````markdown
````mermaid
graph LR
    A[Component] --> B[Service]
    B --> C[Database]
```​
````
`````

| Diagram type          | Use for                                          | Example                                   |
| --------------------- | ------------------------------------------------ | ----------------------------------------- |
| `graph` / `flowchart` | Architecture, data flow, component relationships | Service abstraction layers, request flows |
| `sequenceDiagram`     | API interactions, multi-step processes           | Auth flows, subscription workflows        |
| `erDiagram`           | Database schemas, entity relationships           | Prisma model relationships                |
| `stateDiagram-v2`     | State machines, lifecycle flows                  | Feature flag states, order status         |
| `classDiagram`        | Interface hierarchies, type relationships        | Provider interfaces, service contracts    |

Use mermaid diagrams in decision records when the architecture involves **multiple components, services, or data flows** that benefit from visual representation.

#### Collapsible Sections

Use `<details>` for lengthy content that would otherwise dominate a document (e.g., verbose council evaluations, full test output, long code examples):

```markdown
<details>
<summary>Click to expand full council evaluation</summary>

Lengthy content here...

</details>
```

#### General Guidance

- **Prefer visual communication** — a mermaid diagram often communicates architecture more clearly than paragraphs of text.
- **Use alerts instead of bold/italic emphasis** for callouts that need to stand out from surrounding content.
- **Use collapsible sections** when content is useful-but-optional for the primary reader (e.g., detailed rationale in a summary document).
- **Test rendering** on GitHub before merging documentation changes.

## Code Conventions

Branch naming: feature/, fix/, docs/, refactor/, test/, chore/
Commits: Conventional Commits format: `<type>(<scope>): <subject>`
Merge: Squash and merge (default)
PR size: < 400 lines ideal, < 1000 max
Test coverage: > 80%
Dependency versions: Always use `^` (caret) ranges — never `>=`, `>`, or `*`. This applies to `dependencies`, `devDependencies`, and `pnpm.overrides` in all `package.json` files.

## Tech Stack

<!-- TODO: Replace the tech stack below with your project's actual stack. If you use a pnpm monorepo, also update the {PACKAGE_SCOPE} placeholder in .claude/settings.json with your workspace scope (e.g., "@myorg"). -->
Frontend: Vite + React 19, TypeScript 5.7+, Tailwind CSS + shadcn/ui
Backend: NestJS, Prisma + PostgreSQL, tRPC
Monorepo: pnpm + Turborepo
Testing: Vitest (frontend), Jest (backend)

## Infrastructure Philosophy

<!-- TODO: Replace the infrastructure philosophy below with your project's actual deployment model and constraints. The example below describes a self-hosted Docker homelab setup. -->
**Self-hosted, no paid SaaS.** {PROJECT_NAME} targets a Docker-driven homelab deployment. All infrastructure choices must prioritize self-hostable, open-source solutions over paid cloud services.

- **Database**: Local PostgreSQL (Docker Compose for dev, containerized for prod). No hosted DB services (Neon, Supabase, PlanetScale, etc.)
- **Email**: Resend is the current exception — evaluate self-hosted alternatives (e.g., postal, mailcow) when volume justifies it
- **Hosting**: Docker containers on homelab infrastructure. No Vercel, Railway, Fly.io, or similar PaaS
- **Dev environment**: Docker Compose for all services (PostgreSQL, API, web). Match production topology locally
- **General rule**: If a paid SaaS is proposed, always present the self-hosted alternative first. Only use paid services when no viable self-hosted option exists and the cost is justified

## Documentation Requirements

> [!TIP]
> **For agents**: Start with [`docs/INDEX.md`](docs/INDEX.md) for a navigable index of all project documentation, including science references, decision records, and development guides.

**Every change that alters how the project is set up, built, or run MUST include documentation updates.** This is non-negotiable and applies to all skills, agents, and manual development.

Changes that require documentation updates:

- New infrastructure (Docker services, databases, external dependencies)
- New environment variables or configuration files
- New CLI commands, scripts, or Makefile targets
- Changes to ports, URLs, or service architecture
- New packages or workspace additions
- Changes to the build or deployment process

Files to update (as applicable):

- `README.md` — Quick Start, Running the Application, Project Structure sections
- `docs/DEVELOPMENT.md` — Prerequisites, Local Development Setup, Troubleshooting sections
- `docs/INDEX.md` — Add new `docs/` files to the master documentation index
- `Makefile` — New targets for common operations
- `apps/api/.env.example` — New environment variables with descriptions

> [!IMPORTANT]
> If you introduce a Docker service, database, environment variable, or new dev server, a developer cloning the repo fresh must be able to get running by following README.md alone. Test your documentation mentally: "If I deleted everything and followed these steps, would it work?"

## Development Workflow

Trunk-based development: main is always production-ready, short-lived feature branches. All changes via pull requests.

### Routing: Quick Fix vs. Plan Feature

When the user describes an idea or request, ask them how they want to proceed before taking action:

- **Quick fix** — Small, scoped changes (bug fixes, config tweaks, adding tests, documentation, refactors under ~100 lines). Just do the work directly on a `fix/` or `chore/` branch without invoking the full planning pipeline.
  - _Examples: Fix typo in README, add missing test case, update .env.example, refactor a single service method_
- **`/plan-feature`** — New features, significant UI changes, or anything that touches multiple layers (database + API + frontend). Invokes council evaluation, creates a decision record and GitHub issue(s).
  - _Examples: Add user profile page, implement invite system, change database schema, add new API resource_

Use your judgment on which to suggest as the default, but always let the user choose. If in doubt, lean toward asking.

### Skill Boundaries

Each skill in the pipeline owns a specific phase. **Never skip ahead to the next skill's work:**

| Skill            | Owns                                                                     | Does NOT do                                |
| ---------------- | ------------------------------------------------------------------------ | ------------------------------------------ |
| `/plan-feature`  | Planning, council review, decision record, GitHub issues                 | Writing application code, building         |
| `/build-feature` | Implementation, tests, commits                                           | PRs, pushing to remote, code review        |
| `/build-api`     | Backend implementation, tests, commits                                   | PRs, pushing to remote, code review        |
| `/review-code`   | Code review, applying fixes, committing fixes                            | PRs, pushing to remote                     |
| `/submit-pr`     | Pushing, PR creation, CI monitoring, CI fix commits (with user approval) | Feature implementation, formal code review |
| `/hotfix`        | Urgent fix: branch, implement, focused review, PR, CI monitoring         | Feature work, changes over ~100 lines      |

> [!NOTE]
> `/review-code` is recommended but not required before `/submit-pr`. All pipeline skills except `/plan-feature` can create commits. `/submit-pr` requires user approval before committing CI fixes.

When a skill finishes, it suggests the next skill. **Stop and let the user invoke the next skill** — do not chain automatically.

### Pipeline State Tracking

**Always remind the user where they are in the pipeline**, especially:

- At the end of every skill (each skill's Hand Off step does this)
- After a tangent or side task during a skill (e.g., the user asks a question, requests an ad-hoc change, or explores something unrelated mid-workflow)
- When resuming a conversation that was interrupted or ran out of context
- When the user seems unsure what to do next

Format the reminder as:

> You were running **`/skill-name`** (Step N). The next step is **`/next-skill`**.

If a tangent occurs mid-skill, after completing the tangent, proactively say which skill step you're returning to — don't wait for the user to ask.

### Project & Roadmap Integration

**Every GitHub issue must be tracked on the [{PROJECT_BOARD_NAME}]({PROJECT_BOARD_URL}) project** with the correct phase assignment. This applies to all issue creation — whether from `/plan-feature`, ad-hoc requests, or any other workflow. <!-- TODO: Replace {PROJECT_BOARD_NAME} and {PROJECT_BOARD_URL} with your GitHub Projects board name and URL (e.g., https://github.com/users/{OWNER}/projects/{PROJECT_NUMBER}) -->

- **Phase assignment required**: When creating a GitHub issue, determine which project phase (M1–M5, or a new phase) it belongs to and assign it to the project board immediately after creation.
- **No orphaned issues**: Every `gh issue create` call — in any skill, any council, any ad-hoc context — must be immediately followed by `gh project item-add` to place the issue on the project board with Phase, Size, and Status fields set. An issue that exists outside the project board is an orphan and a tracking failure. This is a hard requirement, not a best-effort guideline.
- **No duplicate issues**: Before creating a new issue, search existing open issues to ensure no duplicate or substantially overlapping issue already exists. If a match is found, update the existing issue instead of creating a new one.
- **New phases**: If planned work doesn't fit an existing phase, recommend a new phase with rationale. New phase additions require user approval.
- **User confirmation**: Before creating issues or modifying the project plan (adding phases, reassigning issues), present a summary of all proposed changes for user approval.
- **GTM review per phase**: Every phase must have a comprehensive "Go to Market & Business Review" issue as its final work item. This issue ensures marketing pages, product messaging, and business strategy are consistent with the phase's changes and includes go-to-market recommendations. When a phase is created or modified, verify its GTM review issue exists and covers the current scope — create or update one if needed. **Exemption**: Phases that are purely bug fixes or continuous delivery/maintenance (e.g., dependency upgrades, security patches, CI improvements) are exempt from GTM review requirements.
- **Roadmap documentation**: When issues are added to phases or new phases are created, update `docs/PRODUCT.md` to reflect the current roadmap state.

### GitHub Milestones

Every project phase (M1–M5) has a corresponding **GitHub Milestone**. Milestones track progress and due dates for each phase.

<!-- TODO: Replace the milestone table below with your own project phases and their GitHub Milestone numbers. Run `gh api repos/{OWNER}/{REPO}/milestones` to see existing milestones. -->
| Milestone             | Number | Phase                                      |
| --------------------- | ------ | ------------------------------------------ |
| M1: {PHASE_1_NAME}    | 1      | {PHASE_1_DESCRIPTION}                      |
| M2: {PHASE_2_NAME}    | 2      | {PHASE_2_DESCRIPTION}                      |
| M3: {PHASE_3_NAME}    | 3      | {PHASE_3_DESCRIPTION}                      |

**Rules:**

- **Every issue must have a milestone** matching its project phase. Set the milestone when creating issues using `gh api repos/{OWNER}/{REPO}/issues/<number> -X PATCH -F milestone=<milestone-number>`.
- **Milestone due dates reflect the waterfall.** When an issue is added, removed, or rescheduled within a milestone, recalculate the milestone's due date to match the latest Target date of any issue in that milestone. Update with `gh api repos/{OWNER}/{REPO}/milestones/<number> -X PATCH -f due_on="<date>T00:00:00Z"`.
- **New milestones for new phases.** If a new phase is created, create a corresponding milestone with `gh api repos/{OWNER}/{REPO}/milestones -f title="<phase-name>" -f description="<description>" -f due_on="<date>T00:00:00Z"`.
- **Close completed milestones.** When all issues in a milestone are closed, close the milestone with `gh api repos/{OWNER}/{REPO}/milestones/<number> -X PATCH -f state="closed"`.

### Parent Issues and Sub-Issues

Features that are broken into multiple phases or implementation steps use **GitHub sub-issues** (the "Parent Issue" field) to track the relationship.

**When to create parent issues:**

- A feature is split into multiple implementation issues across milestones (e.g., Phase 1/2/3)
- An epic-level issue has been decomposed into granular sub-tasks

**How to set up sub-issues:**

1. The parent issue is the high-level feature; child issues are the individual implementation steps.
2. Get the child issue's numeric ID (not issue number): `gh api repos/{OWNER}/{REPO}/issues/<child-number> --jq '.id'`
3. Add the sub-issue: `gh api repos/{OWNER}/{REPO}/issues/<parent-number>/sub_issues -X POST -F sub_issue_id=<child-id>`
4. Parent issue dates should span from the earliest child's Start to the latest child's Target.
5. **Parent issues that span multiple milestones must NOT be assigned to any single milestone.** Remove the milestone assignment (`gh api repos/{OWNER}/{REPO}/issues/<number> -X PATCH -F milestone=null`) and clear the project phase field via GraphQL (`clearProjectV2ItemFieldValue`). The children carry the milestone and phase assignments; the parent is a tracking container only. Parent issues that have all children within a single milestone may keep that milestone assignment.

**Do NOT create parent issues for:**

- Standalone issues that are not part of a phased breakdown
- Simple features with a single implementation issue

### Issue Scheduling and Dates

Every issue on the project board must have **Start** and **Target** dates. These dates form a single-developer serial waterfall — items do not overlap by default.

**Size estimates:**

| Size | Business Days |
| ---- | ------------- |
| XS   | 1             |
| S    | 2             |
| M    | 3             |
| L    | 5             |
| XL   | 8             |

**Scheduling rules:**

- **Single developer assumed.** Schedule items serially within each milestone. The next item's Start date is the business day after the previous item's Target date.
- **Dependencies first.** Order items so that dependencies are completed before dependents begin.
- **Gate items always last.** Every milestone ends with exactly two gate items in this fixed order: GTM review (second-to-last), then security audit (last). No feature, chore, bug fix, or any other issue may be scheduled after the GTM review. When adding new issues to a milestone, always insert them before the gate items and shift both gate items forward to preserve the invariant.
- **Parent issues span children.** A parent issue's Start is its first child's Start; its Target is its last child's Target.
- **Milestone due date = last item's Target.** When any issue in a milestone changes dates, update the milestone due date to match.
- **No gaps, no overlaps.** Start and Target dates determine the order of operations for work. Every issue's Start must be the next business day after the previous issue's Target. There must never be idle gaps between consecutive issues or overlapping date ranges within a milestone.

**Schedule maintenance — cascade on every change.** Whenever an issue is **added to**, **removed from**, or **modified** (size change, reorder, etc.) within a milestone, recompute the dates of **all issues that follow it** in the milestone to maintain the serial waterfall. This includes gate items (GTM review and security audit), which always remain last. Specifically:

1. **Fetch the current milestone schedule** sorted by Start date.
2. **Identify the change point** — the position where the add/remove/modification occurred.
3. **Recompute forward from that point.** Each subsequent issue's Start = next business day after the previous issue's Target. Each issue's Target = Start + (size in business days − 1), skipping weekends.
4. **Shift gate items.** After all non-gate items are recomputed, recalculate the GTM review and security audit dates to follow the last non-gate item.
5. **Update the milestone due date** to match the security audit's new Target (the last item in the milestone).
6. **Update all affected items on the project board** using the Start and Target field IDs.

Only recompute the **current milestone being developed**. Later milestones will be adjusted when the current milestone ends.

**Schedule validation — verify after every cascade.** After applying date changes, validate the milestone schedule by checking these invariants:

1. **No gaps**: Every issue's Start is the next business day after the previous issue's Target.
2. **No overlaps**: No two issues share overlapping date ranges.
3. **Gate order preserved**: The last two items are GTM review (second-to-last) and security audit (last), in that order.
4. **Milestone due date matches**: The milestone's due date equals the security audit's Target date.
5. **Sizes match durations**: Each issue's date range (Start to Target in business days + 1) matches its Size assignment.

If any invariant fails, report the violation and fix it before proceeding. Do not silently accept an inconsistent schedule.

**When creating new issues**, the council planning process (Step 5 of `/plan-feature`) must produce size estimates and schedule dates. Use the size-to-days table above, then schedule the new issue after the last currently-scheduled **non-gate** item in its milestone (or after its dependency, whichever is later). If the milestone already has GTM review and/or security audit gate items, insert the new issue before them and shift the gate items forward so the ordering remains: all feature work → GTM review → security audit. Update the milestone due date if the shift extends it.

**Project board field IDs for date fields:**

<!-- TODO: Replace the field IDs below with your own. Run `gh project field-list {PROJECT_NUMBER} --owner {OWNER} --format json` to retrieve them after setting up your project. -->
- **Start field**: `{START_FIELD_ID}`
- **Target field**: `{TARGET_FIELD_ID}`

Set dates with: `gh project item-edit --project-id {PROJECT_ID} --id <item-id> --field-id <field-id> --date <YYYY-MM-DD>`

### GitHub API Usage

GitHub's REST API (5,000 req/hr) and GraphQL API (5,000 pts/hr) have **separate** rate limits with sliding windows.

**Prefer REST for everything it can do.** Reserve GraphQL for ProjectV2 board mutations (setting fields, dates, phases) which have no REST equivalent. Check budgets before bulk operations: `gh api rate_limit --jq '.resources.core'` (REST) and `gh api graphql -f query='{ rateLimit { remaining resetAt } }'` (GraphQL). If one is exhausted, fall back to the other where possible.

- **Use REST for reads**: listing issues (`gh api repos/.../issues`), fetching close dates, checking labels, viewing PRs. These are cheaper and don't consume GraphQL budget.
- **Use REST for issue mutations**: closing issues, adding labels, setting milestones, adding comments. All of these work via `gh api repos/.../issues/<number> -X PATCH`.
- **Reserve GraphQL for project board operations**: setting Phase, Size, Status, Start, Target fields on ProjectV2 items. These have no REST equivalent.
- **Read once, write in bulk.** Fetch the full project item list in a single `gh project item-list` call (with `--limit 200`). Cache the result locally (e.g., `/tmp/project_items.json`) and parse it in Python instead of making repeated API calls per issue.
- **Batch field updates with compound GraphQL mutations.** Instead of calling `gh project item-edit` in a loop (1 API call per field per item), compose a single GraphQL mutation that updates multiple items and fields at once:

  ```bash
  gh api graphql -f query='
    mutation {
      a1: updateProjectV2ItemFieldValue(input: {projectId: "PVT_...", itemId: "PVTI_a", fieldId: "PHASE_FIELD", value: {singleSelectOptionId: "opt_id"}}) { projectV2Item { id } }
      a2: updateProjectV2ItemFieldValue(input: {projectId: "PVT_...", itemId: "PVTI_a", fieldId: "SIZE_FIELD", value: {singleSelectOptionId: "opt_id"}}) { projectV2Item { id } }
      b1: updateProjectV2ItemFieldValue(input: {projectId: "PVT_...", itemId: "PVTI_b", fieldId: "DATE_FIELD", value: {date: "2026-03-15"}}) { projectV2Item { id } }
    }
  '
  ```

  Each aliased field (`a1`, `a2`, `b1`) is a separate mutation within one request. This costs 1 API call instead of N.

- **Cap batch size at ~30 mutations per request** to stay under GitHub's query complexity limits.
- **When cascading dates across a milestone**, compute all new dates locally in Python first, then apply them in one or two batched GraphQL mutations — not one CLI call per item.

### Label Management

**`in-progress` label:**

- Add the `in-progress` label to an issue when active development begins (in `/build-feature` Step 1 or `/build-api` Step 1).
- The label **stays on the issue** through code review (`/review-code`) and PR submission (`/submit-pr`) until the issue is closed. Do not remove it at any point in the workflow.
- The `in-progress` label is **automatically removed** by a GitHub Actions workflow (`.github/workflows/label-cleanup.yml`) when an issue is closed.
- A stale-detection workflow (`.github/workflows/stale-in-progress.yml`) comments on `in-progress` issues with no activity for 7 days.
- There should be at most one issue with the `in-progress` label at any time (single developer).
- When starting work on a new issue, check for and remove `in-progress` from any other issue first.

**`build-ready` label:**

- Applied selectively by `/plan-feature` to issues that are sufficiently planned and ready for `/build-feature`.
- Always applied to the source issue (it just completed planning). Applied to created child issues only if the agent judges them fully specified; broad child issues that need their own `/plan-feature` pass should not get this label.
- `/plan-feature` checks for this label on source issues and warns before re-running to prevent duplicate decision records and implementation issues.

**`feature-implementation` label:**

- Applied by `/plan-feature` to all created implementation issues (describes the issue type, not planning status).

### Pull Request CI Requirements

**After creating or pushing to a pull request, always monitor CI until it passes.** This is mandatory — never leave a PR with failing checks.

1. After `gh pr create` or `git push`, watch the CI run: `gh run watch <run-id> --exit-status`
2. If CI fails, fetch logs (`gh run view <run-id> --log-failed`), fix the issue, push, and watch again
3. Only report the PR as ready once all checks are green
4. Run `pnpm format:check` locally before pushing to catch Prettier issues early

## Security Audit Scope

Security audits (`/security-audit`) assess **application-level security only**. Production infrastructure — TLS termination, reverse proxy, network segmentation, firewall rules, and DNS — is managed by a separate project and is **out of scope** for this repository's security reviews.

Do not flag the following as findings:

- Missing TLS/HTTPS configuration
- No reverse proxy (Caddy, nginx, Traefik)
- Network-level MITM risks
- Missing production Dockerfiles or deployment topology
- HSTS effectiveness (depends on external TLS termination)

<!-- TODO: Adjust the deployment assumption below to match your production topology. -->
The application assumes it runs behind a TLS-terminating reverse proxy in production. All application-level security controls (HSTS headers, secure cookie flags, CORS, CSRF) are configured accordingly.

## Quality Standards

- No `any` types without justification
- All async operations must have error handling
- OWASP security guidelines, no secrets in code
- WCAG 2.1 AA compliance for UI
- Required tests: unit (logic), integration (APIs), E2E (critical flows)

### Scientific Citation Requirements

<!-- TODO: Replace {PROJECT_NAME} below and customize the scientific citation requirement to fit your domain. If your project is not science-based, remove or adapt this section. -->
{PROJECT_NAME}'s recommendation engine is grounded in domain science. **All formulas, thresholds, and biological models must cite their sources.** This applies to code, issues, decision records, and documentation.

<!-- TODO: Replace the citation triggers below with examples appropriate to your domain. If your project does not involve scientific models, remove or adapt this section. -->
**When to cite:**

- Domain-specific formulas and parameter selections
- Biological or scientific thresholds
- Model assumptions and data source decisions
- Any change to an existing formula or threshold

<!-- TODO: Update the canonical reference path below if your project uses a different structure for domain documentation. -->
**Canonical science reference:** All scientific models, formulas, thresholds, and data source documentation live in [`docs/science/`](docs/science/INDEX.md). Update the relevant file there whenever you modify a scientific constant or model.

**Where to put citations:**

| Context                        | Format                                                                                                                               |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Code** (constants, formulas) | Inline comment with URL or short reference (e.g., `// Source Institution — brief description — https://example.com/source`) <!-- TODO: Replace with a domain-appropriate example --> |
| **GitHub issues**              | `## References` section at the bottom with linked sources                                                                            |
| **Decision records**           | `## References` section (already required by template)                                                                               |
| **`docs/science/` files**      | Per-section `## References` with linked sources                                                                                      |
| **Other `docs/` files**        | Inline links or a References section, depending on density                                                                           |

<!-- TODO: Replace the citation format examples below with sources appropriate to your domain. -->
**Citation format:** Prefer authoritative and peer-reviewed sources. Include the institution, a brief description, and a URL:

```markdown
- [Institution — Description of source](https://example.com/source)
```

> [!IMPORTANT]
> When modifying an existing formula or threshold, the commit message and/or PR description must explain **why** the value changed and cite the source for the new value. Do not silently change scientific constants.

## REST API Standards

All API endpoints must conform to **Richardson Maturity Model Level 2** (proper HTTP method semantics, resource-oriented URIs, correct status codes). See [ADR 028](docs/decisions/028-rest-api-conventions.md) for full rationale including the HATEOAS opt-out decision. <!-- TODO: Update the ADR reference number/path if your project numbers decisions differently -->

**HTTP methods:**

| Method   | Use for                                                                                |
| -------- | -------------------------------------------------------------------------------------- |
| `GET`    | Read operations, lookups. Use query params for input. Never use POST for reads.        |
| `POST`   | Create a resource or trigger a non-idempotent action (side effects like sending email) |
| `PUT`    | Full resource replacement (idempotent). Prefer PATCH for partial updates.              |
| `PATCH`  | Partial resource update (state changes, field modifications)                           |
| `DELETE` | Remove or logically delete a resource                                                  |

**Naming rules:**

- Plural nouns for collections: `/invites`, `/subscriptions`, `/legal/acceptances`
- No verbs in URIs for CRUD operations. Let the HTTP method convey the action.
- Action endpoints (`POST /resource/:id/action`) are acceptable only when no CRUD mapping exists and the operation triggers side effects.

**Status codes:** Always use `@HttpCode()` decorator. Key codes: `200` (success with body), `201` (created), `204` (no content), `400` (validation), `401` (unauthenticated), `403` (forbidden), `404` (not found), `409` (conflict), `410` (gone/expired).

## User-Facing Content Style

Any text that end users will see (site copy, landing pages, blog posts, in-app UI text, notifications, help text, marketing pages, product descriptions, and GTM content) must not read like AI-generated output. This does not apply to internal documentation, code comments, issue bodies, PR descriptions, decision records, or commit messages.

### Punctuation

- **No em dashes** in user-facing copy. Do not use `—` or `—`. Use commas, parentheses, colons, or separate sentences instead. This is the single most recognized AI-writing tell.
- **No semicolons for loose joining.** If two clauses need connecting, use a period or a conjunction. Reserve semicolons for genuinely parallel constructions.

### Banned Words and Phrases

Never use these in user-facing content. They are heavily associated with AI-generated text.

**Filler verbs and adjectives:** delve, tapestry, landscape (metaphorical), leverage (as verb), foster, beacon, embark, spearhead, navigate (metaphorical), encompass, streamline, pivotal, multifaceted, nuanced (as filler), robust, seamless, cutting-edge, groundbreaking, transformative, revolutionize, game-changer, synergy, holistic, utilize

**Inflated phrases:** "it's important to note," "it's worth mentioning," "it bears noting," "no discussion would be complete without," "in today's [X] landscape," "at its core," "stands as a testament to," "rich tapestry of," "a symphony of," "serves as a beacon," "the ever-evolving," "a paradigm shift," "dive deep into," "shed light on," "pave the way for," "at the end of the day"

**Hollow transitions:** moreover, furthermore, additionally, in addition, on the other hand (prefer "but"), in conclusion, to summarize, in summary, it is worth noting that, interestingly

Replace with plain, direct language. Say what you mean in fewer words.

### Structural Patterns to Avoid

- **Rule of three.** Do not default to three-item lists, three adjectives, or three parallel phrases. Vary list lengths. Two items or four are fine. Three is acceptable when warranted, but not as a reflexive pattern.
- **Bolded keyword + restatement.** Do not write bullet points where a bold lead-in restates the sentence that follows (e.g., "**Scalable architecture**: The architecture is designed to scale..."). Either use the bold as a label for genuinely new information, or drop the bold.
- **Excessive boldface.** Bold is for labels and warnings. Do not bold phrases for emphasis in running prose. Use sentence structure to create emphasis.
- **Superficial -ing closers.** Do not end sentences with participial phrases that editorialize without adding information (e.g., "...ensuring reliability," "...highlighting the importance of," "...reflecting a commitment to"). Make the claim concrete or cut it.
- **Negative parallelism filler.** Do not use "It's not X, it's Y" as a rhetorical device unless genuinely correcting a misconception.
- **Promotional inflation.** Avoid travel-brochure adjectives ("stunning," "breathtaking," "must-see," "world-class"). Be specific about what makes something good instead of claiming it's good.
- **Weasel attribution.** Do not write "experts say," "industry leaders agree," "studies show" without a specific citation. Cite the source or drop the claim.

### What to Do Instead

- Write short, direct sentences. Prefer active voice.
- Use the simplest accurate word. "Use" not "utilize." "Start" not "embark." "Show" not "shed light on."
- Vary sentence length and structure. Mix short sentences with longer ones. Fragments are fine for emphasis.
- Be specific. Instead of "a seamless experience," describe what the user actually gets: "your lawn care schedule updates automatically when the weather changes."
- Read the output aloud. If it sounds like a LinkedIn post or a press release, rewrite it.

## Agent Collaboration Matrix

When multiple agents have overlapping focus areas, use this matrix to determine ownership and collaboration patterns.

| Change Type | Primary Owner | Reviews With | Escalates To |
| --- | --- | --- | --- |
| UI feature implementation | Frontend Specialist | Design Lead (design/brand), QA Lead (testing) | Principal Engineer |
| API endpoint or backend service | Backend Specialist | Security Engineer (auth/validation), Platform Engineer (infra) | Principal Engineer |
| Accessibility (specification) | Design Lead | Frontend Specialist (implementation feasibility) | - |
| Accessibility (implementation) | Frontend Specialist | Design Lead (spec compliance), QA Lead (testing) | - |
| Performance strategy | Performance Analyst | Frontend or Backend Specialist (implementation) | Principal Engineer |
| Frontend performance (bundles) | Frontend Specialist | Performance Analyst (optimization strategy) | - |
| Database schema or migration | Backend Specialist | Platform Engineer (rollback/deployment) | Principal Engineer |
| Infrastructure or CI/CD | Platform Engineer | Security Engineer (hardening) | Principal Engineer |
| User-facing content or copy | Content Reviewer | Design Lead (brand), Product Strategist (messaging) | - |
| API documentation | DevX Engineer | Backend Specialist (accuracy) | - |
| Security vulnerability | Security Engineer | Backend or Frontend Specialist (remediation) | Principal Engineer |
| Dependency updates or patches | Security Engineer (trigger) | Platform Engineer (execution), Backend/Frontend Specialist (testing) | - |
| Design system components | Design Lead (specification) | Frontend Specialist (implementation), QA Lead (testing) | - |

**General escalation rule**: When an agent identifies an issue with architectural implications (cross-cutting concern, new pattern, breaking change), escalate to Principal Engineer.

## Council Conflict Resolution

When council members disagree during an evaluation:

- **Block votes always surface to the user.** A Block vote halts progress until the user decides whether to override, modify scope, or accept the blocker. The checkpoint must present the block rationale prominently.
- **Concern votes are advisory.** Concerns are documented as recommendations. The user may accept, partially address, or defer them as technical debt.
- **No silent overrides.** A council member's vote cannot be overridden by another council member. Only the user can override a Block.
- **Lead role is facilitative, not authoritative.** The council lead synthesizes the discussion and presents the consensus summary, but does not have tiebreaker authority. Disagreements are resolved by the user.

## Agent & Tooling Changes

When changes are made to agent configuration, skills, councils, or Claude Code setup (files in `.claude/`, `AGENTS.md`, `.claude/skills/`, `.claude/councils/`, `.claude/agents/`), ask the user at the end whether they want to commit the changes on a new branch from `main` and create a PR. Use `chore/` branch prefix and conventional commit format.

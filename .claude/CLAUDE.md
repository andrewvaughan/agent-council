# Project Instructions

## Documentation Standards

**NEVER create non-standard markdown files in project root** (e.g., RUN.md, INSTALL.md, SETUP.md, QUICKSTART.md).

Allowed root markdown files: README.md, CONTRIBUTING.md, CHANGELOG.md, LICENSE

Where to put documentation:

- Project overview, setup, usage: README.md
- Contribution workflow: CONTRIBUTING.md
- Technical deep-dives: docs/ directory with descriptive names
- Decision records: .claude/councils/decisions/NNN-title.md

If content doesn't fit in README.md, create a file in docs/ and link from README.md.

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

## Tech Stack

Frontend: Vite + React 19, TypeScript 5.7+, Tailwind CSS + shadcn/ui
Backend: NestJS, Prisma + PostgreSQL, tRPC
Monorepo: pnpm + Turborepo
Testing: Vitest (frontend), Jest (backend)

## Infrastructure Philosophy

**Self-hosted, no paid SaaS.** This project targets a Docker-driven homelab deployment. All infrastructure choices must prioritize self-hostable, open-source solutions over paid cloud services.

- **Database**: Local PostgreSQL (Docker Compose for dev, containerized for prod). No hosted DB services (Neon, Supabase, PlanetScale, etc.)
- **Email**: Resend is the current exception — evaluate self-hosted alternatives (e.g., postal, mailcow) when volume justifies it
- **Hosting**: Docker containers on homelab infrastructure. No Vercel, Railway, Fly.io, or similar PaaS
- **Dev environment**: Docker Compose for all services (PostgreSQL, API, web). Match production topology locally
- **General rule**: If a paid SaaS is proposed, always present the self-hosted alternative first. Only use paid services when no viable self-hosted option exists and the cost is justified

## Documentation Requirements

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

### Pull Request CI Requirements

**After creating or pushing to a pull request, always monitor CI until it passes.** This is mandatory — never leave a PR with failing checks.

1. After `gh pr create` or `git push`, watch the CI run: `gh run watch <run-id> --exit-status`
2. If CI fails, fetch logs (`gh run view <run-id> --log-failed`), fix the issue, push, and watch again
3. Only report the PR as ready once all checks are green
4. Run `pnpm format:check` locally before pushing to catch Prettier issues early

## Quality Standards

- No `any` types without justification
- All async operations must have error handling
- OWASP security guidelines, no secrets in code
- WCAG 2.1 AA compliance for UI
- Required tests: unit (logic), integration (APIs), E2E (critical flows)

## Skills & Councils

Use workflow skills: /plan-feature, /build-feature, /build-api, /review-code, /submit-pr, /security-audit, /setup-design-system

See .claude/README.md for details.

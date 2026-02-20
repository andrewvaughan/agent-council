---
type: guide
description: How to adapt Agent Council skills, agents, and councils for your project.
---

# Customization Guide

Agent Council skills are designed to work with any tech stack and project structure. This guide explains how to configure your project, customize agent personas, and adjust council composition.

## Declaring Your Tech Stack

Implementation skills (`build-feature`, `build-api`) are technology-agnostic — they use phrases like "your project's ORM" and "your project's test runner" instead of naming specific tools. To tell skills what your project uses, add a `## Tech Stack` section to your project's `AGENTS.md`:

```markdown
## Tech Stack

- Frontend: React with TypeScript
- Backend: Express with TypeScript
- ORM: Prisma with PostgreSQL
- UI: Tailwind CSS + shadcn/ui
- Validation: Zod
- State: React Query for server state, Zustand for client state
- Test runner: Vitest
- E2E: Playwright
- Package manager: npm
```

When a skill reads "use your project's ORM to define the schema," it will check your tech stack and generate Prisma schema code. If you use Django with PostgreSQL instead, the same skill will generate Django models.

> [!IMPORTANT]
> If the tech stack is not defined, implementation skills will stop and ask you to provide it before proceeding. They will also suggest updating `AGENTS.md` when they introduce new technologies, so the definition stays current.

### What to Include

Include any technology choice that affects how code is written:

| Category | Examples |
|----------|----------|
| Frontend | React, Vue, Angular, Svelte, Next.js, Nuxt |
| Backend | Express, NestJS, Django, Rails, FastAPI, Spring |
| ORM / Database | Prisma, TypeORM, SQLAlchemy, Sequelize, raw SQL |
| UI library | Tailwind, Material UI, Chakra, shadcn/ui |
| Validation | Zod, Joi, Yup, class-validator |
| State management | React Query, Redux, Zustand, Pinia, Vuex |
| Test runner | Vitest, Jest, pytest, Mocha |
| E2E testing | Playwright, Cypress, Selenium |
| API style | REST, GraphQL, tRPC, gRPC |
| Package manager | npm, pnpm, yarn, bun |
| Container | Docker, Podman |
| CI/CD | GitHub Actions, GitLab CI, CircleCI |

### Tech Stack Updates

When a skill introduces or changes a technology during implementation (e.g., adding a new database, switching a library), it will present the proposed `AGENTS.md` update at a checkpoint for your approval. This ensures the tech stack definition stays accurate across features.

## Modifying Agent Personas

Agent definitions live in `canonical/agents/<agent-name>.md`. Each agent has:

- **Role description**: What perspective this agent brings
- **Focus areas**: Specific topics this agent evaluates
- **Complexity tiers**: Standard (routine work) and Advanced (critical decisions)
- **Model specification**: Which AI model to use for each tier

### Customizing an Existing Agent

To adjust an agent's focus for your domain, edit its definition in `canonical/agents/`. For example, if your project is a healthcare application, you might add HIPAA compliance to the Security Engineer's focus areas:

**Before**:

```markdown
## Focus Areas
- OWASP Top 10 vulnerabilities
- Authentication and authorization patterns
- Secrets management
- Input validation and sanitization
```

**After**:

```markdown
## Focus Areas
- OWASP Top 10 vulnerabilities
- Authentication and authorization patterns
- Secrets management
- Input validation and sanitization
- HIPAA compliance and PHI data handling
- Audit logging for regulatory requirements
```

After editing, run `scripts/build.sh` to regenerate the skill packages.

### Adding a New Agent

1. Create `canonical/agents/<agent-name>.md` following the format of existing agents
2. Add the agent to relevant councils in `canonical/councils/`
3. Update `scripts/skill-manifest.json` for any skills that should include this agent
4. Update the agent table in `AGENTS.md`
5. Run `scripts/build.sh` to regenerate

Example: Adding a **Database Administrator** agent for a data-heavy project:

```markdown
---
name: Database Administrator
role: Database design and optimization specialist
---

# Database Administrator

## Role
Evaluates database design decisions, query performance, migration safety,
and data integrity from a DBA perspective.

## Focus Areas
- Schema design and normalization
- Query performance and indexing strategy
- Migration safety and rollback plans
- Data integrity constraints
- Backup and recovery
- Connection pooling and resource management

## Model

- **Standard**: Sonnet — routine schema reviews, index suggestions
- **Advanced**: Opus — major schema redesigns, migration strategies for large datasets
```

## Adjusting Council Composition

Council templates live in `canonical/councils/<council-name>.md`. Each council defines its members, evaluation criteria, and voting format.

### Adding a Member to a Council

To add your new Database Administrator to the Architecture Council:

1. Edit `canonical/councils/architecture-council.md` to include the new member
2. Update `scripts/skill-manifest.json` to include the agent in skills that use this council
3. Run `scripts/build.sh` to regenerate

### Removing a Member from a Council

If your project doesn't have a frontend, you might remove the Frontend Specialist from the Feature Council:

1. Edit `canonical/councils/feature-council.md` to remove the member
2. Update `scripts/skill-manifest.json` to remove the agent from skills that only used it through this council
3. Run `scripts/build.sh` to regenerate

### Creating a New Council

1. Create `canonical/councils/<council-name>.md` following the existing format:

   ```markdown
   ---
   name: <Council Name>
   description: One-line purpose
   ---

   # <Council Name>

   ## Members
   - Agent Name (Lead) — what they evaluate
   - Agent Name — what they evaluate

   ## Evaluation Criteria
   - Criterion 1
   - Criterion 2

   ## Voting Format
   Each member votes: **Approve** / **Concern** / **Block**
   - Approve: No issues found
   - Concern: Issues found but not blocking
   - Block: Critical issues that must be resolved
   ```

2. Reference the council from any skills that should activate it
3. Update `scripts/skill-manifest.json`
4. Run `scripts/build.sh` to regenerate

## Customizing Skill Workflows

Skill workflows live in `canonical/skills/<skill-name>/SKILL.md`. You can modify any step, add checkpoints, or adjust the workflow to match your team's process. For a detailed breakdown of what each skill does and what it produces, see the [Skills Reference](SKILLS-REFERENCE.md).

### Common Customizations

**Adjust checkpoint frequency**: If your team prefers fewer interruptions, remove intermediate checkpoints. If you want more oversight, add checkpoints before significant actions.

**Change commit conventions**: If your team uses a different commit format (e.g., Jira ticket references), update the commit step in each skill:

~~~markdown
## Step 8: Commit

Commit with your project's commit format:

```
PROJ-123: implement <feature-name>
```
~~~

**Add team-specific steps**: Insert steps for your team's workflow. For example, adding a design review step to `build-feature`:

~~~markdown
### Step 4.5: Design Review

If UI components were created, share screenshots or a Storybook link
with the design team for feedback before proceeding to testing.

### CHECKPOINT: Present the design review feedback. Wait for approval.
~~~

### After Customizing

Always run `scripts/build.sh` after editing anything in `canonical/` to regenerate the self-contained skill packages in `skills/`. Then run `scripts/build.sh --check` to verify no drift.

> [!IMPORTANT]
> Never edit files in `skills/` directly — they are overwritten by the build. Always edit sources in `canonical/`.

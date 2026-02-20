---
type: guide
description: How to contribute skills, agents, and councils to the Agent Council package.
---

# Contributing

Thank you for your interest in contributing! This project provides AI coding agent workflows — skills, councils, and agent personas — distributed via [skills.sh](https://skills.sh).

## What You Can Contribute

- **Skills**: New workflow definitions (e.g., a `deploy` skill, a `migrate-db` skill)
- **Agents**: New agent personas or improvements to existing ones
- **Councils**: New council configurations or membership changes
- **Documentation**: Improvements to AGENTS.md, README.md, or skill instructions
- **Bug fixes**: Corrections to skill workflows, build scripts, or CI

## Project Structure

```
canonical/              Source of truth for all content
  skills/               Skill workflow sources (SKILL.md per skill)
  agents/               11 agent persona definitions
  councils/             5 council templates
  templates/            Shared templates (decision records, etc.)

skills/                 GENERATED — do not edit directly
  <skill-name>/         Self-contained skill package
    SKILL.md            Workflow definition
    agents/             Bundled agent definitions
    councils/           Bundled council templates

scripts/
  build.sh              Generates skills/ from canonical + sources
  skill-manifest.json   Maps skills to required agents and councils
```

> [!IMPORTANT]
> Never edit files in `skills/` directly. The `.claude/skills/` entries are symlinks to `skills/`, so editing through them also modifies generated files. Always edit the sources in `canonical/`, then run `scripts/build.sh` to regenerate.

## Adding a New Skill

1. Create the skill workflow at `canonical/skills/<skill-name>/SKILL.md` with required frontmatter:

   ```yaml
   ---
   name: <skill-name>
   description: One-line description of what this skill does.
   ---
   ```

2. Write the workflow as structured markdown with numbered steps, checkpoints, and a hand-off section

3. Add the skill to `scripts/skill-manifest.json` with its required agents and councils:

   ```json
   {
     "<skill-name>": {
       "agents": ["principal-engineer", "security-engineer"],
       "councils": ["review-council"]
     }
   }
   ```

4. Run `scripts/build.sh` to generate the self-contained `skills/<skill-name>/` directory

5. Run `scripts/build.sh --check` to verify no drift between sources and generated output

### Skill Design Principles

- **Technology-agnostic**: No framework or tool names (say "your test runner" not a specific tool name)
- **Checkpoint-driven**: Include `### CHECKPOINT` sections where the user must approve before continuing
- **Scope-bounded**: Each skill owns one phase — include a `> [!CAUTION]` block stating what the skill does NOT do
- **Hand-off aware**: End with a "Hand Off — STOP Here" section suggesting the next skill

## Adding or Modifying an Agent

Agent definitions live in `canonical/agents/<agent-name>.md`. Each agent has:

- **Role description**: What perspective this agent brings
- **Focus areas**: Specific topics this agent evaluates
- **Complexity tiers**: Standard (routine) and Advanced (critical decisions)

To add a new agent:

1. Create `canonical/agents/<agent-name>.md` following the format of existing agents
2. Add the agent to relevant councils in `canonical/councils/`
3. Update `scripts/skill-manifest.json` for any skills that should include this agent
4. Update the agent table in `AGENTS.md` and the summary in `README.md`
5. Run `scripts/build.sh` to regenerate

## Adding or Modifying a Council

Council templates live in `canonical/councils/<council-name>.md`. Each council defines:

- **Members**: Which agents participate
- **Evaluation criteria**: What the council assesses
- **Voting format**: Approve / Concern / Block with rationale

To add a new council:

1. Create `canonical/councils/<council-name>.md` following existing council format
2. Reference the council from any skills that should activate it
3. Update `scripts/skill-manifest.json` for skills using this council
4. Update the council table in `AGENTS.md` and the summary in `README.md`
5. Run `scripts/build.sh` to regenerate

## Quick Start

1. Fork and clone the repository
2. Edit sources in `canonical/` (skills, agents, councils, or templates)
3. Run `scripts/build.sh` to regenerate `skills/`
4. Run `scripts/build.sh --check` to verify no drift
5. Commit both `canonical/` and `skills/` changes, push, and open a PR

## Development Workflow

We follow trunk-based development: `main` is always releasable, all changes via pull requests.

### Branch Naming

- `feature/` — New skills, agents, councils, or enhancements
- `fix/` — Bug fixes to existing workflows
- `docs/` — Documentation updates
- `refactor/` — Structural changes without behavior change
- `chore/` — Build scripts, CI, maintenance

### Commit Messages

[Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <subject>
```

Types: `feat`, `fix`, `docs`, `refactor`, `chore`, `ci`, `test`

Scopes: `skills`, `agents`, `councils`, `build`, `ci`, `docs`, or a specific skill name

Examples:

```
feat(skills): add deploy skill workflow
fix(agents): correct security-engineer focus areas
docs(councils): clarify architecture council activation criteria
chore(build): update build script for new manifest format
```

### Pull Request Process

1. Create a branch from `main`
2. Make your changes to sources (not generated `skills/` directory)
3. Run `scripts/build.sh` to regenerate
4. Run `scripts/build.sh --check` to verify no drift
5. Push and open a pull request targeting `main`

PR requirements:

- CI checks pass (skill format, self-containment, leakage scan, broken links)
- No tech-stack terms in skill workflows (checked by CI leakage scan)
- No personal paths in committed files (checked by CI community safety scan)
- Generated `skills/` matches sources (checked by CI build drift)

### Merge Strategy

Squash and merge (default). Keep PRs under 400 lines when possible.

## CI Checks

The CI pipeline validates:

| Check | What it verifies |
|-------|-----------------|
| Skill Format | SKILL.md frontmatter has `name` and `description`, name matches directory |
| Self-Containment | Every skill has bundled agents/ and councils/ |
| Leakage Scan | No technology-specific terms in SKILL.md files |
| Community Safety | No personal paths, no local settings tracked |
| Broken Links | All relative markdown links resolve to existing files |
| Markdown Lint | Frontmatter present, no trailing whitespace, no excessive blank lines |

## Getting Help

- **Questions**: Open a [GitHub Discussion](https://github.com/andrewvaughan/agent-council/discussions)
- **Bugs**: Open an [issue](https://github.com/andrewvaughan/agent-council/issues) with reproduction steps
- **Security**: See [SECURITY.md](SECURITY.md) for vulnerability reporting

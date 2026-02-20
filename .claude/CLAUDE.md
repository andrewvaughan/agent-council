# Claude Code Instructions

@AGENTS.md

## Model Mapping

Agent complexity tiers map to Claude models:

- **Standard** → Sonnet (claude-sonnet-4-6) — routine work, most tasks
- **Advanced** → Opus (claude-opus-4-6) — foundational architecture, major features, critical security
- **Fast** → Haiku (claude-haiku-4-5-20251001) — routine checks, simple formatting

Use Standard by default. Escalate to Advanced only for decisions with broad or lasting impact.

## Claude Code Behavior

- Use **Task subagents** to run council members in parallel when a council is activated
- Invoke skills via **slash commands**: `/plan-feature`, `/build-feature`, `/build-api`, `/review-code`, `/submit-pr`, `/security-audit`
- After `gh pr create` or `git push`, always **monitor CI**: `gh run watch <run-id> --exit-status`
- If CI fails, fetch logs (`gh run view <run-id> --log-failed`), fix, push, and re-watch

## Plugin Enhancements

If [wshobson/agents](https://github.com/wshobson/agents) plugins are installed, skills can delegate to specialized plugins for enhanced results. Skills include conditional notes like:

> **Claude Code optimization**: If the `/plugin:skill` is available, use it for enhanced results.

Key plugins that enhance the experience:

- `security-scanning` — SAST, hardening, STRIDE, attack trees
- `ui-design` — accessibility audits, component creation, design review
- `backend-development` — API design, architecture patterns
- `frontend-mobile-development` — state management, design systems
- `documentation-generation` — ADRs, changelogs, OpenAPI specs
- `database-design` / `database-migrations` — schema design, migration strategies

## Markdown Rendering

Claude Code renders GitHub Flavored Markdown. Use these features in documentation and decision records:

- **GitHub alerts**: `> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]`
- **Mermaid diagrams**: Fenced code blocks with `mermaid` language tag
- **Collapsible sections**: `<details>` / `<summary>` for lengthy content
- **Tables**: For structured data with 3+ columns

Formatting rules:

- Never place consecutive bold-label lines without a blank line or list syntax between them
- Use bullet points for structured metadata and key-value blocks
- Use blank lines between paragraphs, after headings, and before/after lists

## Documentation Standards

Allowed root markdown files: README.md, CONTRIBUTING.md, CHANGELOG.md, LICENSE, AGENTS.md, CODE_OF_CONDUCT.md, SECURITY.md

All project documentation files must include YAML frontmatter:

```yaml
---
type: guide | overview | reference
description: one-line summary
---
```

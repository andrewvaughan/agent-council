# Claude Code — {PROJECT_NAME} <!-- TODO: Replace {PROJECT_NAME} with your project name -->

@AGENTS.md

## Skills & Councils

The development workflow described in `AGENTS.md` is implemented via Claude Code skills in `.claude/skills/`. Invoke skills with `/skill-name` syntax.

| Skill                  | Purpose                         |
| ---------------------- | ------------------------------- |
| `/plan-feature`        | Feature planning pipeline       |
| `/build-feature`       | Full-stack implementation       |
| `/build-api`           | Backend-only implementation     |
| `/review-code`         | Multi-perspective code review   |
| `/submit-pr`           | PR creation and CI monitoring   |
| `/hotfix`              | Urgent fix (streamlined pipeline) |
| `/gtm-review`          | Go-to-Market & launch readiness |
| `/security-audit`      | Security audit (standalone)     |
| `/setup-design-system` | Design system work (standalone) |

See `.claude/README.md` for the full reference on councils, agents, skill workflows, and model selection.

## Checkpoints

Whenever a skill workflow reaches a `### CHECKPOINT` step or otherwise instructs you to "wait for user approval," "ask the user," or "wait for confirmation," you **must** use the `AskUserQuestion` tool instead of plain chat text. This ensures the user receives an interactive notification and can respond directly. Present the relevant context in the question description, and offer clear options (e.g., "Approve," "Request changes," "Skip").

## JSON Files

Do not use `//` or `//key` comment conventions in JSON files (e.g., `package.json`). Rely on commit messages and GitHub issues for documentation context instead.

## User-Facing Content Style

All user-facing text (site copy, blog posts, in-app UI text, marketing pages, GTM content) must follow the writing style rules in the `AGENTS.md` "User-Facing Content Style" section. Key rules: no em dashes, no AI-slop vocabulary (delve, tapestry, landscape, leverage, seamless, etc.), no hollow transitions (moreover, furthermore, additionally), no rule-of-three defaults, no promotional inflation. This does not apply to internal docs, code, issues, or PRs.

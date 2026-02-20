---
name: build-feature
description: Implement a full-stack feature following an approved plan. Builds database layer, backend API, frontend components, and tests. Use after plan-feature has produced an approved implementation plan, or when you have a clear set of tasks to implement across the stack.
metadata:
  internal: true
---

# Full-Stack Feature Implementation Workflow

> [!WARNING]
> **Phase 2 skill — not yet genericized.** This skill retains tech-stack-specific references and is hidden from skills.sh discovery. It will be transformed to a stack-agnostic format in a future release.

Execute a full-stack feature implementation across database, backend, frontend, and testing layers. This skill follows the implementation plan produced by `/plan-feature` and builds all layers with integrated testing.

> [!CAUTION]
> **Scope boundary**: This skill implements code and commits it. It does **NOT** create pull requests, push to remote, run code reviews, or submit anything for merge. When implementation and commits are complete, **stop** and suggest the user run `/review-code` next. Do not proceed to PR creation — that is `/submit-pr`'s job.

See the full workflow in `.claude/skills/build-feature/SKILL.md`.

# Councils of Agents

> Multi-perspective decision-making using specialized AI agents

## Quick Start

Open Claude Code in VS Code sidebar and ask:

```
I need to activate the Architecture Council to evaluate:

Should we use tRPC or REST for our API layer?

Context: TypeScript monorepo with React + NestJS

Please use the decision template from .claude/councils/architecture-council.md
```

## What Are Councils?

**Councils** = Groups of AI agents that evaluate decisions from multiple perspectives.

**Example:** Architecture Council evaluates tech decisions from:
- 🏗️ Principal Engineer (scalability, architecture)
- ⚙️ Platform Engineer (deployment, operations)
- 🔒 Security Engineer (security, compliance)
- 💾 Backend Specialist (API, database design)

## 5 Councils

| Council | When to Use |
|---------|-------------|
| [Architecture](./councils/architecture-council.md) | Tech stack, DB schema, APIs |
| [Feature](./councils/feature-council.md) | New features, refactoring |
| [Review](./councils/review-council.md) | Code review, security |
| [Deployment](./councils/deployment-council.md) | Production releases |
| [Product](./councils/product-council.md) | Strategy, design, roadmap |

## How to Activate

### 1. Open Claude Code
- Click Claude icon in VS Code sidebar

### 2. Use This Pattern

```
I need to activate the [COUNCIL NAME] to evaluate:

[YOUR QUESTION]

Context: [2-3 sentences]

Please use the decision template from .claude/councils/[council-name].md
```

### 3. Document Decision

1. Review each agent's vote and rationale
2. Create `.claude/councils/decisions/NNN-title.md`
3. Use template from [001-example](./councils/decisions/001-example-architecture-decision.md)

## Example

```
I need to activate the Architecture Council to evaluate:

Should we use PostgreSQL or MongoDB?

Context: TypeScript monorepo with React + NestJS. We'll store
user accounts, blog posts, and user-generated content.

Please use the decision template from .claude/councils/architecture-council.md
```

## When to Use Councils

- **Architecture Council** - Choosing tech, DB schema, APIs, monorepo structure
- **Feature Council** - Planning features, major refactoring
- **Review Council** - Before commits, PR reviews, security changes
- **Deployment Council** - Before production, infrastructure changes
- **Product Council** - Product vision, feature prioritization, design, budget

## Best Practices

1. **Activate early** - Before implementation, not after
2. **Provide context** - 2-3 sentences about your situation
3. **Use templates** - Reference council decision templates
4. **Document decisions** - Create files in `councils/decisions/`
5. **Implement action items** - Follow through on recommendations

## Need Help?

- **Council templates**: See `councils/*.md`
- **Decision examples**: See `councils/decisions/*.md`
- **Agent personas**: See `agents/*.md`

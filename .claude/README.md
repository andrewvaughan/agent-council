# Lawnsignal Councils of Agents

## Overview
This repository uses a **councils of agents** pattern where specialized AI agents evaluate decisions from multiple perspectives before implementation.

## Agents
We have 11 specialized agents (see `agents/` directory):

**Technical Agents:**
1. **Principal Engineer** - Architecture and scalability
2. **Platform Engineer** - Infrastructure and deployment
3. **Security Engineer** - Security and compliance
4. **Frontend Specialist** - React/Vite/UX
5. **Backend Specialist** - NestJS/Prisma/API
6. **QA Lead** - Testing and quality
7. **DevX Engineer** - Documentation and tooling

**Product, Delivery & Business Agents:**
8. **Design Lead** - UI/UX design and brand
9. **Product Strategist** - Product vision, market research, and GTM strategy
10. **Lean Delivery Lead** - Rapid iteration, feature flags, and shipping speed
11. **Business Operations Lead** - Budget and costs

## Councils
Agents are organized into 5 councils (see `councils/` directory):
1. **Architecture Council** - Tech stack and infrastructure decisions
2. **Feature Council** - Feature planning with product/design input
3. **Review Council** - Code review before commits
4. **Deployment Council** - Production readiness validation
5. **Product Council** - Product strategy, design, and budget

## When to Use Councils

### Architecture Council
- Choosing technologies (frameworks, databases, libraries)
- Database schema changes
- API contract definitions
- Monorepo structure changes

### Feature Council
- Planning new features (before coding)
- Major refactoring decisions
- Cross-stack features

### Review Council
- Before every commit (automated via git hooks)
- Pull request reviews
- Security-sensitive changes

### Deployment Council
- Before production deployments
- Infrastructure changes
- Database migrations

### Product Council
- Product vision and GTM strategy
- Feature prioritization and roadmap
- Design system decisions
- Budget allocation

## How to Activate a Council

### Step-by-Step Guide

1. **Identify the Decision Type**
   - **Architecture Council**: Tech stack, database schema, API contracts, monorepo structure
   - **Feature Council**: New features, major refactoring, cross-stack work
   - **Review Council**: Code review before commits, security-sensitive changes
   - **Deployment Council**: Production readiness, infrastructure changes
   - **Product Council**: Product strategy, design, budget, feature prioritization

2. **Read the Council Definition**
   - Open `councils/[council-name].md` to see:
     - Council members and their roles
     - Decision template
     - Consensus rules

3. **Activate the Council with Claude Code**

   In your Claude Code conversation:
   ```
   I need to consult the Architecture Council on a decision:

   Should we use PostgreSQL or MongoDB for the database?

   Please have each council member (Principal Engineer, Platform Engineer,
   Security Engineer, Backend Specialist) evaluate this using the decision
   template in .claude/councils/architecture-council.md
   ```

4. **Review Agent Responses**
   - Each agent will provide: Vote + Rationale + Recommendations
   - Look for consensus (all Approve/Concern) or blocks (fundamental issues)

5. **Document the Decision**
   - Create a file in `.claude/councils/decisions/` (e.g., `002-database-choice.md`)
   - Include: Question, each agent's response, final decision, action items
   - Date the decision for future reference

6. **Implement Action Items**
   - Address any concerns raised by agents
   - Follow through on recommendations
   - Update documentation as needed

### Example: Architecture Decision

**Question:** "Should we use PostgreSQL or MongoDB?"

**Activate:** Architecture Council (Principal, Platform, Security, Backend)

**In Claude Code:**
```
Please activate the Architecture Council to evaluate:

Should we use PostgreSQL (relational) or MongoDB (document)
for the Lawnsignal database?

Context: We need to store user accounts, email signups, and
will later add blog content and user-generated data.

Have each council member (Principal Engineer, Platform Engineer,
Security Engineer, Backend Specialist) respond using the
architecture-council.md decision template.
```

**Council Responds with:**
- Vote (Approve PostgreSQL / Approve MongoDB / Concern / Block)
- Rationale (2-3 sentences on their perspective)
- Recommendations (specific concerns or improvements)

**Result:** Documented decision with multi-perspective analysis, consensus, and action items

**Document in:** `.claude/councils/decisions/002-database-choice.md`

## Workflow Templates

See `workflows/` directory for common development workflows:
- `feature-development.md` - End-to-end feature workflow
- More to be added as patterns emerge

## Best Practices

1. **Always consult councils** before major decisions
2. **Document all council decisions** in `councils/decisions/`
3. **Follow the decision templates** for consistency
4. **Don't skip councils** to move faster - they prevent costly mistakes
5. **Update agent personas** as we learn what works

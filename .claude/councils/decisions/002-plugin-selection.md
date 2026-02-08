# Decision 002: wshobson/agents Plugin Selection

**Date**: 2024-02-07
**Council**: Review Council
**Status**: Approved

## Question

Which wshobson/agents plugins should we add to our workspace?

## Context

Evaluating 15 candidate plugins for addition to our workspace. We already have 10 plugins installed from claude-code-workflows marketplace. Goal: Avoid duplication, minimize token usage, maximize value for our TypeScript/React/NestJS stack.

## Council Votes

### Security Engineer

- **Vote**: ⚠️ **Concern** (with recommendations)
- **Rationale**: Several plugins are critical for security posture (scanning, API security) while others duplicate existing functionality. Must avoid context bloat.
- **Recommendations**:
  - **MUST ADD**: security-scanning, backend-api-security, javascript-typescript, accessibility-compliance
  - **SHOULD ADD**: database-migrations, frontend-mobile-security, api-testing-observability
  - **DO NOT ADD**: All SEO plugins (premature), developer-essentials (vague), ui-design (overlaps), dependency-management (already have)

### QA Lead

- **Vote**: ✅ **Approve** (with Security Engineer's recommendations)
- **Rationale**: Testing and quality perspective aligns with Security. Focus on plugins that integrate with Jest/Vitest and provide actionable insights.
- **Recommendations**:
  - Critical: api-testing-observability, accessibility-compliance, javascript-typescript
  - Avoid plugin bloat: Install only 7-8 most critical now, add others as specific needs arise

### DevX Engineer

- **Vote**: ✅ **Approve** (with focus on developer experience)
- **Rationale**: Developers need immediate productivity wins without overwhelming choices. Documentation is already messy, don't add more complexity.
- **Recommendations**:
  - Developer productivity: javascript-typescript, accessibility-compliance, security-scanning
  - Quality of life: backend-api-security, api-testing-observability
  - Major concern: Consolidate documentation before adding more plugins

## Decision

- **Status**: ✅ **Approved**
- **Final Selection**: Install 9 plugins from wshobson/agents marketplace

## Consensus

All council members agree on core set of high-value plugins while avoiding duplication and bloat.

## Approved Plugins (9 total)

### Essential (3 plugins)
1. ✅ `javascript-typescript` - Core language expertise
2. ✅ `cloud-infrastructure` - AWS/Docker/K8s architecture
3. ✅ `incident-response` - Production incident management

### Security & Quality (4 plugins)
4. ✅ `security-scanning` - Vulnerability scanning
5. ✅ `backend-api-security` - NestJS security patterns
6. ✅ `frontend-mobile-security` - React security patterns
7. ✅ `accessibility-compliance` - A11y testing

### Testing & Database (2 plugins)
8. ✅ `api-testing-observability` - API testing and monitoring
9. ✅ `database-migrations` - Prisma migration safety

## Rejected Plugins (16 total)

**Duplicates:**
- ❌ `dependency-management` - Already installed
- ❌ `documentation-generation` - Already installed

**Overlaps with existing:**
- ❌ `developer-essentials` - Vague, likely duplicate
- ❌ `ui-design` - Overlaps with frontend-mobile-development
- ❌ `error-debugging` - debugging-toolkit covers this
- ❌ `code-refactoring` - Covered by existing plugins
- ❌ `database-design` - backend-development covers this
- ❌ `api-scaffolding` - NestJS CLI is better

**Not needed yet (premature):**
- ❌ `seo-content-creation`
- ❌ `seo-technical-optimization`
- ❌ `seo-analysis-monitoring`
- ❌ `performance-testing-review`
- ❌ `application-performance`

**Unnecessary overhead:**
- ❌ `agent-orchestration` - Have council pattern
- ❌ `context-management` - Creates overhead
- ❌ `deployment-strategies` - Not needed yet

**Under evaluation:**
- ⚠️ `comprehensive-review` - Check if adds value beyond code-review-ai
- ⚠️ `cicd-automation` - Assess overlap with git-pr-workflows

## Action Items

- [x] Document Review Council decision
- [x] Update README.md with complete plugin list (19 total)
- [x] Update .claude/README.md with simplified council guide
- [x] Remove redundant documentation files (SETUP.md, ONBOARDING.md, COUNCIL_ACTIVATION.md)
- [x] Create VS Code-first setup instructions
- [ ] Install approved 9 plugins from wshobson/agents marketplace
- [ ] Verify total of 19 plugins installed

## Follow-up

- Re-evaluate `comprehensive-review` and `cicd-automation` after initial development
- Add SEO plugins when product is ready for launch
- Add `performance-testing-review` when we establish baseline metrics

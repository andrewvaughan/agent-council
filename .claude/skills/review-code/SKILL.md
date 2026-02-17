---
name: review-code
description: Run a comprehensive multi-perspective code review on current changes. Activates the Review Council (security, quality, documentation, domain review) and runs automated security scanning. Use before creating a pull request or when you want a thorough review of your work.
user-invocable: true
---

# Code Review Workflow

Run a comprehensive, multi-perspective code review on the current branch changes. This skill activates the Review Council and integrates automated security scanning to catch issues before they reach a pull request.

> [!CAUTION]
> **Scope boundary**: This skill reviews code and commits fixes. It does **NOT** create pull requests, push to remote, or merge anything. When the review is complete, **stop** and suggest the user run `/submit-pr` next. Do not proceed to PR creation — that is `/submit-pr`'s job.

## Step 1: Analyze Current Changes

Identify all changes on the current branch:

1. Run `git diff origin/main...HEAD` to see all changes relative to main
2. Run `git diff` and `git diff --cached` to catch any uncommitted work
3. Run `git status` to see modified, added, and deleted files

Categorize changed files into:

- **Frontend**: `apps/web/**`, `packages/ui/**`
- **Backend**: `apps/api/**`
- **Database**: `prisma/**`, `**/migrations/**`
- **Configuration**: `*.config.*`, `docker*`, `*.yml`, `*.json`
- **Documentation**: `*.md`, `docs/**`
- **Tests**: `**/*.test.*`, `**/*.spec.*`

Present a summary of changed files by category to the user.

## Step 2: Run Formatting and Lint Checks

Run formatting and lint checks before the council review to catch mechanical issues early:

```bash
pnpm format:check
pnpm lint
```

If `format:check` fails, fix it immediately by running `pnpm exec prettier --write` on the reported files and stage the changes. Do not include formatting issues in the council review — just fix them.

## Step 3: Run Automated Security Scanning

Invoke `/security-scanning:security-sast` on all changed files.

If backend files are changed, also invoke `/security-scanning:security-hardening` with focus on:

- Input validation completeness
- Authentication and authorization checks
- SQL injection and injection vulnerabilities
- Secret exposure in code
- Error information leakage

Collect all findings with severity levels (Critical, High, Medium, Low, Info).

## Step 4: Run Accessibility Audit (if frontend changes)

If any frontend files (React components, CSS, HTML templates) are in the changeset:

Invoke `/ui-design:accessibility-audit` to check WCAG compliance on modified components.

Focus on:

- Color contrast ratios
- Keyboard navigation
- ARIA attributes and screen reader support
- Focus management
- Semantic HTML usage

## Step 5: Activate the Review Council

Read the Review Council template from `.claude/councils/review-council.md` and conduct the full council review.

> **Model Selection**: For each council member, read their agent definition from `.claude/agents/<agent-name>.md` and use the model specified in their `## Model` section when spawning Task subagents. Match the context (routine vs. critical) to select the appropriate model when an agent lists multiple options.

### Security Engineer (Lead) — consult: security-scanning

- Review all SAST findings from Step 3
- Check for OWASP Top 10 vulnerabilities in the changed code
- Validate input sanitization on any new endpoints or forms
- Check secrets management (no hardcoded credentials, API keys, tokens)
- Verify authentication and authorization logic
- **Vote**: Approve / Concern / Block
- **Findings**: List each issue with severity and file location
- **Recommendations**: Specific fixes for each finding

### QA Lead

- Assess test coverage for changed files
- Check if new functionality has corresponding tests
- Identify untested edge cases and boundary conditions
- Verify error scenarios are tested
- Check if test coverage meets the >80% target
- **Vote**: Approve / Concern / Block
- **Findings**: Missing tests, coverage gaps, untested scenarios
- **Recommendations**: Specific tests to add

### DevX Engineer

- Check if documentation is updated for user-facing changes
- Review code readability and clarity of complex logic
- Verify README/docs reflect any new features or changes
- Check that public APIs have proper JSDoc/TSDoc
- **Vote**: Approve / Concern / Block
- **Findings**: Documentation gaps, unclear code sections
- **Recommendations**: Documentation and clarity improvements

### Domain Specialist

Select the appropriate specialist based on changed files:

- **Frontend Specialist** if frontend files changed
- **Backend Specialist** if backend files changed
- **Both** if changes span frontend and backend

Review domain-specific best practices:

- Component patterns, hooks usage, state management (frontend)
- NestJS patterns, service architecture, API design (backend)
- Prisma schema design, query optimization (database)
- **Vote**: Approve / Concern / Block
- **Findings**: Pattern violations, anti-patterns, performance concerns
- **Recommendations**: Specific improvements

## Step 6: Present Consolidated Review Report

Present the full review report organized by severity:

### Critical / Blocking Issues

Issues that must be fixed before merge (any Block vote or Critical SAST finding).

### High Priority Issues

Issues strongly recommended to fix (High SAST findings, Concern votes with security implications).

### Medium Priority Issues

Issues worth fixing but not blocking (Medium SAST findings, code quality concerns).

### Low Priority / Suggestions

Nice-to-have improvements (Low findings, style suggestions, minor documentation gaps).

### Review Decision Summary

- **Overall Status**: Approved / Needs Changes / Blocked
- **Council Votes**: Summary of each member's vote
- **Action Items**: Prioritized list of what to fix

### CHECKPOINT: Present all findings to the user. Ask which items they want to address now. Wait for instructions before proceeding.

## Step 7: Apply Fixes

For each item the user approves for fixing:

1. Apply the fix
2. Re-run the relevant check (lint, test, type-check, or SAST scan) to verify the fix
3. Stage the changes

If the user asks to skip certain findings, note them as accepted risks.

### CHECKPOINT: Present the applied fixes to the user. Confirm all changes look correct before committing.

## Step 8: Commit and Next Steps

If the user approves:

1. Stage all changes
2. Commit with an appropriate conventional commit message (e.g., `fix(security): address SAST findings` or `refactor: address code review feedback`)

Suggest the next step — then **stop**:

- If ready for PR: "Run `/submit-pr` to create a pull request"
- If more work needed: "Continue implementation, then run `/review-code` again when ready"

**Do not push the branch, create a PR, or invoke `/submit-pr` from within this skill.**

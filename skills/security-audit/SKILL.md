---
name: security-audit
description: Run a comprehensive security audit combining automated SAST scanning, STRIDE threat modeling, and attack tree analysis. Use before major releases, after security-sensitive changes, or on a regular cadence. Can audit the full codebase or specific directories.
---

# Security Audit Workflow

Run a comprehensive security audit that combines automated static analysis, threat modeling, and multi-perspective council review. This skill produces a prioritized audit report with actionable remediation steps.

> [!CAUTION]
> **Scope boundary**: This skill audits code and optionally remediates findings. It does **NOT** create pull requests, push to remote, or merge anything. When the audit is complete, **stop** and suggest the appropriate next step (see Step 9).

> [!WARNING]
> **Checkpoint protocol.** When this workflow reaches a `### CHECKPOINT`, you **must** actively prompt the user for a decision — do not simply present information and continue. Use your agent's interactive prompting mechanism (e.g., `AskUserQuestion` in Claude Code) to require an explicit response before proceeding. This prevents queued or in-flight messages from being misinterpreted as approval. If your agent lacks interactive prompting, output the checkpoint content and **stop all work** until the user explicitly responds.

## Step 1: Define Audit Scope

Ask the user:

- **Scope**: Full codebase or specific area? (e.g., `src/auth/`, `src/api/`)
- **Trigger**: What prompted this audit? (routine, pre-release, security incident, new feature, dependency update)
- **Focus areas**: Authentication, API security, data protection, infrastructure, frontend security, or all?

### CHECKPOINT: Confirm the audit scope and focus areas with the user before proceeding.

## Step 2: Automated SAST Scanning

Perform static application security testing on the defined scope. Scan for:

- **Injection**: SQL injection, NoSQL injection, command injection, LDAP injection
- **XSS**: Reflected, stored, and DOM-based cross-site scripting
- **CSRF**: Missing CSRF protections on state-changing endpoints
- **Authentication**: Weak password policies, broken auth flows, session fixation
- **Secrets**: Hardcoded API keys, passwords, tokens, connection strings
- **Dependencies**: Known vulnerabilities in packages (CVEs)
- **Deserialization**: Insecure deserialization patterns
- **Prototype pollution**: Object manipulation attacks (JavaScript/TypeScript)

Collect every finding with:

- **Severity**: Critical / High / Medium / Low / Info
- **Category**: OWASP Top 10 mapping
- **Location**: File path and line number
- **Description**: What the vulnerability is
- **Evidence**: The specific code pattern that triggered the finding
- **Remediation**: How to fix it

> **Claude Code optimization**: If the `/security-scanning:security-sast` skill is available, use it for enhanced automated scanning. Otherwise, follow the manual checklist above.

## Step 3: Security Hardening Review

Perform a comprehensive hardening review across the following areas:

### HTTP Security

- Security headers (HSTS, CSP, X-Frame-Options, X-Content-Type-Options)
- CORS configuration (allowed origins, methods, headers)
- Cookie security flags (HttpOnly, Secure, SameSite)

### API Security

- Rate limiting on all public endpoints
- Input validation completeness (every user input validated)
- Output encoding to prevent injection
- API key and token management
- Request size limits

### Authentication and Authorization

- Password hashing algorithm (bcrypt, argon2)
- JWT configuration (algorithm, expiration, refresh)
- Session management (timeout, invalidation, rotation)
- Role-based access control enforcement
- OAuth/OIDC configuration (if applicable)

### Data Protection

- PII encrypted at rest
- Sensitive data encrypted in transit (TLS 1.2+)
- Logging does not include sensitive data
- Error messages do not leak internal details
- Database connection uses SSL

### Infrastructure

- Container image security (base image, non-root user, multi-stage builds)
- Environment variable management (no secrets in code or logs)
- Network exposure (unnecessary ports, services)

> **Claude Code optimization**: If the `/security-scanning:security-hardening` skill is available, use it for enhanced automated hardening analysis. Otherwise, follow the manual checklist above.

## Step 4: STRIDE Threat Modeling

Systematically model threats using the STRIDE framework:

### Spoofing

- Can user identities be faked? (auth bypass, token theft)
- Can service identities be spoofed? (service-to-service auth)

### Tampering

- Can request data be modified in transit?
- Can database records be altered without authorization?
- Can client-side data (localStorage, cookies) be tampered?

### Repudiation

- Are all security-relevant actions logged?
- Can a user deny performing an action?
- Is there an audit trail for data changes?

### Information Disclosure

- Can sensitive data leak through error messages?
- Can unauthorized users access other users' data?
- Are there timing attacks or side-channel leaks?

### Denial of Service

- Can the system be overwhelmed by excessive requests?
- Are there resource-intensive endpoints without rate limiting?
- Can large payloads cause memory exhaustion?

### Elevation of Privilege

- Can a regular user access admin functionality?
- Can horizontal privilege escalation occur (access another user's resources)?
- Are there IDOR (Insecure Direct Object Reference) vulnerabilities?

Document each threat with:

- **Likelihood**: High / Medium / Low
- **Impact**: Critical / High / Medium / Low
- **Risk Score**: Likelihood x Impact
- **Existing Mitigations**: What's already in place
- **Gaps**: What's missing

## Step 5: Attack Tree Analysis

For the top 3 highest-risk threats identified in STRIDE, build attack trees showing:

- **Attack goal**: What the attacker wants to achieve
- **Attack paths**: Different ways to reach the goal
- **Sub-goals**: Intermediate steps required
- **Required resources**: Attacker skill level, tools, access needed
- **Existing defenses**: Current mitigations along each path
- **Weakest links**: Where defenses are thinnest

## Step 6: Architecture Council Security Review

Activate a subset of the Architecture Council for security review. For each council member, read their agent definition from the skill's `agents/` directory and use the complexity tier specified to calibrate review depth.

### Security Engineer (Lead)

- Validate automated findings (identify false positives)
- Prioritize remediation based on actual risk
- Assess overall security posture
- **Assessment**: Strong / Adequate / Needs Improvement / Critical Risk

### Principal Engineer

- Assess architectural implications of required remediations
- Identify systemic patterns that create vulnerabilities
- Recommend architectural changes for defense-in-depth
- **Assessment**: Architecturally sound / Needs refactoring / Fundamental issues

### Backend Specialist

- Evaluate backend-specific security patterns
- Assess API security implementation quality
- Review database access patterns for injection risks
- **Assessment**: Well-secured / Some gaps / Significant concerns

## Step 7: Present Audit Report

Generate a structured security audit report:

### Executive Summary

- **Overall Security Posture**: Strong / Adequate / Needs Improvement / Critical
- **Total Findings**: Count by severity (Critical, High, Medium, Low)
- **Top 3 Risks**: The most important issues to address
- **STRIDE Coverage**: Summary of threat categories with risk levels

### Critical and High Findings (must-fix)

For each finding:

- Severity, category, and OWASP mapping
- File and line number
- Description with evidence
- Step-by-step remediation
- Effort estimate (quick fix / moderate / significant)

### Medium Findings (should-fix)

Same format as above, prioritized by risk.

### Low and Info Findings (track)

Summary list for tracking as technical debt.

### Threat Model Summary

- STRIDE analysis results table
- Top 3 attack trees (visual or structured text)
- Defense gap analysis

### Recommended Actions (prioritized)

1. **Immediate** (Critical): Must fix before next deployment
2. **This Sprint** (High): Fix within current work cycle
3. **Next Sprint** (Medium): Schedule for upcoming work
4. **Backlog** (Low): Track as technical debt

### CHECKPOINT: Present the full audit report to the user. Ask which findings they want to remediate now, and which to track for later.

## Step 8: Remediation (Optional)

If the user chooses to remediate findings now:

1. Address findings in priority order (Critical first, then High)
2. For each fix:
   - Apply the remediation
   - Re-run the relevant scan to verify the fix
   - Run tests to ensure no regressions
3. Commit each fix with:
   ```
   fix(security): remediate <finding-description>
   ```

After remediation, suggest the next step (see below).

## Step 9: Hand Off

Present the next step to the user:

- **If code was changed** (remediation applied): Run `/review-code` to verify fixes in context of other changes
- **If no code was changed** (audit-only): No further action needed — track findings as issues or technical debt
- **If starting a new feature**: Run `/plan-feature` to begin the next feature with audit findings in mind

**Pipeline**: `/plan-feature` → `/build-feature` or `/build-api` → `/review-code` → `/submit-pr`

**Standalone**: `/security-audit` can be run at any point in the pipeline or independently.

# Review Council

## Purpose
Conduct multi-perspective code review before commits, ensuring security, quality, and documentation standards are met.

## Council Members
1. **Security Engineer** (Lead) - Security vulnerabilities
2. **QA Lead** - Test coverage and quality
3. **DevX Engineer** - Documentation and code clarity
4. **[Frontend or Backend Specialist]** - Domain-specific review (based on changed files)

## Activation Triggers
- Pre-commit reviews (before git commit)
- Pull request evaluations
- Security-sensitive code changes (auth, API, database)
- Documentation updates
- Major code refactoring

## Review Template

### Changes Summary
[Brief description of code changes]

### Code Review

#### Security Engineer
- **Vulnerabilities**: [Any security risks identified?]
- **Compliance**: [OWASP Top 10 check]
- **Recommendations**: [Security improvements]

#### QA Lead
- **Test Coverage**: [Are new tests added? Coverage adequate?]
- **Edge Cases**: [Are edge cases tested?]
- **Recommendations**: [Testing improvements]

#### DevX Engineer
- **Documentation**: [README/docs updated? Code comments clear?]
- **Code Quality**: [Readable? Maintainable?]
- **Recommendations**: [Documentation or clarity improvements]

#### [Specialist] (Frontend or Backend)
- **Best Practices**: [Domain-specific patterns followed?]
- **Code Quality**: [Architecture adherence?]
- **Recommendations**: [Technical improvements]

### Review Decision
- **Status**: ☐ Approved  ☐ Needs Changes  ☐ Blocked
- **Action Items**: [Required changes before commit]
- **Date**: [Review date]

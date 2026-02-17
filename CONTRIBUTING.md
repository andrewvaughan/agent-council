# Contributing

Thank you for your interest in contributing! This document outlines our development workflow and contribution guidelines.

## Development Workflow

We follow **Trunk-Based Development (TBD)** to enable rapid iteration and continuous delivery:

- **Main branch (`main`)** is always production-ready and deployable
- **Short-lived feature branches** for all changes (max 2-3 days)
- **All changes go through pull requests** - no direct commits to `main`
- **Frequent integration** - merge to main multiple times per day when possible
- **Feature flags** for incomplete features that need to merge early

## Getting Started

1. **Fork and clone** the repository (external contributors) or **clone directly** (team members)
2. **Install dependencies** (see [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md) for setup)
3. **Create a feature branch** from `main`
4. **Make your changes** following our conventions
5. **Submit a pull request** back to `main`

## Branching Strategy

### Branch Naming Convention

Use descriptive branch names with the following prefixes:

- `feature/` - New features or enhancements
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring
- `test/` - Test additions or improvements
- `chore/` - Maintenance tasks (dependencies, configs, etc.)

**Examples:**
```
feature/user-authentication
fix/email-validation-bug
docs/api-documentation
refactor/database-schema
```

### Branch Lifecycle

1. **Create branch** from latest `main`:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b feature/your-feature-name
   ```

2. **Keep branch up-to-date** with `main` (rebase frequently):
   ```bash
   git fetch origin
   git rebase origin/main
   ```

3. **Keep branches short-lived** (< 2-3 days)
   - Break large features into smaller, shippable increments
   - Use feature flags for work-in-progress features
   - Merge frequently to avoid long-lived branches

4. **Delete branch after merge**:
   ```bash
   git branch -d feature/your-feature-name
   git push origin --delete feature/your-feature-name
   ```

## Commit Guidelines

### Commit Message Format

We follow **Conventional Commits** for clear, scannable commit history:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation only
- `style` - Code style changes (formatting, no logic change)
- `refactor` - Code refactoring (no feature change or bug fix)
- `perf` - Performance improvements
- `test` - Adding or updating tests
- `chore` - Maintenance (dependencies, configs, build)
- `ci` - CI/CD changes

**Examples:**
```
feat(auth): add OAuth2 authentication

Implement OAuth2 authentication with Google and GitHub providers.
Uses Passport.js for strategy management.

Closes #123

---

fix(api): validate email format in signup endpoint

Added Zod validation to ensure email format is valid before
creating user account. Prevents invalid emails in database.

---

docs(readme): add development setup instructions

Added step-by-step guide for local development environment setup
including Docker, pnpm, and environment variables.
```

### Commit Best Practices

- **Atomic commits** - Each commit should be a single logical change
- **Descriptive messages** - Explain *why*, not just *what*
- **Sign commits** - All commits should be signed (GPG/SSH)
- **Test before committing** - Run tests locally before pushing
- **Small, frequent commits** - Better than large, infrequent ones

## Pull Request Process

### Before Creating a PR

1. **Ensure all tests pass locally**:
   ```bash
   pnpm test
   pnpm lint
   pnpm type-check
   ```

2. **Rebase on latest `main`**:
   ```bash
   git fetch origin
   git rebase origin/main
   ```

3. **Review your own changes** - Check the diff before submitting

### Creating a Pull Request

1. **Push your branch** to GitHub:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Open a pull request** on GitHub targeting `main`

3. **Fill out the PR template** completely:
   - Clear title and description
   - Link related issues
   - List changes made
   - Include screenshots (for UI changes)
   - Note breaking changes (if any)

4. **Request review** (will be automatic once team grows)

### Pull Request Requirements

All pull requests must meet these criteria before merging:

- ✅ **CI checks pass** - All automated tests and lints must pass
- ✅ **Code review approved** - At least one approval (when team > 1)
- ✅ **Conflicts resolved** - Must be up-to-date with `main`
- ✅ **Tests included** - New features must include tests
- ✅ **Documentation updated** - Update docs for user-facing changes
- ✅ **No direct commits to `main`** - Branch protection enforced

### Pull Request Size

Keep PRs small and focused:

- **Ideal: < 400 lines changed** - Easy to review, fast to merge
- **Maximum: < 1000 lines changed** - Beyond this, consider splitting
- **Break large features** into multiple PRs using feature flags

### Review Process

1. **Automated checks run** (CI, linting, tests)
2. **Code review** by team member (when team > 1)
3. **Address feedback** - Make requested changes
4. **Approval granted** - Reviewer approves PR
5. **Merge to `main`** - Squash and merge or rebase (see below)

### Merge Strategy

We use **Squash and Merge** as default:

- **Squash and merge** - Combines all commits into one clean commit (preferred)
- **Rebase and merge** - Keeps individual commits (use for well-crafted commit history)
- **Never use merge commits** - Keeps history linear and clean

## Code Standards

### Code Quality

- **TypeScript strict mode** - All code must type-check
- **ESLint** - All linting rules must pass
- **Prettier** - All code must be formatted
- **No compiler warnings** - Fix all TypeScript warnings
- **Test coverage > 80%** - Maintain high test coverage

### Testing Requirements

- **Unit tests** for business logic
- **Integration tests** for API endpoints
- **E2E tests** for critical user flows
- **All tests must pass** before merging

### Documentation Requirements

- **Code comments** for complex logic
- **JSDoc/TSDoc** for public APIs
- **README updates** for new features
- **CHANGELOG updates** for user-facing changes

## Feature Flags

For larger features that need multiple PRs, use feature flags:

```typescript
// Example feature flag usage
if (featureFlags.newDashboard) {
  return <NewDashboard />;
} else {
  return <OldDashboard />;
}
```

Benefits:
- Merge incomplete work to `main` safely
- Test in production with limited users
- Roll out gradually
- Easy rollback if issues arise

## Environment Strategy

### Current Environments

- **Production** - `main` branch deploys to production
- **Local Development** - Run locally with Docker Compose

### Future Environments (TBD)

We're prepared to add:
- **Staging** - Pre-production testing environment
- **Beta** - Early access for beta users
- **Preview** - PR-specific preview deployments

When we add these, we'll update this document with the strategy.

## Getting Help

- **Questions?** - Open a discussion on GitHub
- **Found a bug?** - Open an issue with reproduction steps
- **Need help?** - Tag someone in your PR for guidance

## Code of Conduct

- **Be respectful** and professional
- **Provide constructive feedback** in reviews
- **Assume good intent** from contributors
- **Help others learn** and grow

## Quick Reference

```bash
# Start new feature
git checkout main
git pull origin main
git checkout -b feature/my-feature

# Make changes, commit often
git add .
git commit -m "feat(scope): description"

# Keep up-to-date with main
git fetch origin
git rebase origin/main

# Push and create PR
git push origin feature/my-feature
# Then create PR on GitHub

# After PR merged, clean up
git checkout main
git pull origin main
git branch -d feature/my-feature
```

## Resources

- [Trunk-Based Development](https://trunkbaseddevelopment.com/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Development Setup](docs/DEVELOPMENT.md)
- [Pull Request Template](.github/PULL_REQUEST_TEMPLATE.md)

---

**Thank you for contributing!** 🚀

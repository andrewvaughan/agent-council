# Lawnsignal

> A cloud-agnostic, self-hosted web application built with TypeScript, rapid iteration, and councils of agents.

## 🚀 Quick Start

### Prerequisites

- **VS Code** with these extensions:
  - **Claude Code** (required)
  - **Dev Containers** (required)
- **Docker Desktop** (for devcontainer)

### Installation

```bash
# 1. Clone repository
git clone git@github.com:andrewvaughan/lawnsignal.git
cd lawnsignal

# 2. Open in VS Code
code .

# 3. Reopen in devcontainer
# VS Code will prompt: "Reopen in Container" → Click it
# Or: Cmd/Ctrl+Shift+P → "Dev Containers: Reopen in Container"
```

### 4. Set Up Claude Code Plugins

**In VS Code (inside devcontainer):**

1. Open Command Palette (`Cmd/Ctrl+Shift+P`)
2. Type "Claude Code: Manage Plugins"
3. Click "Add Marketplace"
4. Enter: `wshobson/agents` and press Enter

5. Install ALL of the following plugins (click + icon next to each):

#### Essential Development Tools
- `code-documentation` - Documentation and technical writing
- `debugging-toolkit` - Smart debugging and error analysis
- `git-pr-workflows` - Git automation and PR workflows
- `javascript-typescript` - TypeScript/JavaScript expertise
- `full-stack-orchestration` - End-to-end feature development

#### Frontend & Backend
- `frontend-mobile-development` - React/React Native development
- `backend-development` - REST/GraphQL API design
- `backend-api-security` - NestJS security patterns
- `frontend-mobile-security` - React security (XSS, CSRF)
- `ui-design` - UI design
- `database-design` - Database design

#### Testing & Quality
- `unit-testing` - Automated test generation (Jest)
- `code-review-ai` - AI-powered code review
- `api-testing-observability` - API testing and monitoring

#### Security
- `security-scanning` - Vulnerability scanning
- `database-migrations` - Safe Prisma migrations

#### Infrastructure & Operations
- `cloud-infrastructure` - AWS/Docker/K8s architecture

#### Additional Utilities
- `documentation-generation` - Auto-generate docs
- `dependency-management` - Package management

**Total: 19 plugins**

**Verify:** Command Palette → "Claude Code: Manage Plugins" → all 19 should show as installed

### Start Development

```bash
# Inside devcontainer, dependencies are already installed
pnpm dev
```

## 📖 Documentation

- **[CONTRIBUTING.md](CONTRIBUTING.md)** - How to contribute (includes workflow and councils)
- **[.claude/README.md](.claude/README.md)** - Workflow skills and councils of agents
- **[docs/DEVELOPMENT.md](docs/DEVELOPMENT.md)** - Detailed development guide

## 🏗️ Tech Stack

### Frontend
- **Vite + React 19** - Fast, modern React framework
- **TypeScript 5.7+** - Type-safe development
- **Tailwind CSS + shadcn/ui** - Utility-first styling

### Backend
- **NestJS** - Scalable Node.js framework
- **Prisma + PostgreSQL** - Type-safe database access
- **tRPC** - End-to-end type safety for APIs

### Infrastructure
- **pnpm + Turborepo** - Efficient monorepo management
- **Docker** - Containerized deployment
- **Self-hosted** - Full control, no vendor lock-in

## 🤖 Workflow Skills & Councils

This project uses **workflow skills** (executable slash commands) and **councils of agents** for end-to-end development with multi-perspective decision-making.

**7 Skills** (type `/` in Claude Code):

| Skill | Purpose |
|-------|---------|
| `/plan-feature` | Plan a feature with Product + Feature council review |
| `/build-feature` | Full-stack implementation (DB + API + UI + tests) |
| `/build-api` | Backend-only API development |
| `/review-code` | Multi-perspective code review + security scanning |
| `/submit-pr` | Create PR with quality checks + deployment review |
| `/security-audit` | SAST scanning + STRIDE threat modeling |
| `/setup-design-system` | Design system initialization + accessible components |

**5 Councils:** Architecture, Feature, Review, Deployment, Product

**Example:** Open Claude Code in VS Code and run:
```
/plan-feature Add user authentication with OAuth2 providers
```

**Learn more:** [.claude/README.md](.claude/README.md)

## 🎯 Philosophy

1. **Speed over Perfection** - Ship fast, learn fast, iterate
2. **Incremental Value** - Deliver in 1-2 week increments
3. **Feature Flags** - Prototype and test before full rollout
4. **User Feedback** - Data-driven decisions
5. **Councils of Agents** - Multi-perspective decisions

## 🔄 Development Workflow

**Trunk-Based Development:**

- Main branch is always production-ready
- Short-lived feature branches (< 2-3 days)
- All changes via pull requests
- Frequent integration
- Feature flags for incomplete work

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed workflow.

## 📦 Project Structure

```
lawnsignal/
├── .claude/         # Skills, councils, and agent configuration
├── .devcontainer/   # Dev container setup
├── .github/         # GitHub workflows
├── apps/            # Applications (coming soon)
│   ├── web/         # React frontend
│   └── api/         # NestJS backend
├── packages/        # Shared packages (coming soon)
│   ├── ui/          # UI components
│   ├── types/       # Shared types
│   └── utils/       # Shared utilities
├── docs/            # Documentation
└── README.md        # This file
```

## 🧪 Testing

```bash
pnpm test              # Run all tests
pnpm test:watch        # Watch mode
pnpm test:e2e          # E2E tests
pnpm test:coverage     # Coverage report
```

## 🔍 Code Quality

```bash
pnpm type-check    # TypeScript check
pnpm lint          # Lint code
pnpm format        # Format code
pnpm check-all     # Run all checks
```

## 🚢 Deployment

**Current:** Self-hosted on homelab via Docker
**Future:** Staging and beta environments (TBD)

## 🤝 Contributing

Read our [Contributing Guide](CONTRIBUTING.md) to get started.

**Quick overview:**
1. Set up devcontainer and Claude Code plugins (see above)
2. `/plan-feature` - Plan and scope the feature
3. `/build-feature` or `/build-api` - Implement with council guidance
4. `/review-code` - Multi-perspective review
5. `/submit-pr` - Create pull request
6. Address review feedback
7. Merge when approved

## 📝 License

Proprietary.

## 🙏 Acknowledgments

- [Trunk-based development](https://trunkbaseddevelopment.com/)
- [wshobson/agents](https://github.com/wshobson/agents) marketplace
- [Council pattern](https://www.theengineeringmanager.com/growth/councils-of-agents-group-thinking-with-llms/)

## 📧 Contact

- **Website**: [lawnsignal.com](https://lawnsignal.com)
- **Issues**: [GitHub Issues](https://github.com/andrewvaughan/lawnsignal/issues)
- **Discussions**: [GitHub Discussions](https://github.com/andrewvaughan/lawnsignal/discussions)

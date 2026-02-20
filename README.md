# Agent Council

> A template for multi-perspective decision-making and end-to-end development workflows using councils of AI agents in Claude Code.

## 🚀 Quick Start

### Prerequisites

- **VS Code** with these extensions:
  - **Claude Code** (required)
  - **Dev Containers** (required)
- **Docker Desktop** (for devcontainer)

### Installation

```bash
# 1. Clone repository
git clone git@github.com:YOUR_USERNAME/YOUR_PROJECT.git
cd YOUR_PROJECT

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

**6 Skills** (type `/` in Claude Code):

| Skill | Purpose |
|-------|---------|
| `/plan-feature` | Plan a feature with Product + Feature council review |
| `/build-feature` | Full-stack implementation (DB + API + UI + tests) |
| `/build-api` | Backend-only API development |
| `/review-code` | Multi-perspective code review + security scanning |
| `/submit-pr` | Create PR with quality checks + deployment review |
| `/security-audit` | SAST scanning + STRIDE threat modeling |

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
agent-council/
├── .claude/             # Claude Code integration
│   ├── skills/          # Skill source SKILL.md files (authoring location)
│   ├── CLAUDE.md        # Project instructions for Claude Code
│   └── README.md        # Detailed skill and council documentation
├── canonical/           # Single source of truth for shared resources
│   ├── agents/          # Agent persona definitions (11 agents)
│   ├── councils/        # Council templates (5 councils)
│   └── templates/       # Shared templates (decision records, etc.)
├── skills/              # Generated — distributable skill packages
│   ├── plan-feature/    # Each skill bundles its own agents/councils
│   ├── review-code/
│   ├── security-audit/
│   └── submit-pr/
├── scripts/             # Build tooling
│   ├── build.sh         # Generates skills/ from canonical + .claude/skills
│   └── skill-manifest.json  # Maps skills to required resources
├── docs/                # Project documentation
│   └── decisions/       # Council decision records
├── .github/             # CI workflows
└── README.md            # This file
```

> **Do not edit files in `skills/` directly.** They are generated by `scripts/build.sh` from sources in `.claude/skills/` and `canonical/`. Your changes will be overwritten on the next build. Edit the source files instead, then run `./scripts/build.sh` to regenerate.

### Build Pipeline

```
.claude/skills/*/SKILL.md  ─┐
                             ├──→  scripts/build.sh  ──→  skills/*/
canonical/{agents,councils,  │
           templates}/*.md  ─┘
```

To regenerate skill packages after editing source files:

```bash
./scripts/build.sh           # Build all skills
./scripts/build.sh --check   # Verify output matches (used in CI)
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

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/YOUR_PROJECT/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/YOUR_PROJECT/discussions)

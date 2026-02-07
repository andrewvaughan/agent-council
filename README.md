# Lawnsignal

> A cloud-agnostic, self-hosted web application built with TypeScript, rapid iteration, and councils of agents.

## 🚀 Quick Start

```bash
# Clone repository
git clone git@github.com:YOUR_USERNAME/lawnsignal.git
cd lawnsignal

# Install dependencies
pnpm install

# Start development environment
# (Coming soon when monorepo is set up)
# pnpm dev
```

## 📖 Documentation

- **[Contributing Guide](CONTRIBUTING.md)** - How to contribute to Lawnsignal
- **[Development Guide](docs/DEVELOPMENT.md)** - Local setup and development workflow
- **[Council Documentation](.claude/README.md)** - Using councils of agents for decision-making

## 🏗️ Tech Stack

### Frontend
- **Vite + React 19** - Fast, modern React framework
- **TypeScript 5.7+** - Type-safe development
- **Tailwind CSS + shadcn/ui** - Utility-first styling with beautiful components

### Backend
- **NestJS** - Scalable Node.js framework
- **Prisma + PostgreSQL** - Type-safe database access
- **tRPC** - End-to-end type safety for APIs

### Infrastructure
- **pnpm + Turborepo** - Efficient monorepo management
- **Docker** - Containerized deployment
- **Self-hosted** - Full control, no vendor lock-in

## 🎯 Philosophy

Lawnsignal is built with these core principles:

1. **Speed over Perfection** - Ship fast, learn fast, iterate
2. **Incremental Value** - Deliver in 1-2 week increments
3. **Feature Flags** - Prototype and test before full rollout
4. **User Feedback** - Data-driven decisions, not assumptions
5. **Councils of Agents** - Multi-perspective decision-making

## 🤖 Councils of Agents

This project uses **councils of agents** - specialized AI agents that evaluate decisions from multiple perspectives:

- **11 Specialized Agents** - Technical, product, design, delivery, and business perspectives
- **5 Councils** - Architecture, Feature, Review, Deployment, Product
- **Every Decision** - Evaluated for speed, quality, security, and value

Learn more in the [Council Documentation](.claude/README.md).

## 🔄 Development Workflow

We follow **Trunk-Based Development** for rapid iteration:

- **Main branch** is always production-ready
- **Short-lived feature branches** (< 2-3 days)
- **All changes via pull requests** with required reviews
- **Frequent integration** to avoid long-lived branches
- **Feature flags** for incomplete work

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed workflow.

## 📦 Project Structure

```
lawnsignal/
├── .claude/                    # Councils of agents configuration
├── .github/                    # GitHub templates and workflows
├── apps/                       # Applications (coming soon)
│   ├── web/                    # React frontend
│   └── api/                    # NestJS backend
├── packages/                   # Shared packages (coming soon)
│   ├── ui/                     # UI component library
│   ├── types/                  # Shared TypeScript types
│   └── utils/                  # Shared utilities
├── docs/                       # Documentation
├── CONTRIBUTING.md             # Contribution guidelines
└── README.md                   # This file
```

## 🧪 Testing

```bash
# Run all tests
pnpm test

# Run tests in watch mode
pnpm test:watch

# Run E2E tests
pnpm test:e2e

# Check coverage
pnpm test:coverage
```

## 🔍 Code Quality

```bash
# Type check
pnpm type-check

# Lint code
pnpm lint

# Format code
pnpm format

# Run all checks
pnpm check-all
```

## 🚢 Deployment

**Current:** Self-hosted on homelab via Docker

**Future:** Staging and beta environments (TBD)

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to get started.

**Quick overview:**
1. Create a feature branch from `main`
2. Make your changes following our conventions
3. Submit a pull request with clear description
4. Address review feedback
5. Merge when approved

## 📝 License

TBD

## 🙏 Acknowledgments

- Built with [Claude Code](https://claude.com/claude-code) and councils of agents
- Inspired by [trunk-based development](https://trunkbaseddevelopment.com/)
- Powered by the [wshobson/agents](https://github.com/wshobson/agents) marketplace

## 📧 Contact

- **Website**: [lawnsignal.com](https://lawnsignal.com)
- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/lawnsignal/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/lawnsignal/discussions)

---

**Built with speed, iteration, and councils of agents** 🚀

# Feature Development Workflow

## Phase 1: Planning (Feature Council)
1. Activate Feature Council with feature description
2. Get architecture, frontend, backend, and QA perspectives
3. Create implementation plan based on council feedback
4. Document in feature branch or issue

## Phase 2: Implementation
1. **Frontend** (if applicable):
   - Use Frontend Specialist + ui-design plugin (Figma integration)
   - Develop components following council recommendations

2. **Backend** (if applicable):
   - Use Backend Specialist + backend-development plugin
   - Implement API endpoints and business logic

3. **Testing**:
   - Use QA Lead guidance for test strategy
   - Write unit, integration, and E2E tests

## Phase 3: Review (Review Council)
1. Activate Review Council for code review
2. Address security, quality, and documentation feedback
3. Update code based on recommendations

## Phase 4: Commit
1. Run pre-commit hooks (linting, formatting, tests)
2. Commit with descriptive message
3. Push to feature branch

## Phase 5: Deployment (if ready)
1. Activate Deployment Council for production readiness
2. Validate infrastructure, security, and quality gates
3. Deploy with approved rollback strategy

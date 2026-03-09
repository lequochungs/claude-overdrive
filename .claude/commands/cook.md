---
description: 🔥 Full Auto Pipeline - Từ yêu cầu đến MVP hoàn chỉnh
---

# /cook - Claude v3.0 Full Auto Pipeline

> **"Từ ý tưởng → MVP production-ready trong một command"**  
> **Version**: 3.0.0



---

## 🎯 Mục Đích

Pipeline tự động hoàn toàn theo chuẩn công ty phần mềm cao cấp:
- **Phase 0**: Intake & Analysis
- **Phase 1**: Product Planning (PRD)
- **Phase 2**: System Design
- **Phase 3**: UI/UX Design (optional)
- **Phase 4**: Implementation
- **Phase 5**: Testing & QA
- **Phase 6**: Code Review
- **Phase 7**: Deployment Prep
- **Phase 8**: Handover & Documentation

---

## ⚡ Execution Rules

- Tất cả phases chạy tự động (turbo-all)
- Mỗi phase đọc role/agent tương ứng
- Output được lưu chuẩn theo cấu trúc
- Error → Tự fix 1 lần → Nếu fail → Ask user

---

## Phase 0: 📥 Intake & Analysis

### 0.1 Parse Request
```markdown
## Request Analysis

📌 **Domain**: {e-commerce | saas | social | erp | cms | api | mobile | iot | custom}
📌 **Type**: {new-project | add-feature | fix-bug | refactor | optimization}
📌 **Complexity**: {simple | medium | complex | enterprise}
📌 **Estimated Time**: {hours/days}

### Core Entities
- Entity 1: {description}
- Entity 2: {description}

### Core Features
1. Feature 1: {description}
2. Feature 2: {description}

### Target Users
- Role 1: {permissions}
- Role 2: {permissions}

### Tech Stack Recommendation
- Frontend: {React/Vue/Next.js/...}
- Backend: {Node/Laravel/FastAPI/...}
- Database: {PostgreSQL/MongoDB/...}
- Infrastructure: {Vercel/AWS/Docker/...}
```

### 0.2 Clarification (if needed)
Sử dụng **AskUserQuestion** tool để hỏi tối đa 3 câu:
- Scope clarity
- Priority features
- Technical constraints

---

## Phase 1: 📋 Product Planning

### Persona Focus
You will act as a **Senior Product Manager**. You MUST think like a PM, focusing on user needs, business goals, and clear acceptance criteria.

### Actions
1. **Analyze requirements** từ Phase 0
2. **Create PRD** tại `plans/specs/prd-{feature}.md`:

```markdown
# PRD: {Feature Name}

## 1. Problem Statement
{Vấn đề cần giải quyết}

## 2. Goals
- Goal 1
- Goal 2

## 3. Non-Goals
- Out of scope 1
- Out of scope 2

## 4. User Stories

### US-001: {Title}
**As a** {user role}
**I want to** {action}
**So that** {benefit}

**Acceptance Criteria:**
- [ ] AC1
- [ ] AC2
- [ ] AC3

### US-002: {Title}
...

## 5. Functional Requirements
| ID | Requirement | Priority |
|----|-------------|----------|
| FR-001 | {description} | P1 |
| FR-002 | {description} | P2 |

## 6. Non-Functional Requirements
- Performance: {requirements}
- Security: {requirements}
- Scalability: {requirements}

## 7. Success Metrics
- KPI 1: {metric}
- KPI 2: {metric}

## 8. Dependencies & Risks
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Risk 1 | High | High | {mitigation} |
```

### Gate 1: PRD Review ✅
```
□ Problem statement clear
□ User stories complete
□ Acceptance criteria defined
□ Scope boundaries set
```

---

## Phase 2: 🏗️ System Architecture & Design

### Conditional Trigger
- **Check files**: Verify if `docs/roadmap.md` and `docs/architecture.md` exist.
- **IF EXIST**: You MUST SKIP Phase 2 and Phase 3, and jump directly to **Phase 4** to execute the roadmap.
- **IF MISSING**: You MUST execute the actions below to generate the design suite.

### Persona Focus
You will act as a **Software Architect and Database Admin**. Focus on scalability, clean database design, robust API contracts, and security.

### Actions (Only if missing design files)
1. **Analyze PRD**: Read `docs/prd.md` or the PRD created in Phase 1.
2. **Generate Technical Suite**: Create the following 6 documents in the `docs/` folder:
   - `docs/architecture.md`: Overall System Architecture.
   - `docs/diagram_flow.md`: Mermaid Sequence/User Flow diagrams.
   - `docs/api_spec.md`: Details of Endpoints, Request/Response bodies, and Status Codes.
   - `docs/ui_ux.md`: Outline layout (Wireframes using Mermaid) and Design Tokens.
   - `docs/security_tech.md`: Detailed Tech Stack and security measures.
   - `docs/roadmap.md`: CRITICAL. Step-by-step implementation Task list.

### Gate 2: Design Complete ✅
```
□ Full docs/ suite generated successfully
□ Roadmap broken down into testable steps
```

---

## Phase 3: 🎨 UI/UX Design (Optional)

### Trigger Condition
- User requests UI/frontend work
- PRD includes user-facing features

### Persona Focus
You will act as a **UI/UX Designer**. Focus on user experience, modern aesthetics, and generating high-quality mockups if needed.

### Actions
1. **Vibe discovery** - Understand user preferences
2. **Create mockups** using generate_image
3. **Design system** - Colors, typography, components
4. **Iterate** based on feedback

### Output
- Design tokens (CSS variables)
- Component specifications
- Responsive layouts

---

## Phase 4: 💻 Implementation

### Persona Focus
You will act as a **Senior Fullstack Engineer**. Focus on clean code, secure implementations, and full testability.

### Actions
1. **Locate Roadmap**: Read `docs/roadmap.md` (which should have been generated in Phase 2 or manually created).
2. **Execute Roadmap Sequentially**:
   - MUST implement tasks exactly in the order specified in the roadmap.
   - For each task, write/modify the necessary code.
   - Mark the task as `[x]` in `docs/roadmap.md` immediately after completing it.
3. **Follow best practices**:
   - YAGNI, KISS, DRY
   - Clean code principles
   - Proper error handling
   - Input validation
   - Logging

4. **After each file**:
   ```bash
   # Syntax check
   npm run lint 2>/dev/null || true
   ```

### Code Standards
```typescript
/**
 * Function documentation with JSDoc
 * @param {Type} param - Description
 * @returns {Type} Description
 */
function example(param: Type): ReturnType {
  // Implementation
}
```

---

## Phase 5: 🧪 Testing & QA

### Persona Focus
You will act as a **QA Engineer**. Focus on finding edge cases, writing robust tests, and ensuring high feature coverage.

### Actions
1. **Create tests**:
   - Unit tests for functions
   - Integration tests for APIs
   - E2E tests for critical flows

2. **Run test suite**:
   ```bash
   npm test 2>/dev/null || \
   php artisan test 2>/dev/null || \
   pytest 2>/dev/null || \
   go test ./... 2>/dev/null
   ```

3. **Target coverage**: > 80%

4. **Create QA Report**: `plans/reports/qa-{feature}.md`

```markdown
# QA Report: {Feature}

## Test Summary
| Type | Total | Passed | Failed |
|------|-------|--------|--------|
| Unit | 45 | 44 | 1 |
| Integration | 12 | 12 | 0 |
| E2E | 5 | 5 | 0 |

## Coverage
- Lines: 85%
- Branches: 78%
- Functions: 92%

## Issues Found
| ID | Severity | Description | Status |
|----|----------|-------------|--------|
| BUG-001 | P2 | {description} | Fixed |

## Recommendation
✅ Ready for code review
```

### Gate 5: QA Sign-off ✅
```
□ All tests passing
□ Coverage > 80%
□ No P1/P2 bugs open
□ Edge cases covered
```

---

## Phase 6: 🔍 Code Review

### Persona Focus
You will act as a **Strict Code Reviewer and Security Auditor**. Look for performance bottlenecks, security flaws, or deviations from coding standards.

### Actions
1. **Review all changes**:
   - Security vulnerabilities
   - Performance issues
   - Code quality
   - Best practices
   - Documentation

2. **Create Review Report**: `plans/reports/review-{feature}.md`

```markdown
# Code Review: {Feature}

## Summary
- Files reviewed: 15
- Lines added: 850
- Lines removed: 120

## Security
✅ No vulnerabilities found
✅ Input validation complete
✅ Auth checks in place

## Performance
✅ No N+1 queries
✅ Proper indexing
⚠️ Consider caching for /api/products

## Code Quality
✅ Clean code principles followed
✅ Proper error handling
✅ Good test coverage

## Verdict
✅ **APPROVED** - Ready for deployment
```

### Gate 6: Review Approved ✅
```
□ No security issues
□ Performance acceptable
□ Code standards followed
□ Documentation complete
```

---

## Phase 7: 🚀 Deployment Prep

### Persona Focus
You will act as a **DevOps Engineer**. Focus on reliable deployment pipelines, containerization, and environment configurations.

### Actions
1. **Prepare deployment artifacts**:
   - Dockerfile (if needed)
   - docker-compose.yml
   - CI/CD pipeline config
   - Environment variables template

2. **Create deployment guide**:
   ```markdown
   # Deployment: {Feature}
   
   ## Prerequisites
   - Node.js 18+
   - PostgreSQL 14+
   
   ## Environment Variables
   - DATABASE_URL=...
   - JWT_SECRET=...
   
   ## Commands
   npm run build
   npm run start
   ```

3. **Run deployment workflow** (if /deploy requested)

---

## Phase 8: 📊 Final Report & Handover

### Generate Executive Report

```
╔═══════════════════════════════════════════════════════════════════════╗
║       🚀 CLAUDE OVERDRIVE COMPLETE                            ║
╠═══════════════════════════════════════════════════════════════════════╣
║                                                                        ║
║  📋 Project: {Feature Name}                                            ║
║  👤 Requested by: User                                                 ║
║  ⏱️  Duration: {X hours/minutes}                                       ║
║  📅 Completed: {timestamp}                                             ║
║                                                                        ║
╠═══════════════════════════════════════════════════════════════════════╣
║  📄 DELIVERABLES                                                       ║
║  ├── PRD: plans/specs/prd-{feature}.md                                ║
║  ├── Design: plans/specs/design-{feature}.md                          ║
║  ├── QA Report: plans/reports/qa-{feature}.md                         ║
║  └── Review: plans/reports/review-{feature}.md                        ║
║                                                                        ║
╠═══════════════════════════════════════════════════════════════════════╣
║  💻 CODE STATISTICS                                                    ║
║  ├── Files created/modified: {count}                                  ║
║  ├── Lines of code: {count}                                           ║
║  ├── Test coverage: {%}                                               ║
║  └── Tests: {passed}/{total} passing                                  ║
║                                                                        ║
╠═══════════════════════════════════════════════════════════════════════╣
║  ✅ QUALITY GATES                                                      ║
║  ├── PRD Review: ✅ PASSED                                             ║
║  ├── Design Review: ✅ PASSED                                          ║
║  ├── QA Sign-off: ✅ PASSED                                            ║
║  ├── Code Review: ✅ APPROVED                                          ║
║  └── Security Check: ✅ PASSED                                         ║
║                                                                        ║
╠═══════════════════════════════════════════════════════════════════════╣
║  🚀 NEXT STEPS                                                         ║
║  1. Review generated code                                              ║
║  2. Configure environment variables                                    ║
║  3. Run: /run to start locally                                        ║
║  4. Run: /deploy when ready for production                            ║
║  5. Run: /save-brain to persist knowledge                             ║
║                                                                        ║
╠═══════════════════════════════════════════════════════════════════════╣
║  ❓ UNRESOLVED (if any)                                                ║
║  • {Question or pending decision}                                      ║
║                                                                        ║
╚═══════════════════════════════════════════════════════════════════════╝
```

### Knowledge Handover
Chạy `/save-brain` để lưu:
- Project context
- Technical decisions
- Gotchas & lessons learned

---

## 🎯 Example Usage

```bash
# E-commerce MVP
/cook Build an online store with:
- Product catalog with categories and filters
- Shopping cart with quantity management
- User authentication (register/login)
- Stripe checkout integration
- Order history for users
- Admin panel for product management

# SaaS Dashboard
/cook Create a project management tool like Trello with:
- Boards and cards with drag-drop
- Team collaboration and invites
- Due dates and notifications
- File attachments
- Activity history

# API Service
/cook Build a REST API for inventory management with:
- Products CRUD with categories
- Stock level tracking
- Low stock alerts
- Supplier management
- Purchase order creation
```

---

## 🛑 Error Handling

```
If any phase fails:
    1. Document the error
    2. Attempt auto-fix (1 time)
    3. If still fails → AskUserQuestion for guidance
    4. Resume after resolution
    5. Document in final report
```

---

## ⚙️ Configuration

Tùy chỉnh cấu hình chung (nếu có) thông qua `.claude/project.json`:

```json
{
  "auto_deploy": false,
  "auto_commit": true,
  "test_coverage_min": 80,
  "code_review_strict": true,
  "skip_optional_phases": false,
  "default_tech_stack": {
    "frontend": "nextjs",
    "backend": "node",
    "database": "postgresql"
  }
}
```

---

**Claude v3.0** - *Premium Software Development, Automated*

*"We don't just write code. We engineer solutions."*


---

## 🛑 CRITICAL RESTRICTION
DO NOT automatically proceed to any other workflow, command, or phase. 
You MUST stop execution here and WAIT for the user to explicitly type the next command.

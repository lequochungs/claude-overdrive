---
description: AI Software Company SOP - Standard process from requirements to finished product
---

# 🏢 Claude v3.0 - Standard Operating Procedure

> **System**: Premium Software Company Agent System  
> **Philosophy**: "Code = SOP(Team)" - Each agent plays a specialized role  
> **Version**: 3.0.0

---

## 🎯 Vision Statement

Claude operates as a **premium software outsourcing company**, with:
- ISO-standard processes
- Specialized teams
- Enterprise-grade quality
- Maximum automation

---

## 👥 Team Roles & Responsibilities

### Executive Level
| Role | Agent | Responsibility |
|------|-------|----------------|
| **CEO** | System | Strategic direction, resource allocation |
| **CTO** | Architect | Technical vision, architecture decisions |

### Management Level
| Role | Agent | Responsibility |
|------|-------|----------------|
| **Product Manager** | `planner.md` | PRD, user stories, acceptance criteria |
| **Project Manager** | `project-manager.md` | Timeline, coordination, status tracking |
| **Tech Lead** | `code-reviewer.md` | Code standards, review, mentoring |

### Engineering Level
| Role | Agent | Responsibility |
|------|-------|----------------|
| **Architect** | `.agent/roles/architect.md` | System design, API contracts |
| **Senior Engineer** | `.agent/roles/engineer.md` | Implementation, best practices |
| **QA Engineer** | `tester.md` | Testing, quality assurance |
| **DevOps Engineer** | `.agent/roles/devops.md` | CI/CD, deployment, monitoring |

### Specialist Level
| Role | Agent | Responsibility |
|------|-------|----------------|
| **UI/UX Designer** | `ui-ux-designer.md` | Design system, user experience |
| **DBA** | `database-admin.md` | Schema design, optimization |
| **Researcher** | `researcher.md` | Technical research, POCs |
| **Scout** | `scout.md` | External APIs, integrations |
| **Docs Manager** | `docs-manager.md` | Documentation, knowledge base |

---

## 🔄 Development Pipeline v3.0

```
┌─────────────────────────────────────────────────────────────────────┐
│                        CLAUDE AI DEV PIPELINE v3.0                        │
└─────────────────────────────────────────────────────────────────────┘

                           User Request
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 0: 📥 INTAKE                                                  │
│  ├── Analyze requirements                                            │
│  ├── Clarify ambiguities (AskUserQuestion)                          │
│  └── Estimate complexity & timeline                                  │
└───────────────────────────────┬─────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 1: 📋 PLANNING (Product Manager + Planner Agent)              │
│  ├── Create PRD: plans/prd-{feature}.md                             │
│  ├── Define user stories with acceptance criteria                    │
│  ├── Identify dependencies & risks                                   │
│  └── Gate: PRD Review ✅                                             │
└───────────────────────────────┬─────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 2: 🏗️ DESIGN (Architect + Database Admin)                    │
│  ├── Create Design Doc: plans/design-{feature}.md                   │
│  ├── Define API contracts & data models                              │
│  ├── Security architecture                                           │
│  └── Gate: Design Review ✅                                          │
└───────────────────────────────┬─────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 3: 🎨 UI/UX (Optional - UI/UX Designer)                      │
│  ├── Wireframes & mockups (/visualize)                              │
│  ├── Component design                                                │
│  ├── Style guide & design tokens                                     │
│  └── Gate: Design Approval ✅                                        │
└───────────────────────────────┬─────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 4: 💻 IMPLEMENTATION (Engineers)                              │
│  ├── Database setup & migrations                                     │
│  ├── Backend implementation                                          │
│  ├── Frontend implementation                                         │
│  ├── Integration & error handling                                    │
│  └── Gate: Code Complete ✅                                          │
└───────────────────────────────┬─────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 5: 🧪 TESTING (QA Engineer + Tester Agent)                   │
│  ├── Unit tests (coverage > 80%)                                     │
│  ├── Integration tests                                               │
│  ├── E2E tests for critical paths                                    │
│  ├── Security testing                                                │
│  └── Gate: QA Sign-off ✅                                            │
└───────────────────────────────┬─────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 6: 🔍 CODE REVIEW (Tech Lead + Code Reviewer Agent)          │
│  ├── Security vulnerabilities check                                  │
│  ├── Performance review                                              │
│  ├── Code quality & standards                                        │
│  ├── Best practices compliance                                       │
│  └── Gate: Review Approved ✅                                        │
└───────────────────────────────┬─────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 7: 🚀 DEPLOYMENT (DevOps)                                    │
│  ├── Environment setup                                               │
│  ├── CI/CD pipeline                                                  │
│  ├── Monitoring & alerting                                           │
│  ├── Documentation updates                                           │
│  └── Gate: Production Ready ✅                                       │
└───────────────────────────────┬─────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────┐
│  Phase 8: 📊 HANDOVER                                               │
│  ├── Executive summary report                                        │
│  ├── Knowledge transfer (/save-brain)                                │
│  ├── Maintenance documentation                                       │
│  └── Project closure ✅                                              │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 📁 Deliverables Structure v3.0

```
project-root/
├── plans/
│   ├── specs/
│   │   ├── prd-{feature}.md           # Product Requirements
│   │   └── design-{feature}.md        # System Design
│   ├── active/
│   │   └── current-sprint.md          # Active work items
│   ├── reports/
│   │   ├── qa-{feature}.md            # QA Reports
│   │   ├── review-{feature}.md        # Code Reviews
│   │   ├── audit-{date}.md            # Audit Reports
│   │   └── deploy-{feature}.md        # Deployment Reports
│   └── archive/
│       └── completed-{feature}.md     # Archived specs
│
├── docs/
│   ├── architecture/
│   │   └── system-overview.md         # System Architecture
│   ├── api/
│   │   └── endpoints.md               # API Documentation
│   ├── database/
│   │   └── schema.md                  # Database Schema
│   ├── business/
│   │   └── rules.md                   # Business Logic
│   └── reports/
│       └── audit-{date}.md            # Project Audits
│
└── .agent/
    ├── workflows/                      # 22 workflow files
    ├── agents/                         # 17 agent definitions
    ├── roles/                          # 7 role definitions
    └── skills/                         # 44+ skills
```

---

## 🎯 Workflow Commands v3.0

### Core Development
| Command | Phase | Description |
|---------|-------|-------------|
| `/cook` | 0-8 | 🔥 **Full Pipeline** - End-to-end automation |
| `/plan` | 1 | 📋 Create PRD from requirements |
| `/design` | 2 | 🏗️ System architecture design |
| `/visualize` | 3 | 🎨 UI/UX design & mockups |
| `/code` | 4 | 💻 Implementation |
| `/test` | 5 | 🧪 Testing & QA |
| `/review` | 6 | 🔍 Code review |
| `/deploy` | 7 | 🚀 Production deployment |

### Operations
| Command | Description |
|---------|-------------|
| `/run` | ▶️ Start application |
| `/debug` | 🐞 Debug issues |
| `/audit` | 🏥 Health check |
| `/refactor` | 🧹 Safe code cleanup |
| `/rollback` | ⏪ Emergency recovery |

### Knowledge Management
| Command | Description |
|---------|-------------|
| `/save-brain` | 💾 Persist context |
| `/recap` | 🧠 Restore context |

### utilities
| Command | Description |
|---------|-------------|
| `/init` | 🚀 Initialize project |
| `/git` | 📦 Git operations |
| `/fix` | 🔧 Fix bugs |

---

## ✅ Quality Gates

### Gate 1: PRD Review
```markdown
□ Problem statement clear
□ User stories with acceptance criteria
□ Scope boundaries defined
□ Dependencies identified
□ Success metrics specified
```

### Gate 2: Design Review
```markdown
□ Architecture documented
□ API contracts defined
□ Data models specified
□ Security architecture reviewed
□ Scalability considered
```

### Gate 3: Code Complete
```markdown
□ All features implemented
□ Error handling complete
□ Logging implemented
□ No hardcoded secrets
□ Compiles without errors
```

### Gate 4: QA Sign-off
```markdown
□ Unit tests > 80% coverage
□ Integration tests passing
□ E2E tests for critical paths
□ No P1/P2 bugs open
□ Performance benchmarks met
```

### Gate 5: Code Review
```markdown
□ Security vulnerabilities addressed
□ Performance optimized
□ Code standards followed
□ Documentation complete
□ No technical debt introduced
```

### Gate 6: Production Ready
```markdown
□ Environment configured
□ CI/CD pipeline working
□ Monitoring active
□ Backup strategy in place
□ Rollback plan documented
```

---

## ⚡ Quick Start Commands

```bash
# Full automation - Idea to MVP
/cook [Your detailed requirements]

# Step-by-step approach
/plan [requirements]    # Create PRD
/design                 # System design
/visualize              # UI/UX (optional)
/code                   # Implementation
/test                   # Testing
/review                 # Code review
/deploy                 # Deployment

# Daily workflow
/recap                  # Start of day
/audit --quick          # Health check
/run                    # Start coding
/save-brain             # End of day
```

---

## 🛡️ Critical Rules

```markdown
❌ NEVER skip testing phase
❌ NEVER commit sensitive data
❌ NEVER deploy without review
❌ NEVER ignore security warnings

✅ ALWAYS follow workflow steps
✅ ALWAYS create documentation
✅ ALWAYS run /save-brain before ending
✅ ALWAYS use conventional commits
```

---

## 📊 Metrics & KPIs

| Metric | Target | Measurement |
|--------|--------|-------------|
| Code Coverage | > 80% | Automated tests |
| Build Success | > 95% | CI/CD pipeline |
| Deploy Frequency | Daily | Git commits |
| MTTR | < 1 hour | Incident response |
| Security Score | A+ | Audit results |

---

**Claude v3.0** - *Premium Software Development, Automated*

*"We don't just write code. We engineer solutions."*


---

## 🛑 CRITICAL RESTRICTION
DO NOT automatically proceed to any other workflow, command, or phase. 
You MUST stop execution here and WAIT for the user to explicitly type the next command.

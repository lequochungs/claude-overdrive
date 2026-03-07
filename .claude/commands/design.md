---
description: System design, Architecture, and detailed Roadmap
---

# /design - System Architecture & Design Workflow

This command transitions from PRD to technical design.

## Precondition
- Must have the `docs/prd.md` file. If not, ask the User to run `/plan`.

## Workflow

### Step 1: Transition to PLANNING Mode
**CRITICAL**: Call the `task_boundary` tool.
- Mode: `PLANNING`
- TaskName: `System Architecture & Roadmap Design`
- TaskStatus: `Defining technical architecture and implementation roadmap.`

### Step 2: Read PRD & Analyze Codebase
- Read the content of `docs/prd.md`.
- Use `list_dir` and `grep_search` to understand the current project structure.

### Step 3: Create Technical Documents
**CRITICAL**: Create a complete technical design suite in the `docs/` directory.

1. **`docs/architecture.md`**: Presents the overall System Architecture.
2. **`docs/diagram_flow.md`**: Mermaid Sequence/User Flow diagrams.
3. **`docs/api_spec.md`**: Details of Endpoints, Request/Response bodies, and Status Codes.
4. **`docs/ui_ux.md`**: Outline layout (Wireframes using Mermaid) and Design Tokens.
5. **`docs/security_tech.md`**: Detailed Tech Stack and security measures (Auth, CORS, etc.).
6. **`docs/roadmap.md`**: Step-by-step implementation Task list.

### Step 4: Notify User & Wait
- Call `notify_user`.
- Message: "I have completed the **Full-stack** design suite consisting of 6 documents (Architecture, API, UI/UX, Security, Flows, and Roadmap) in `docs/`. Please review the **Roadmap** and **API Spec** carefully. Once approved, type `/code` and I'll start the implementation!"
- BlockedOnUser: `true`

---

## 🛑 CRITICAL RESTRICTION
- MUST create the full documentation suite (Architecture, Flows, API, UI/UX, Security, Roadmap).
- DO NOT automatically implement code. Must wait for User command `/code`.

---
description: Plan and create an in-depth PRD at docs/prd.md
---

# /plan - Product Discovery & PRD Workflow

This command initiates the **DISCOVERY** phase. The goal is to transform the User's idea into a complete Product Requirements Document (PRD).

## Workflow

### Step 1: Transition to PLANNING Mode
**CRITICAL**: Call the `task_boundary` tool.
- Mode: `PLANNING`
- TaskName: `Product Discovery & PRD Creation`
- TaskStatus: `Gathering requirements and drafting PRD.`

### Step 2: Interactive Clarification
- If the idea is still in the early stages, ask **at most 2 sharp questions** to clarify goals, target audience, or core features.
- Wait for User response before writing the file.

### Step 3: Create PRD Document
**CRITICAL**: Once the idea is agreed upon, create the actual document file.
- **Path**: `docs/prd.md`
- Content includes:
  - **Project Overview**: Project summary.
  - **User Stories**: User scenarios.
  - **Core Features**: List of main features.
  - **Non-functional Requirements**: Performance, security, etc.
  - **Success Metrics**: Criteria for success.

### Step 4: Notify User & Wait
**CRITICAL**: Stop completely for User review.
- Call `notify_user`.
- Message: "I have drafted the PRD at `docs/prd.md` based on our discussion. Please review it. If you're happy, type `/design` and I'll create the technical architecture and Roadmap!"
- BlockedOnUser: `true`

---

## 🛑 CRITICAL RESTRICTION
- ALWAYS create the actual `docs/prd.md` file instead of just replying with text.
- DO NOT automatically jump to the Design step. Must wait for User command.

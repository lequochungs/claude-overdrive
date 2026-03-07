---
description: Implement Tasks from Roadmap (Code + Test + Docs)
---

# /code - Incremental Implementation Workflow

This command executes the programming work based on the agreed-upon Roadmap.

## Precondition
- Must have the `docs/roadmap.md` file with at least one uncompleted task (`[ ]`).

## Workflow

### Step 1: Transition to EXECUTION Mode
**CRITICAL**: Call the `task_boundary` tool.
- Mode: `EXECUTION`
- TaskName: `Incremental Roadmap Implementation`
- TaskStatus: `Picking the next task from roadmap.`

### Step 2: Identify Next Task
- Read `docs/roadmap.md`.
- Find the first Task marked with `[ ]`.
- Determine scope: Which files need modification? What Tests need to be written? Which Docs need updating?

### Step 3: Atomic Implementation
**Each execution of `/code` will handle 01 Task in its entirety**:

1. **Write Code**: Implement feature logic.
2. **Write Tests**: Write corresponding Unit or Integration Tests.
3. **Write/Update Docs**: Update documentation or code comments.
4. **Verification**: Run tests. If they fail, fix until they pass.

### Step 4: Mark Progress
- Once the Task is Verified OK, update `docs/roadmap.md`: Change `[ ]` to `[x]`.

### Step 5: Notify User & Wait
- Call `notify_user`.
- Message: "I have completed Task: **{Task Name}** (including Code + Test + Docs). I've marked it as complete in the Roadmap. Should we move to the next task, or would you like to review this one?"
- BlockedOnUser: `true`

---

## 🛑 CRITICAL RESTRICTION
- ONLY handle exactly 01 Task per command execution to ensure quality and User control.
- DO NOT mark as done until tests pass.

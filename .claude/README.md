# 🚀 Claude Overdrive (Core Injection)

Welcome to **Claude Overdrive**! This kit supercharges Anthropic's Claude Code CLI with **700+ specialized agent skills** and **20+ automated workflow commands**. It transforms Claude Code from a simple coding assistant into a fully-fledged Autonomous Software Engineer.

## 📦 Installation (The Creative Way)

Forget manual copying. Use these "Developer-First" methods to power up your projects instantly.

### Method 0: The NPX Boilerplate Generator (Fastest)
The absolute fastest way to start a new project from scratch. Run this in an empty directory:
```bash
npx github:lequochungs/claude-overdrive my-new-agent
```
*This command clones the entire boilerplate structure, sets up the workspace, and prepares the Overdrive core.*

---

### Method 1: The One-Line Injector (Existing Projects)
If you already have a project and just want to "inject" the Overdrive brain:
```bash
curl -sSL https://raw.githubusercontent.com/lequochungs/claude-overdrive/main/.claude/install.sh | bash
```
*This command only adds the `.claude` folder and setup scripts to your existing folder.*

---

### Method 2: The Magic Installer (Local Project)
If you have this toolkit downloaded, just run the setup script from your project root:
```bash
sh /path/to/claude-overdrive/setup.sh
```
*This script will give you a beautiful UI to choose between **Fast Merge**, **Live Symlink**, or **Global Install**.*

---

### Method 2: The "Hacker" Shortcut (One Command Anywhere)
For the ultimate power user, add this function to your `~/.zshrc` (or `~/.bashrc`):

```bash
# Paste this into your ~/.zshrc
function claude-inject() {
  local KIT="/Users/hung/Development/working/lequochungs/social-claw/.claude"
  mkdir -p .claude/commands .claude/skills
  cp -R "$KIT/commands/"* .claude/commands/ 2>/dev/null
  cp -R "$KIT/skills/"* .claude/skills/ 2>/dev/null
  echo "🚀 Claude Overdrive injected into $(pwd)"
}
```
Now, whenever you start a new project, just type:
```bash
claude-inject
```
*Boom. 700+ skills and all workflows are ready to roll.*

**How to Share with Friends & Team:**
Want to give this superpower to a friend? Just send them the `claude-overdrive.zip` file.
They just need to unzip it and run the `setup.sh` script to power up their projects.

---

## 💡 Interative Developer Workflow

This kit follows a professional, document-driven workflow that keeps you in control:

1.  **Phase 1: Discovery** &rarr; Chat with Claude about your idea.
2.  **Phase 2: PRD (`/plan`)** &rarr; Claude creates `docs/prd.md`. You review and approve.
3.  **Phase 3: Design (`/design`)** &rarr; Claude creates:
    - `docs/architecture.md` (System Design)
    - `docs/diagram_flow.md` (Mermaid Flows)
    - `docs/roadmap.md` (Step-by-step Tasks)
4.  **Phase 4: Implementation (`/code`)** &rarr; Claude processes **item-by-item** from the Roadmap.
    - For each item, Claude writes: **Code + Tests + Update Docs**.
    - Claude runs tests to verify before marking the item as `[x]` in the Roadmap.
    - Claude stops and waits for your "OK" after each task.

---

## ⚡ Core Workflow Commands

| Command | Category | Description |
|---------|----------|-------------|
| **`/init`** | Setup | Detects tech stack and initializes the environment. |
| **`/plan`** | Product | Creates `docs/prd.md` based on your chat history. |
| **`/design`** | Architecture| Creates Architecture, Mermaid Flows, and `docs/roadmap.md`. |
| **`/code`** | Execution | **Roadmap Runner.** Implements tasks one-by-one (Code + Test + Docs). |
| **`/cook`** | Full Auto | **The magic command.** Runs the entire pipeline automatically for MVPs. |
| **`/fix`** | Debugging | Systematic 4-phase debugging (Investigate -> Fix -> Verify). |
| **`/test`** | QA | Generates and runs tests targeting >80% coverage. |
| **`/review`** | QA | Deep code review for Security, Performance (N+1), and Quality. |
| **`/audit`** | Security | Production code scan for vulnerabilities. |
| **`/deploy`** | Operations | Prepares and triggers deployment workflows. |

---

*Note: For maximum effectiveness, ensure your root project directory contains the master `CLAUDE.md` rules file.*

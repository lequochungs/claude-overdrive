---
description: Initialize Claude for a new project
---

# /init - Initialize Claude

## 🎯 Purpose
Initialize the Claude system for the project, helping the AI understand the context and get ready for development.

## ⚡ Workflow

### Step 1: Load System Configuration
```bash
# Read CLAUDE.md to understand system rules
cat CLAUDE.md
```

### Step 2: Analyze Project
// turbo
```bash
# View project structure
ls -la
find . -maxdepth 2 -type f -name "*.json" 2>/dev/null | head -5
find . -maxdepth 2 -type f -name "*.md" 2>/dev/null | head -10
```

### Step 3: Detect Project Type

**Auto-detect:**
- `package.json` → Node.js/TypeScript
- `composer.json` → PHP/Laravel
- `requirements.txt` → Python
- `go.mod` → Go
- `Cargo.toml` → Rust

### Step 4: Create/Update Project Config

Create `.claude/project.json`:
```json
{
  "name": "{detected-name}",
  "type": "{detected-type}",
  "language": "{detected-language}",
  "framework": "{detected-framework}",
  "commands": {
    "test": "{test-command}",
    "lint": "{lint-command}",
    "build": "{build-command}",
    "dev": "{dev-command}"
  },
  "autoRun": {
    "tests": true,
    "lint": true,
    "deploy": false
  },
  "initialized": "{current-date}"
}
```

### Step 5: Output

```
╔═══════════════════════════════════════════════════════════════════╗
║      🚀 CLAUDE AI DEV - INITIALIZED                                    ║
╠═══════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  📁 Project: {name}                                                ║
║  💻 Language: {language}                                           ║
║  🔧 Framework: {framework}                                         ║
║                                                                    ║
╠═══════════════════════════════════════════════════════════════════╣
║  📋 AVAILABLE COMMANDS                                             ║
║                                                                    ║
║  🔥 /cook [request]  - Full Auto: Request → MVP                   ║
║  📝 /plan [feature]  - Create PRD                                  ║
║  🏗️ /design          - System Design                               ║
║  👨‍💻 /code            - Implement Code                              ║
║  🧪 /test            - Run Tests                                   ║
║  👁️ /review          - Code Review                                 ║
║  🔧 /fix [issue]     - Fix Bugs                                    ║
║  📤 /git             - Git Operations                              ║
║                                                                    ║
╠═══════════════════════════════════════════════════════════════════╣
║  💡 QUICK START                                                    ║
║                                                                    ║
║  Just tell me what you want to build:                              ║
║  "Build an e-commerce app with user auth and payment"              ║
║                                                                    ║
║  Or use explicit command:                                          ║
║  /cook Build a task management application                         ║
║                                                                    ║
╚═══════════════════════════════════════════════════════════════════╝

🎯 Ready! What would you like me to build?
```

---

## 🔄 Auto-Trigger

This workflow automatically runs when:
1. User first opens a conversation in the project
2. User says "init", "start", "begin", "initialize"
3. `.claude/project.json` is missing

---

## 📝 Notes

- If the project already has `.claude/project.json`, only show Quick Start
- If it's a new project, create the full structure

---

## 🛑 CRITICAL RESTRICTION FOR /init

When executing the `/init` workflow, you MUST ONLY perform the environment detection, create the `.claude/project.json` file, and print the Welcome Box. 
You are STRICTLY FORBIDDEN from generating any project code, scaffolding applications, modifying configurations outside of `.claude`, or running any package installation commands (like npm install) unless explicitly instructed by the user via `/cook` or `/code`.

---

**Claude** - *Transforming Ideas into Software Automatically*

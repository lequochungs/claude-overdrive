---
description: ▶️ Chạy ứng dụng - The Application Launcher
---

# WORKFLOW: /run - Smart Application Launcher

> **Role**: Claude Operator  
> **Mission**: Làm mọi cách để app LÊN SÓNG
> **Principle**: "User chỉ cần gõ /run, còn lại AI lo"



---

## 🎯 Mục đích

Workflow này:
- Auto-detect project type
- Handle dependencies
- Resolve port conflicts
- Start application
- Monitor for errors

---

## Phase 1: Environment Detection 🔍

### 1.1 Auto-Scan Project

```bash
# Detection priority order
1. docker-compose.yml    → Docker Mode
2. Dockerfile           → Docker Build Mode
3. package.json + dev   → Node.js Mode
4. requirements.txt     → Python Mode
5. go.mod               → Go Mode
6. Cargo.toml           → Rust Mode
7. Makefile             → Make Mode
```

### 1.2 Mode Selection (if multiple)

```markdown
"Em thấy dự án này có thể chạy nhiều cách:"

┌─────────────────────────────────────────────────┐
│ A) 🐳 Docker                                    │
│    → Giống môi trường production               │
│    → Isolate dependencies                      │
│                                                  │
│ B) 📦 Node.js trực tiếp                        │
│    → Nhanh hơn, dễ debug                       │
│    → Hot reload                                │
│                                                  │
│ C) 🐍 Python venv                              │
│    → Virtual environment                       │
│    → Isolated packages                         │
└─────────────────────────────────────────────────┘
```

---

## Phase 2: Pre-Run Checks ✅

### 2.1 Dependencies Check

```bash
# Node.js
if [ ! -d "node_modules" ]; then
  echo "📦 Installing dependencies..."
  npm install
fi

# Python
if [ ! -d "venv" ]; then
  echo "🐍 Creating virtual environment..."
  python -m venv venv
  source venv/bin/activate
  pip install -r requirements.txt
fi
```

### 2.2 Port Check

```bash
# Check if port is in use
lsof -i :3000

# If occupied:
"Port 3000 đang bị app khác dùng."
"Anh muốn:"
"A) Kill process đang dùng port đó"
"B) Chạy port khác (3001)"
```

### 2.3 Environment Variables Check

```markdown
□ .env file exists?
□ Required variables set?
□ No placeholder values?
```

---

## Phase 3: Launch & Monitor 🚀

### 3.1 Start Commands

```bash
# Node.js (npm)
npm run dev

# Node.js (yarn)
yarn dev

# Node.js (pnpm)
pnpm dev

# Python FastAPI
uvicorn main:app --reload

# Python Flask
flask run --debug

# Docker
docker compose up

# Docker build
docker build -t app . && docker run -p 3000:3000 app

# Go
go run .

# Rust
cargo run
```

### 3.2 Monitor Output

```markdown
Watch for success indicators:
✅ "Ready on http://..."
✅ "Server running on port..."
✅ "Listening at..."
✅ "Development server started"

Watch for failure indicators:
❌ "Error:"
❌ "EADDRINUSE" (port conflict)
❌ "Cannot find module"
❌ "ModuleNotFoundError"
❌ "Syntax error"
❌ "ENOENT" (file not found)
```

### 3.3 Error Recovery

```markdown
If error detected:

1. EADDRINUSE (Port in use):
   → Kill process: kill -9 $(lsof -t -i:3000)
   → Or use different port

2. Cannot find module:
   → npm install <missing-module>
   → Retry

3. Env variable missing:
   → "Thiếu biến môi trường: DATABASE_URL"
   → "Anh cần thêm vào file .env"

4. Syntax error:
   → Show error location
   → Suggest /debug
```

---

## Phase 4: Success Handover 🎉

### 4.1 Success Message

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
▶️ APP RUNNING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌐 Local:   http://localhost:3000
🌐 Network: http://192.168.1.100:3000

Mode: Development
Hot Reload: Enabled
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

"Anh mở trình duyệt và truy cập để xem."
"Nếu cần chỉnh giao diện, gõ /visualize"
```

### 4.2 Failure Message

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
❌ APP FAILED TO START
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Error: [Error message]
File: [File location if known]

Possible cause: [Analysis]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Options:
1. Em thử fix tự động
2. /debug để điều tra chi tiết
3. Xem logs chi tiết
```

---

## Quick Reference Commands 📋

### Node.js Projects

```bash
# Development
npm run dev           # Start dev server
npm start             # Start production
npm run build         # Build for production

# Package management
npm install           # Install all deps
npm install <pkg>     # Add package
npm update            # Update packages

# Common issues
rm -rf node_modules && npm install  # Clean install
npm cache clean --force              # Clear cache
```

### Python Projects

```bash
# Virtual environment
python -m venv venv
source venv/bin/activate  # Mac/Linux
.\venv\Scripts\activate   # Windows

# Dependencies
pip install -r requirements.txt
pip freeze > requirements.txt

# Run
python app.py
uvicorn main:app --reload
flask run --debug
```

### Docker Projects

```bash
# Build and run
docker compose up
docker compose up -d          # Detached
docker compose up --build     # Rebuild

# Logs
docker compose logs -f

# Stop
docker compose down
docker compose down -v        # Remove volumes
```

---

## ⚠️ NEXT STEPS

```
1️⃣ App chạy OK? → /visualize để chỉnh UI, hoặc /code tiếp
2️⃣ App lỗi? → /debug để sửa
3️⃣ Muốn dừng app? → Ctrl+C hoặc /stop
4️⃣ Ready deploy? → /deploy
5️⃣ Lưu tiến độ? → /save-brain
```

---

## 💡 RUN TIPS

| Tip | Description |
|-----|-------------|
| Keep terminal visible | Watch for errors in real-time |
| Use hot reload | Save file = auto refresh |
| Check console | Browser DevTools for frontend errors |
| Multiple terminals | Frontend + Backend separately |

---

*"The best code is code that runs."*


---

## 🛑 CRITICAL RESTRICTION
DO NOT automatically proceed to any other workflow, command, or phase. 
You MUST stop execution here and WAIT for the user to explicitly type the next command.

---
description: 📊 Xem Plans Dashboard - Visual project progress tracking
---

# /kanban - Plans Dashboard Workflow

Hiển thị visual dashboard cho plans với progress tracking và timeline.

## Quick Usage

```bash
# Xem dashboard cho plans/
/kanban plans/

# Stop kanban server
/kanban --stop
```

## Steps

### Step 1: Check Skill Installation
// turbo

Kiểm tra xem skill `plans-kanban` đã được cài đặt dependencies chưa:

```bash
# Check if node_modules exists
ls -la .agent/skills/plans-kanban/scripts/node_modules || echo "Need to install"
```

Nếu chưa có, chạy:
```bash
cd .agent/skills/plans-kanban/scripts && npm install
```

### Step 2: Start Dashboard Server
// turbo

Chạy kanban server với plans directory:

```bash
node .agent/skills/plans-kanban/scripts/server.cjs \
  --dir ./plans \
  --open
```

### Step 3: Report

Trả lại URL cho user và hướng dẫn:

```
✅ Kanban Dashboard đang chạy:
   - Local URL: http://localhost:3500/kanban
   - Plans Directory: ./plans

💡 Để dừng server: /kanban --stop
```

## Features

Dashboard hiển thị:
- 📊 Progress bars cho mỗi plan
- 📅 Timeline/Gantt visualization
- 🎯 Phase status indicators (completed, in-progress, pending)
- 🔥 Activity heatmap
- 📝 Last modified timestamps

## Remote Access

Để truy cập từ thiết bị khác trên cùng network:

```bash
node .agent/skills/plans-kanban/scripts/server.cjs \
  --dir ./plans \
  --host 0.0.0.0 \
  --open
```

Sẽ hiển thị NetworkURL để truy cập từ mobile hoặc device khác.


---

## 🛑 CRITICAL RESTRICTION
DO NOT automatically proceed to any other workflow, command, or phase. 
You MUST stop execution here and WAIT for the user to explicitly type the next command.

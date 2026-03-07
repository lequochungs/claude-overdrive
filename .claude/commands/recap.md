---
description: 🧠 Tóm tắt dự án - The Memory Retriever
---

# WORKFLOW: /recap - Context Recovery System

> **Role**: Claude Historian  
> **Mission**: Giúp user "Nhớ lại tất cả" trong 2 phút
> **Principle**: "Read Everything, Summarize Simply"



---

## 🎯 Mục đích

Workflow này khôi phục context khi:
- Bắt đầu ngày làm việc mới
- Quay lại sau thời gian nghỉ
- Onboard vào dự án đang chạy
- Resume work sau khi context bị clear

---

## Phase 1: Deep Context Scan 🔍

### 1.1 Auto-Scan Sources (KHÔNG hỏi User)

```bash
# Scan theo thứ tự ưu tiên
1. docs/specs/           # Tìm Spec đang "In Progress"
2. docs/architecture/    # Hiểu kiến trúc tổng thể
3. docs/reports/         # Xem audit reports gần nhất
4. .agent/knowledge/    # Đọc Knowledge Items
5. package.json          # Xác định tech stack
6. CHANGELOG.md          # Xem thay đổi gần đây
```

### 1.2 Git Analysis

```bash
# 10 commits gần nhất
git log -10 --oneline --date=short --format="%h %ad %s"

# Files đang thay đổi dở
git status --short

# Branch hiện tại
git branch --show-current

# Stashed changes
git stash list
```

### 1.3 Work-in-Progress Detection

Tìm các dấu hiệu công việc dang dở:
- Files có comment `// TODO:`
- Specs với status `In Progress`
- Tests đang fail
- Draft PRs

---

## Phase 2: Executive Summary Generation 📋

### 2.1 Summary Template

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 **TÓM TẮT DỰ ÁN: [Project Name]**
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 **Dự án này làm gì:** 
   [1-2 câu mô tả ngắn gọn]

🛠️ **Tech Stack:**
   Frontend: [React/Vue/...] 
   Backend: [Node/Python/...]
   Database: [PostgreSQL/MongoDB/...]

📍 **Lần cuối chúng ta đang làm:**
   - Feature: [Tên tính năng/Module]
   - Trạng thái: [🔨 Đang code | 🧪 Đang test | 🐛 Đang fix bug]
   - Progress: [XX%]

📂 **Các file đang focus:**
   1. `src/services/PaymentService.ts` - Payment logic
   2. `src/api/routes/payment.ts` - API endpoints
   3. `tests/payment.test.ts` - Unit tests

⏭️ **Việc cần làm tiếp theo:**
   □ Task 1: [Mô tả]
   □ Task 2: [Mô tả]
   □ Task 3: [Mô tả]

⚠️ **Lưu ý quan trọng:**
   - [Bug đang pending / Blocker]
   - [Deadline nếu có]
   - [Dependencies cần chờ]

📊 **Git Status:**
   Branch: `feature/payment-integration`
   Uncommitted: 3 files
   Last commit: "Add VNPay webhook handler" (2h ago)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2.2 Context Confidence Score

```
📈 Context Confidence: [HIGH/MEDIUM/LOW]

HIGH (90%+): Có đầy đủ docs, specs, recent commits
MEDIUM (60-89%): Thiếu một số docs nhưng có git history
LOW (<60%): Ít thông tin, cần hỏi thêm user
```

---

## Phase 3: Smart Recommendations 🎯

### 3.1 Direction Options

```markdown
"Anh muốn làm gì tiếp?"

┌─────────────────────────────────────────────────┐
│ A) 🔨 Tiếp tục việc dang dở                     │
│    → Gợi ý: /code hoặc /debug                   │
│                                                  │
│ B) ✨ Làm tính năng mới                         │
│    → Gợi ý: /plan                               │
│                                                  │
│ C) 🔍 Kiểm tra tổng thể trước                   │
│    → Gợi ý: /audit                              │
│                                                  │
│ D) 🎨 Chỉnh sửa giao diện                       │
│    → Gợi ý: /visualize                          │
│                                                  │
│ E) 🚀 Deploy lên production                     │
│    → Gợi ý: /deploy                             │
└─────────────────────────────────────────────────┘
```

### 3.2 Auto-Suggestion Logic

```
IF has_failing_tests:
    suggest "/test" first
ELIF has_uncommitted_changes:
    suggest "/git" to commit
ELIF has_in_progress_spec:
    suggest "/code" to continue
ELIF recent_bug_report:
    suggest "/debug"
ELSE:
    suggest "/plan" for new feature
```

---

## Phase 4: Quick Actions ⚡

### 4.1 One-Click Resume

```markdown
Để tiếp tục ngay, gõ:

`/code Tiếp tục implement [feature đang làm dở]`

Em sẽ:
1. Đọc lại spec liên quan
2. Review code đã viết
3. Tiếp tục từ điểm dừng
```

### 4.2 Context Refresh

```markdown
Nếu cần refresh thêm context:

- `/recap --deep` → Scan toàn bộ codebase
- `/recap --git` → Focus vào git history
- `/recap --docs` → Focus vào documentation
```

---

## ⚠️ NEXT STEPS

```
1️⃣ Tiếp tục việc dang dở? → /code hoặc /debug
2️⃣ Làm tính năng mới? → /plan
3️⃣ Kiểm tra tổng thể? → /audit
4️⃣ Xem giao diện? → /visualize
5️⃣ Deploy? → /deploy
```

---

## 💡 TIPS

| Best Practice | Description |
|---------------|-------------|
| Morning ritual | `/recap` mỗi sáng trước khi làm việc |
| After context clear | `/recap` ngay sau khi clear chat |
| Before handover | `/recap` để verify đã save hết knowledge |
| End of day | `/save-brain` để mai `/recap` dễ hơn |

---

## Integration với Workflows khác

```mermaid
graph LR
    A[/recap] --> B{Chọn action}
    B --> C[/code]
    B --> D[/plan]
    B --> E[/debug]
    B --> F[/audit]
    B --> G[/deploy]
    
    C --> H[/save-brain]
    D --> H
    E --> H
```

---

*"Yesterday's context is today's productivity."*


---

## 🛑 CRITICAL RESTRICTION
DO NOT automatically proceed to any other workflow, command, or phase. 
You MUST stop execution here and WAIT for the user to explicitly type the next command.

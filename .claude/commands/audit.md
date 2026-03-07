---
description: 🏥 Kiểm tra code & bảo mật - The Code Doctor
---

# WORKFLOW: /audit - Comprehensive Health Check

> **Role**: Claude Code Auditor  
> **Mission**: Khám tổng quát và đưa ra "Phác đồ điều trị"
> **Principle**: "Prevent is better than cure"



---

## 🎯 Mục đích

Workflow này thực hiện:
- Security audit (OWASP Top 10)
- Code quality analysis
- Performance bottleneck detection
- Dependency vulnerability scan
- Documentation completeness check

---

## Phase 1: Scope Selection 🎯

```markdown
"Anh muốn kiểm tra phạm vi nào?"

┌─────────────────────────────────────────────────┐
│ A) ⚡ Quick Scan (5 phút)                        │
│    → Chỉ kiểm tra critical issues               │
│                                                  │
│ B) 🔍 Full Audit (15-30 phút)                   │
│    → Kiểm tra toàn diện                          │
│                                                  │
│ C) 🔐 Security Focus                            │
│    → Chỉ tập trung bảo mật                       │
│                                                  │
│ D) 🚀 Performance Focus                         │
│    → Chỉ tập trung hiệu năng                     │
│                                                  │
│ E) 📦 Dependencies Focus                        │
│    → Kiểm tra packages vulnerabilities           │
└─────────────────────────────────────────────────┘
```

---

## Phase 2: Deep Scan 🔬

### 2.1 Security Audit 🔐

#### Authentication
```markdown
□ Password được hash đúng cách (bcrypt/argon2)?
□ Session/Token có HttpOnly, Secure flags?
□ Rate limiting cho login (prevent brute force)?
□ Account lockout sau N lần fail?
□ Password policy đủ mạnh?
□ 2FA có sẵn (nếu cần)?
```

#### Authorization
```markdown
□ Check quyền TRƯỚC KHI trả data?
□ RBAC (Role-based access control)?
□ Resource ownership validation?
□ Không có IDOR (Insecure Direct Object Reference)?
□ API endpoints có authorization?
```

#### Input Validation
```markdown
□ Sanitize tất cả user input?
□ SQL Injection protected (parameterized queries)?
□ XSS protected (escape output)?
□ Path traversal protected?
□ File upload validation?
□ CSRF tokens?
```

#### Secrets Management
```markdown
□ Không hardcode API keys trong code?
□ .env files trong .gitignore?
□ Secrets không log ra console?
□ Environment-specific configs?
□ Secure secret rotation process?
```

### 2.2 Code Quality Audit 📊

#### Dead Code
```bash
# Find unused exports
npx ts-prune

# Find unused dependencies
npx depcheck

# Find unused files
# Custom analysis
```

#### Code Duplication
```markdown
□ Đoạn code lặp lại > 3 lần → Extract function
□ Similar components → Create base component
□ Copy-paste logic → Create utility
```

#### Complexity
```markdown
□ Function > 50 lines → Split
□ Nested if/else > 3 levels → Flatten/Extract
□ File > 300 lines → Modularize
□ Cyclomatic complexity > 10 → Refactor
```

#### Naming
```markdown
□ Không có tên vô nghĩa: a, b, x, temp, data
□ Consistent naming convention (camelCase/snake_case)
□ Boolean bắt đầu bằng is/has/should
□ Functions mô tả action (verb)
```

#### Technical Debt
```markdown
□ Scan TODO/FIXME comments
□ Outdated comments
□ Deprecated dependencies
□ Magic numbers/strings
```

### 2.3 Performance Audit 🚀

#### Database
```markdown
□ N+1 queries detected?
□ Missing indexes?
□ Slow queries (> 100ms)?
□ Connection pooling configured?
□ Query caching enabled?
```

```sql
-- Example: Find slow queries (PostgreSQL)
SELECT query, calls, mean_time, total_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;
```

#### Frontend
```markdown
□ Component re-renders không cần thiết (React)?
□ Bundle size < 200KB (gzipped)?
□ Images optimized (WebP, lazy loading)?
□ Code splitting implemented?
□ Memoization cho expensive computations?
```

#### API
```markdown
□ Response size hợp lý (< 1MB)?
□ Pagination cho list endpoints?
□ Caching headers (ETag, Cache-Control)?
□ Compression enabled (gzip/brotli)?
□ Connection keep-alive?
```

### 2.4 Dependencies Audit 📦

```bash
# NPM audit
npm audit

# Yarn audit  
yarn audit

# Check outdated
npm outdated

# Security scan
npx snyk test
```

```markdown
□ No critical vulnerabilities?
□ No high vulnerabilities?
□ Dependencies up to date?
□ No unused packages?
□ License compliance?
```

### 2.5 Documentation Audit 📝

```markdown
□ README complete và up-to-date?
□ API documentation available?
□ Setup instructions clear?
□ Environment variables documented?
□ Architecture diagrams current?
□ Inline comments cho complex logic?
```

---

## Phase 3: Report Generation 📋

### 3.1 Report Template

```markdown
# Audit Report - [Date]

## Executive Summary
- 🔴 Critical Issues: X
- 🟡 Warnings: Y  
- 🟢 Suggestions: Z
- 📊 Overall Health Score: XX/100

---

## 🔴 Critical Issues (Phải sửa ngay)

### 1. [Issue Title]
- **File:** `src/api/users.ts:45`
- **Type:** Security / SQL Injection
- **Risk:** Hacker có thể xóa sạch database
- **Evidence:**
  \`\`\`typescript
  // BAD: Vulnerable to SQL injection
  const query = `SELECT * FROM users WHERE id = ${userId}`;
  \`\`\`
- **Fix:**
  \`\`\`typescript
  // GOOD: Parameterized query
  const query = 'SELECT * FROM users WHERE id = $1';
  const result = await db.query(query, [userId]);
  \`\`\`
- **Effort:** 15 minutes

---

## 🟡 Warnings (Nên sửa)

### 1. [Warning Title]
- **File:** `src/services/OrderService.ts`
- **Type:** Performance / N+1 Query
- **Impact:** Trang load chậm khi có nhiều orders
- **Current:** 100 orders = 101 queries
- **Optimal:** 100 orders = 2 queries
- **Fix:** Use eager loading with includes

---

## 🟢 Suggestions (Tùy chọn)

### 1. [Suggestion Title]
- **File:** `src/utils/helpers.ts`
- **Type:** Code Quality
- **Description:** Có thể extract thành utility function
- **Benefit:** Giảm duplicate code, dễ maintain

---

## Next Steps

Priority order:
1. [ ] Fix critical security issues
2. [ ] Address performance bottlenecks
3. [ ] Clean up code quality warnings
4. [ ] Update documentation
```

---

## Phase 4: Explanation (Plain Language) 🗣️

### Translation Examples

| Technical | Plain Vietnamese |
|-----------|-----------------|
| SQL Injection vulnerability | Hacker có thể gõ code vào ô input để xóa database |
| N+1 query | Load 100 items gọi DB 101 lần thay vì 2 lần |
| XSS vulnerability | Ai đó có thể inject script đánh cắp cookie user |
| Missing rate limiting | Bot có thể spam login không giới hạn |
| Memory leak | App càng chạy lâu càng ngốn RAM, cuối cùng crash |

---

## Phase 5: Action Plan 🎬

```markdown
📋 Anh muốn làm gì tiếp theo?

┌─────────────────────────────────────────────────┐
│ 1️⃣ Xem báo cáo chi tiết trước                   │
│                                                  │
│ 2️⃣ Sửa lỗi Critical ngay → /code               │
│                                                  │
│ 3️⃣ Dọn dẹp code smell → /refactor              │
│                                                  │
│ 4️⃣ Bỏ qua, lưu báo cáo → /save-brain           │
│                                                  │
│ 5️⃣ 🔧 FIX ALL - Tự động sửa TẤT CẢ             │
│    (Chỉ các lỗi có thể auto-fix)                │
└─────────────────────────────────────────────────┘

Gõ số (1-5) để chọn:
```

---

## Phase 6: Fix All Mode 🔧

### 6.1 Auto-Fix Categories

| Category | Auto-Fix | Need Review | Manual Only |
|----------|----------|-------------|-------------|
| Dead code | ✅ | | |
| Unused imports | ✅ | | |
| Formatting | ✅ | | |
| console.log | ✅ | | |
| Missing .gitignore | ✅ | | |
| API key in code | | ⚠️ | |
| SQL injection | | ⚠️ | |
| Architecture issues | | | ❌ |
| Business logic bugs | | | ❌ |

### 6.2 Fix Execution

```markdown
🔧 Auto-fixing...

✅ Removed 12 unused imports
✅ Deleted 3 dead code files
✅ Formatted 45 files
✅ Removed 8 console.log statements
✅ Added entries to .gitignore

⚠️ Need your review (2 items):
1. API key found in config.ts → Move to .env?
2. Raw SQL query in users.ts → Parameterize?

❌ Manual fix required (1 item):
1. N+1 query in OrderService → Needs refactor

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Summary:
✅ Auto-fixed: 68 issues
⚠️ Pending review: 2 issues
❌ Manual required: 1 issue
```

---

## ⚠️ NEXT STEPS

```
1️⃣ Chạy /test để kiểm tra sau khi sửa
2️⃣ Chạy /save-brain để lưu báo cáo
3️⃣ Tiếp tục /audit để scan lại
4️⃣ /refactor để dọn dẹp code
5️⃣ /deploy nếu ready
```

---

## 💡 AUDIT SCHEDULE

| Frequency | Type | Focus |
|-----------|------|-------|
| Daily | Quick Scan | New code changes |
| Weekly | Full Audit | Complete codebase |
| Pre-release | Security Focus | Before production |
| Monthly | Dependencies | Package updates |

---

*"The best code is code that doesn't need debugging."*


---

## 🛑 CRITICAL RESTRICTION
DO NOT automatically proceed to any other workflow, command, or phase. 
You MUST stop execution here and WAIT for the user to explicitly type the next command.

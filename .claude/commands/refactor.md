---
description: 🧹 Dọn dẹp & tối ưu code - The Code Gardener
---

# WORKFLOW: /refactor - Safe Code Cleanup

> **Role**: Senior Code Reviewer  
> **Mission**: Làm đẹp code mà KHÔNG thay đổi logic
> **Principle**: "User SỢ NHẤT là sửa xong hỏng"



---

## 🎯 Mục đích

Workflow này đảm bảo:
- Code sạch hơn, dễ đọc hơn
- Logic nghiệp vụ giữ nguyên 100%
- Không introduce new bugs
- Có backup trước khi refactor

---

## Phase 1: Scope & Safety 🛡️

### 1.1 Define Scope

```markdown
"Anh muốn dọn dẹp phạm vi nào?"

┌─────────────────────────────────────────────────┐
│ A) 📄 1 file cụ thể                             │
│    → An toàn nhất, recommend                    │
│                                                  │
│ B) 📁 1 module/feature                          │
│    → Vừa phải, cần cẩn thận                    │
│                                                  │
│ C) 🌐 Toàn bộ project                           │
│    → Risk cao, cần có tests                     │
└─────────────────────────────────────────────────┘
```

### 1.2 Safety Commitment

```markdown
🔒 CAM KẾT AN TOÀN:

"Em cam kết: Logic nghiệp vụ giữ nguyên 100%"
"Chỉ thay đổi CÁCH VIẾT, không thay đổi CÁCH CHẠY"

Before: function works ✅
After: function works ✅ + code đẹp hơn
```

### 1.3 Backup Strategy

```markdown
"Trước khi refactor, anh có muốn tạo backup?"

┌─────────────────────────────────────────────────┐
│ A) ✅ Tạo backup branch (Recommend)             │
│    → git checkout -b backup/before-refactor     │
│                                                  │
│ B) ⏭️ Skip, có tests rồi                        │
│    → Chỉ khi có test coverage tốt               │
│                                                  │
│ C) 📸 Tạo stash                                 │
│    → git stash push -m "pre-refactor"          │
└─────────────────────────────────────────────────┘
```

---

## Phase 2: Code Smell Detection 👃

### 2.1 Structural Issues

| Smell | Detection | Threshold |
|-------|-----------|-----------|
| Long Function | Lines of code | > 50 lines → Split |
| Deep Nesting | If/else levels | > 3 levels → Flatten |
| Large File | Total lines | > 300 lines → Modularize |
| God Object | Responsibilities | > 5 concerns → Split |
| Long Parameter List | Params count | > 4 params → Use object |

### 2.2 Naming Issues

```typescript
// ❌ BAD: Vague names
const d = new Date();
const u = getUser();
const arr = items.filter(x => x.active);
const temp = calculate(a, b);

// ✅ GOOD: Descriptive names
const currentDate = new Date();
const authenticatedUser = getUser();
const activeItems = items.filter(item => item.isActive);
const totalDiscount = calculateDiscount(price, quantity);
```

### 2.3 Naming Convention Check

```markdown
□ camelCase for variables/functions
□ PascalCase for classes/components
□ UPPER_SNAKE for constants
□ kebab-case for files
□ Boolean starts with is/has/should/can
□ Functions describe actions (verbs)
□ No abbreviations unless common (e.g., id, url)
```

### 2.4 Code Duplication

```typescript
// ❌ BEFORE: Duplicated logic
function getActiveUsers() {
  const users = await db.users.findAll();
  return users.filter(u => u.status === 'active' && !u.deleted);
}

function getActiveAdmins() {
  const admins = await db.admins.findAll();
  return admins.filter(a => a.status === 'active' && !a.deleted);
}

// ✅ AFTER: Extracted common logic
function filterActive<T extends { status: string; deleted: boolean }>(items: T[]): T[] {
  return items.filter(item => item.status === 'active' && !item.deleted);
}

const getActiveUsers = async () => filterActive(await db.users.findAll());
const getActiveAdmins = async () => filterActive(await db.admins.findAll());
```

### 2.5 Outdated Code

```markdown
Scan and remove:
□ Dead code (unreachable)
□ Commented out code (Git has history)
□ Unused imports
□ Unused variables
□ Deprecated packages
□ console.log/debugger statements
□ TODO/FIXME older than 30 days
```

### 2.6 Missing Best Practices

| Issue | Fix |
|-------|-----|
| No TypeScript types | Add interfaces/types |
| No error handling | Add try-catch |
| No JSDoc | Add documentation |
| Magic numbers | Extract to constants |
| Hardcoded strings | Extract to config |

---

## Phase 3: Refactoring Plan 📋

### 3.1 Change List

```markdown
📋 Em sẽ thực hiện những thay đổi sau:

1. 🔨 **Split Function**
   - File: `src/services/OrderService.ts`
   - Before: `processOrder()` (120 lines)
   - After: 4 smaller functions
     - `validateOrder()`
     - `calculateTotals()`
     - `applyDiscounts()`
     - `saveOrder()`

2. ✏️ **Rename Variables**
   - `d` → `orderDate`
   - `u` → `currentUser`
   - `arr` → `filteredProducts`

3. 🗑️ **Remove Dead Code**
   - 3 unused imports
   - 1 unreachable function
   - 15 lines commented code

4. 📝 **Add Documentation**
   - JSDoc for 5 public functions
   - README update for new structure

5. 🧹 **Format & Lint**
   - Prettier for consistency
   - ESLint fixes

Estimated time: 30 minutes
Risk level: LOW (logic unchanged)
```

### 3.2 Approval

```markdown
"Anh OK với kế hoạch này không?"

[Y/N hoặc chỉnh sửa requirements]
```

---

## Phase 4: Safe Execution 🔧

### 4.1 Micro-Steps Approach

```markdown
Thực hiện từng bước nhỏ:

Step 1: Extract function A ✓
        → Verify: Code compiles ✓
        → Verify: Tests pass ✓

Step 2: Rename variable B ✓
        → Verify: No reference errors ✓

Step 3: Remove dead code C ✓
        → Verify: No breaking changes ✓

[Continue for each change...]
```

### 4.2 Refactoring Patterns

#### Extract Function
```typescript
// BEFORE
function processOrder(order) {
  // 50 lines of validation
  // 30 lines of calculation
  // 20 lines of saving
}

// AFTER
function processOrder(order) {
  const validated = validateOrder(order);
  const calculated = calculateTotals(validated);
  return saveOrder(calculated);
}
```

#### Flatten Conditionals
```typescript
// BEFORE: Deep nesting
function process(user) {
  if (user) {
    if (user.active) {
      if (user.verified) {
        return doSomething(user);
      }
    }
  }
  return null;
}

// AFTER: Early returns
function process(user) {
  if (!user) return null;
  if (!user.active) return null;
  if (!user.verified) return null;
  return doSomething(user);
}
```

#### Replace Magic Numbers
```typescript
// BEFORE
if (user.age >= 18 && user.orders > 5 && user.balance > 1000000) {
  applyDiscount(0.15);
}

// AFTER
const LEGAL_AGE = 18;
const VIP_ORDER_THRESHOLD = 5;
const VIP_BALANCE_THRESHOLD = 1_000_000;
const VIP_DISCOUNT_RATE = 0.15;

const isVipEligible = 
  user.age >= LEGAL_AGE &&
  user.orders > VIP_ORDER_THRESHOLD &&
  user.balance > VIP_BALANCE_THRESHOLD;

if (isVipEligible) {
  applyDiscount(VIP_DISCOUNT_RATE);
}
```

### 4.3 Format & Lint

```bash
# Format with Prettier
npx prettier --write "src/**/*.{ts,tsx}"

# Lint with ESLint
npx eslint --fix "src/**/*.{ts,tsx}"

# Type check
npx tsc --noEmit
```

---

## Phase 5: Quality Assurance ✅

### 5.1 Before/After Comparison

```markdown
📊 BEFORE/AFTER COMPARISON

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 src/services/OrderService.ts
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Before:
- Lines: 450
- Functions: 3 (average 150 lines each)
- Complexity: High
- Tests: 60% coverage

After:
- Lines: 380 (-15%)
- Functions: 12 (average 30 lines each)
- Complexity: Low
- Tests: 60% coverage (unchanged)

Logic: ✅ UNCHANGED
Behavior: ✅ IDENTICAL
```

### 5.2 Test Verification

```bash
# Run existing tests
npm test

# Check coverage didn't decrease
npm run test:coverage

# Expected output:
# ✅ All 45 tests passing
# ✅ Coverage: 60% (unchanged)
```

---

## Phase 6: Handover ✅

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧹 REFACTORING COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Đã dọn dẹp: 5 files

✅ Tách 4 functions từ 1 function lớn
✅ Đổi tên 12 biến cho rõ nghĩa
✅ Xóa 45 dòng code thừa
✅ Thêm JSDoc cho 8 functions
✅ Format 15 files

📊 Code Quality Score:
Before: 65/100
After: 85/100 (+20)

⚠️ Logic nghiệp vụ: KHÔNG THAY ĐỔI
✅ All tests: PASSED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

"Anh chạy /test để chắc chắn không có gì bị hỏng."
```

---

## ⚠️ NEXT STEPS

```
1️⃣ Chạy /test để verify không có regression
2️⃣ Có lỗi? → /rollback để quay lại
3️⃣ OK rồi? → /save-brain để lưu changes
4️⃣ Tiếp tục code? → /code
5️⃣ Deploy? → /deploy
```

---

## 💡 REFACTORING RULES

| Rule | Description |
|------|-------------|
| Small Steps | Một thay đổi nhỏ = một commit |
| Test First | Đảm bảo có tests trước khi refactor |
| No New Features | Refactor ≠ Add features |
| Keep It Working | Code phải chạy được sau mỗi step |
| Document Why | Comment lý do nếu không obvious |

---

## 🚫 DO NOT

```markdown
❌ Refactor và thêm feature cùng lúc
❌ Refactor không có tests
❌ Đổi behavior vô tình
❌ Skip testing sau refactor
❌ Refactor critical path trước release
```

---

*"Code should be written to be read by humans first, machines second."*


---

## 🛑 CRITICAL RESTRICTION
DO NOT automatically proceed to any other workflow, command, or phase. 
You MUST stop execution here and WAIT for the user to explicitly type the next command.

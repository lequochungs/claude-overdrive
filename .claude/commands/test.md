---
description: Kiểm thử UI và Logic với Browser Subagent
---

# /test - Native Verification Workflow

## Precondition
- Cần có code ứng dụng đã chạy ở một port cụ thể (ví dụ localhost:3000).

## Workflow

### Step 1: Transition to VERIFICATION Mode
**CRITICAL**: You must call the `task_boundary` tool.
- Mode: `VERIFICATION`
- TaskName: `End-to-End Application Testing`
- TaskStatus: `Commencing verification and UI testing.`

### Step 2: Kích Hoạt Browser Subagent
- Nếu là dự án Web/UI, hãy sử dụng tool `browser_subagent`.
- Cung cấp:
  - TaskName: "Testing E2E Flow for {Feature}"
  - Task: Miêu tả cực kỳ chi tiết các web element cần click, form cần điền.
  - RecordingName: tên file video (vd: "login_test").

### Step 3: Đọc Kết Quả
- SAU KHI subagent chạy xong, hãy cẩn thận đọc Output của nó. 
- Tìm các file Video (.WEBP) hoặc Screenshot (.PNG) trong thư mục Artifacts của não bộ dự án.

### Step 4: Viết Walkthrough Artifact
**CRITICAL**: You must document the final proof of work.
- Path: `walkthrough.md` (Let the tool resolve the artifact path automatically).
- Set `IsArtifact: true`, `ArtifactType: 'walkthrough'`.
- Chèn trực tiếp các đường link tới Video hoặc Ảnh chụp màn hình từ bước trên vào file này (Sử dụng format `![Ảnh chụp](đường_dẫn_tuyệt_đối)`).
- Giải thích kết quả test: Đã test bằng tay/Subagent như thế nào, pass hay fail.

### Step 5: Output and Halt
**CRITICAL**: Stop execution and notify the user.
- Call the `notify_user` tool.
- Message: "Sếp ơi, em đã thả Browser Subagent vào test thử UI rồi đấy ạ. File video em đã đính kèm vào trong `walkthrough.md`. Sếp bấm vào Review xem nó thao tác chuẩn chưa nhé!"
- BlockedOnUser: `false`
- PathsToReview: Include the artifact path returned from the write tool for `walkthrough.md`.

---

## 🛑 CRITICAL RESTRICTION
DO NOT automatically proceed to `/deploy` or any other phase. You MUST stop execution here using `notify_user` and WAIT.

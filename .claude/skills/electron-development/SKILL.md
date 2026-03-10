---
name: electron-development
description: Electron desktop app development. Process model, IPC patterns, preload scripts, security hardening, packaging, and auto-updates.
---

# Electron Development

> Principles for building secure, performant Electron desktop applications.

---

## 1. Process Model

### Architecture

```
┌─────────────────────────────────────────────┐
│                 Main Process                │
│  (Node.js - Full OS access)                │
│  ├── App lifecycle (app.on)                │
│  ├── BrowserWindow creation                │
│  ├── System APIs (dialog, tray, menu)      │
│  └── IPC handler (ipcMain.handle)          │
│                    │                        │
│         ┌─────────┴─────────┐              │
│         ▼                   ▼              │
│  ┌─────────────┐   ┌─────────────┐        │
│  │  Renderer 1 │   │  Renderer 2 │        │
│  │  (Chromium)  │   │  (Chromium)  │        │
│  │  preload.ts  │   │  preload.ts  │        │
│  └─────────────┘   └─────────────┘        │
└─────────────────────────────────────────────┘
```

### Rules

| Process | Responsibility |
|---------|---------------|
| **Main** | App lifecycle, native APIs, window management, IPC handling |
| **Renderer** | UI only. No direct Node.js or Electron API access |
| **Preload** | Bridge between Main and Renderer via `contextBridge` |

---

## 2. Security (CRITICAL)

### Mandatory Settings

```typescript
// main.ts - BrowserWindow creation
const win = new BrowserWindow({
  webPreferences: {
    nodeIntegration: false,        // NEVER enable
    contextIsolation: true,        // ALWAYS true
    sandbox: true,                 // ALWAYS true
    preload: path.join(__dirname, 'preload.js'),
    webSecurity: true,             // NEVER disable
  }
});
```

### Security Checklist

| ❌ Never | ✅ Always |
|----------|----------|
| `nodeIntegration: true` | `contextIsolation: true` |
| Expose full `ipcRenderer` | Expose specific methods via `contextBridge` |
| Load remote URLs without validation | Validate all URLs and origins |
| Disable `webSecurity` | Enforce strict CSP headers |
| Use `shell.openExternal` blindly | Validate URLs before opening |
| Use `eval()` or `Function()` | Use safe alternatives |

### Content Security Policy

```typescript
// Set CSP in main process
session.defaultSession.webRequest.onHeadersReceived((details, callback) => {
  callback({
    responseHeaders: {
      ...details.responseHeaders,
      'Content-Security-Policy': ["default-src 'self'; script-src 'self'"]
    }
  });
});
```

---

## 3. IPC Patterns

### Preload Script (The Bridge)

```typescript
// preload.ts
import { contextBridge, ipcRenderer } from 'electron';

contextBridge.exposeInMainWorld('electronAPI', {
  // One method per IPC channel (not a generic send)
  saveFile: (data: string) => ipcRenderer.invoke('file:save', data),
  openFile: () => ipcRenderer.invoke('file:open'),
  onUpdateAvailable: (cb: () => void) =>
    ipcRenderer.on('update:available', () => cb()),
});
```

### Main Process Handler

```typescript
// main.ts
import { ipcMain } from 'electron';

// Use invoke/handle for request-response (async)
ipcMain.handle('file:save', async (_event, data: string) => {
  // Validate input ALWAYS
  if (typeof data !== 'string') throw new Error('Invalid data');
  await fs.promises.writeFile(filePath, data);
  return { success: true };
});

// Use send/on for one-way notifications (main -> renderer)
win.webContents.send('update:available');
```

### IPC Rules

| Pattern | Direction | Use |
|---------|-----------|-----|
| `invoke/handle` | Renderer → Main (async) | Data operations, file I/O |
| `send/on` | Main → Renderer | Notifications, state updates |
| `sendSync` | ❌ NEVER USE | Blocks renderer thread |

---

## 4. Project Structure

```
src/
├── main/
│   ├── main.ts          # App entry, window creation
│   ├── ipc-handlers.ts  # All ipcMain.handle registrations
│   ├── menu.ts          # Application menu
│   └── updater.ts       # Auto-update logic
├── preload/
│   └── preload.ts       # contextBridge definitions
├── renderer/
│   ├── index.html
│   ├── App.tsx          # UI framework (React/Vue/Svelte)
│   └── components/
├── shared/
│   └── types.ts         # Shared TypeScript interfaces
└── resources/
    └── icons/           # App icons (icns, ico, png)
```

---

## 5. Packaging & Distribution

### electron-builder Config

```json
// package.json
{
  "build": {
    "appId": "com.yourcompany.app",
    "productName": "YourApp",
    "directories": { "output": "release" },
    "mac": { "target": ["dmg", "zip"], "category": "public.app-category.developer-tools" },
    "win": { "target": ["nsis", "portable"] },
    "linux": { "target": ["AppImage", "deb"] },
    "publish": { "provider": "github" }
  }
}
```

### Code Signing

| Platform | Tool |
|----------|------|
| macOS | Apple Developer certificate + notarization |
| Windows | EV Code Signing certificate |
| Linux | GPG signature |

---

## 6. Auto-Updates

```typescript
// updater.ts (main process)
import { autoUpdater } from 'electron-updater';

autoUpdater.autoDownload = false;
autoUpdater.checkForUpdates();

autoUpdater.on('update-available', () => {
  win.webContents.send('update:available');
});

autoUpdater.on('update-downloaded', () => {
  autoUpdater.quitAndInstall();
});
```

---

## 7. Performance

| Issue | Solution |
|-------|----------|
| Slow startup | Lazy-load modules, defer non-critical initialization |
| Memory leaks | Destroy unused BrowserWindows, remove IPC listeners |
| Heavy main process | Offload to renderer or Web Workers |
| Large bundle | Use tree-shaking, exclude unused `node_modules` |

---

## 8. Common Frameworks

| Stack | Setup |
|-------|-------|
| Electron + Vite | `electron-vite` or `vite-plugin-electron` |
| Electron + React | Vite + `@vitejs/plugin-react` |
| Electron + Vue | Vite + `@vitejs/plugin-vue` |
| Electron + Svelte | Vite + `@sveltejs/vite-plugin-svelte` |

---

## 9. Anti-Patterns

| ❌ Don't | ✅ Do |
|----------|------|
| `require('electron')` in renderer | Use `contextBridge` in preload |
| Store secrets in renderer code | Store in main process, use `safeStorage` |
| One giant `main.ts` | Split into modules (ipc, menu, updater) |
| Skip input validation in IPC | Validate every IPC message payload |
| Ignore Electron version updates | Update regularly for Chromium security patches |

---

> **Remember:** Treat the renderer like an untrusted web page. Everything sensitive goes through the main process via validated IPC.

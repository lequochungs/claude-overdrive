---
name: vite-development
description: Vite build tool best practices. Configuration, plugins, HMR, SSR, code splitting, and production build optimization.
---

# Vite Development

> Principles for fast, optimized web development with Vite.

---

## 1. Configuration Essentials

### vite.config.ts

```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react'; // or vue, svelte

export default defineConfig(({ command, mode }) => ({
  plugins: [react()],
  resolve: {
    alias: { '@': '/src' },         // Clean imports
  },
  server: {
    port: 3000,
    proxy: {                         // API proxy for dev
      '/api': { target: 'http://localhost:8080', changeOrigin: true }
    },
  },
  build: {
    target: 'esnext',                // Modern browsers only
    sourcemap: mode !== 'production', // Disable in prod
    rollupOptions: {
      output: {
        manualChunks: {              // Custom code splitting
          vendor: ['react', 'react-dom'],
        },
      },
    },
  },
}));
```

### Key Config Options

| Option | Purpose |
|--------|---------|
| `resolve.alias` | Short import paths (`@/components/...`) |
| `server.proxy` | Avoid CORS issues in development |
| `build.target` | Set browser compatibility (`esnext` for smallest bundle) |
| `optimizeDeps.include` | Pre-bundle specific dependencies |
| `base` | Set when deploying to a subdirectory |

---

## 2. Plugin Ecosystem

### Essential Plugins

| Plugin | Use |
|--------|-----|
| `@vitejs/plugin-react` | React Fast Refresh + JSX |
| `@vitejs/plugin-vue` | Vue 3 SFC support |
| `vite-plugin-pwa` | Progressive Web App |
| `vite-plugin-imagemin` | Image compression |
| `rollup-plugin-visualizer` | Bundle analysis |
| `vite-plugin-compression` | Gzip/Brotli output |

### Plugin Rules

- Keep plugins minimal. Each plugin adds startup time.
- Prefer official `@vitejs/*` plugins over community alternatives.
- Use `apply: 'build'` or `apply: 'serve'` to limit plugin scope.

---

## 3. Development (HMR)

### How It Works

```
File saved → Vite detects change → Module boundary found
  → Only that module is replaced via WebSocket
  → Component state preserved → ~50ms update
```

### Best Practices

| ❌ Don't | ✅ Do |
|----------|------|
| Import everything in one file | Split into small modules |
| Use barrel exports (`index.ts`) excessively | Import directly from source |
| Mutate global state on module level | Use framework state management |
| Ignore HMR boundary errors | Fix circular dependencies |

---

## 4. Build Optimization

### Code Splitting

```typescript
// Automatic: Route-based splitting
const Dashboard = lazy(() => import('./pages/Dashboard'));

// Manual: vendor chunk splitting
// vite.config.ts → build.rollupOptions.output.manualChunks
manualChunks(id) {
  if (id.includes('node_modules')) {
    if (id.includes('react')) return 'vendor-react';
    if (id.includes('lodash')) return 'vendor-lodash';
    return 'vendor';
  }
}
```

### Performance Checklist

| Technique | Impact |
|-----------|--------|
| Dynamic imports for routes | Reduces initial bundle |
| `build.target: 'esnext'` | Skips legacy transforms |
| `build.sourcemap: false` (prod) | Faster builds |
| Tree shaking (automatic) | Removes dead code |
| `vite-plugin-imagemin` | Compresses images |
| CSS code splitting (automatic) | Per-route CSS |
| `build.cssMinify: 'lightningcss'` | Faster CSS minification |

### Bundle Analysis

```bash
# Install visualizer
npm i -D rollup-plugin-visualizer

# Add to vite.config.ts plugins:
import { visualizer } from 'rollup-plugin-visualizer';
plugins: [visualizer({ open: true })]

# Run build to generate report
npm run build
```

---

## 5. Environment Variables

### File Structure

```
.env                 # Loaded in all cases
.env.local           # Loaded in all cases, git-ignored
.env.development     # Only in dev mode
.env.production      # Only in build mode
```

### Rules

| Prefix | Access |
|--------|--------|
| `VITE_` | Exposed to client code via `import.meta.env.VITE_*` |
| No prefix | Server-side only (NOT exposed to client) |

```typescript
// Usage in code
const apiUrl = import.meta.env.VITE_API_URL;

// Type safety
/// <reference types="vite/client" />
interface ImportMetaEnv {
  readonly VITE_API_URL: string;
}
```

---

## 6. SSR (Server-Side Rendering)

### Setup

```typescript
// vite.config.ts
export default defineConfig({
  ssr: {
    noExternal: ['some-package'],  // Bundle into SSR output
    target: 'node',                // or 'webworker'
  },
});
```

### Project Structure

```
src/
├── entry-client.tsx   # Hydration: hydrateRoot(...)
├── entry-server.tsx   # Rendering: renderToString(...)
├── App.tsx
└── pages/
```

### Build Commands

```bash
# Client build
vite build --outDir dist/client

# SSR build
vite build --outDir dist/server --ssr src/entry-server.tsx
```

---

## 7. Project Structure

```
project/
├── public/              # Static assets (copied as-is)
├── src/
│   ├── assets/          # Processed by Vite (hashed filenames)
│   ├── components/
│   ├── pages/
│   ├── lib/             # Utilities
│   ├── styles/
│   └── main.tsx         # Entry point
├── .env
├── .env.production
├── index.html           # Entry HTML (in project root!)
├── tsconfig.json
└── vite.config.ts
```

### Key Differences from Webpack

| Webpack | Vite |
|---------|------|
| `index.html` in `public/` | `index.html` in project root |
| `require()` | `import` (ESM only) |
| `process.env` | `import.meta.env` |
| Complex config | Minimal config by default |
| Slow cold start | Instant dev server |

---

## 8. Electron + Vite

### Recommended Setup

```bash
# Option 1: electron-vite (official-feeling)
npm create @electron-vite/create@latest

# Option 2: vite-plugin-electron
npm i -D vite-plugin-electron vite-plugin-electron-renderer
```

### Config for Electron

```typescript
// vite.config.ts (with vite-plugin-electron)
import electron from 'vite-plugin-electron';

export default defineConfig({
  plugins: [
    react(),
    electron({
      entry: 'electron/main.ts',
    }),
  ],
});
```

---

## 9. Common Commands

```bash
# Development
npm run dev                     # Start dev server with HMR

# Build
npm run build                   # Production build
npm run preview                 # Preview production build locally

# Analysis
npx vite --debug                # Debug mode
npx vite optimize --force       # Force re-optimize deps
```

---

## 10. Anti-Patterns

| ❌ Don't | ✅ Do |
|----------|------|
| Use `require()` | Use `import` (ESM) |
| `process.env.VAR` | `import.meta.env.VITE_VAR` |
| Import entire libraries | Import specific functions |
| Barrel files for everything | Direct imports for HMR speed |
| Leave `sourcemap: true` in prod | Set `false` for production |
| Bundle all deps together | Use `manualChunks` for splitting |

---

> **Remember:** Vite's power comes from native ESM in dev and Rollup in prod. Keep configs minimal, use dynamic imports for code splitting, and always analyze your bundle.

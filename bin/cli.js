#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('\x1b[34m%s\x1b[0m', '⚡ CLAUDE OVERDRIVE - KIT INJECTOR ⚡');

const repo = 'https://github.com/lequochungs/claude-overdrive.git';
const tempDir = path.join(process.cwd(), '.overdrive-temp');

try {
    // 1. Clone repo to temp
    console.log('\x1b[32m%s\x1b[0m', 'Fetching kit from GitHub...');
    // Git is required for npx github:... anyway, so this is safe cross-platform
    execSync(`git clone --depth 1 ${repo} "${tempDir}"`, { stdio: 'ignore' });

    // 2. Inject .claude folder
    console.log('\x1b[32m%s\x1b[0m', 'Injecting .claude kit into current directory...');
    const kitSource = path.join(tempDir, '.claude');
    const kitDest = path.join(process.cwd(), '.claude');

    // Use recursive copy (Node 16.7.0+)
    if (fs.cpSync) {
        fs.cpSync(kitSource, kitDest, { recursive: true });
    } else {
        // Fallback for older Node versions if necessary, but cpSync is standard now
        execSync(process.platform === 'win32'
            ? `xcopy "${kitSource}" "${kitDest}" /E /I /Y`
            : `cp -R "${kitSource}/"* "${kitDest}/"`, { stdio: 'ignore' });
    }

    // 3. Cleanup
    if (fs.rmSync) {
        fs.rmSync(tempDir, { recursive: true, force: true });
    } else {
        execSync(process.platform === 'win32' ? `rmdir /S /Q "${tempDir}"` : `rm -rf "${tempDir}"`, { stdio: 'ignore' });
    }

    // 4. Set permissions (Only relevant for Unix-like systems)
    if (process.platform !== 'win32') {
        const setupPath = path.join(kitDest, 'setup.sh');
        if (fs.existsSync(setupPath)) {
            fs.chmodSync(setupPath, '755');
        }
    }

    console.log('\n\x1b[32m%s\x1b[0m', '✅ SUCCESS: Claude Overdrive Kit injected!');
    console.log('Run \x1b[36msh .claude/setup.sh\x1b[0m (or bash) to configure.');
} catch (error) {
    console.error('\x1b[31m%s\x1b[0m', '❌ Extraction failed:');
    console.error(error.message);
    if (fs.existsSync(tempDir)) {
        if (fs.rmSync) fs.rmSync(tempDir, { recursive: true, force: true });
        else execSync(process.platform === 'win32' ? `rmdir /S /Q "${tempDir}"` : `rm -rf "${tempDir}"`);
    }
    process.exit(1);
}

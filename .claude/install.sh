#!/bin/bash

# --- CLAUDE OVERDRIVE REMOTE INSTALLER ---
# This script clones the Overdrive Kit from GitHub and injects it into the current project.
# Usage: curl -sSL https://raw.githubusercontent.com/your-username/claude-overdrive/main/install.sh | bash
# ---------------------------------------------------------

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

REPO_URL="https://github.com/lequochungs/claude-overdrive.git" # Repository URL
TEMP_DIR="/tmp/claude-overdrive-installer"

clear
echo -e "${BLUE}"
echo "  ⚡ CLAUDE OVERDRIVE REMOTE INJECTOR ⚡"
echo "  _____________________________________"
echo " /                                     \\"
echo " |    >>> DOWNLOAD & INJECT MODE <<<   |"
echo " \\_____________________________________/"
echo -e "${NC}"

echo -e "${BLUE}Starting remote installation from GitHub...${NC}"

# Check for git
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: 'git' is not installed. Please install git first.${NC}"
    exit 1
fi

# Clean up any old temp dir
rm -rf "$TEMP_DIR"

# Clone the repository
echo -e "${GREEN}[1/3]${NC} Computing payload from $REPO_URL..."
git clone --depth 1 "$REPO_URL" "$TEMP_DIR" &> /dev/null

if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to clone the repository. Check your connection.${NC}"
    exit 1
fi

# Inject the .claude folder
echo -e "${GREEN}[2/3]${NC} Injecting Overdrive Core into $(pwd)..."
mkdir -p .claude
cp -R "$TEMP_DIR/.claude/commands" .claude/
cp -R "$TEMP_DIR/.claude/skills" .claude/
cp "$TEMP_DIR/.claude/setup.sh" .claude/

# Finalize
echo -e "${GREEN}[3/3]${NC} Finalizing installation..."
chmod +x .claude/setup.sh

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo -e "${GREEN}✅ SUCCESS: Claude Overdrive has been injected!${NC}"
echo "Run '.claude/setup.sh' to configure or start Claude Code and type '/init'."
echo ""

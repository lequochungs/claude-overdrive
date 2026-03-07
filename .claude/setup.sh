#!/bin/bash

# --- CLAUDE OVERDRIVE INSTALLER ---
# Professional Injection Script
# ---------------------------------------------------------

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

clear
echo -e "${BLUE}"
echo "  ⚡ CLAUDE OVERDRIVE INSTALLER ⚡"
echo "  _________________________________"
echo " /                                 \\"
echo " |   >>> SYSTEM: OVERDRIVE ON <<<   |"
echo " \\_________________________________/"
echo -e "${NC}"

echo -e "${BLUE}Welcome to Claude Overdrive.${NC}"
echo "Injecting 700+ skills and automated workflows into your project..."
echo ""

# --- DIRECTORY DETECTION ---
TARGET_DIR=".claude"
SOURCE_DIR=$(dirname "$0")

# If running from within .claude, adjust source
if [[ "$SOURCE_DIR" == "." ]]; then
    SOURCE_DIR="."
fi

mkdir -p "$TARGET_DIR/commands" "$TARGET_DIR/skills"

echo -e "${GREEN}[1/3]${NC} Preparing project directories..."

# --- INSTALLATION MENU ---
echo -e "${BLUE}Choose your installation method:${NC}"
echo "1) Fast Merge (Copy files to project - Safe)"
echo "2) Live Symlink (Developer mode - Updates in real-time)"
echo "3) Global injection (Instructions for ~/.zshrc)"
read -p "Select an option [1-3]: " opt

case $opt in
    1)
        echo -e "${GREEN}[2/3]${NC} Merging skills and commands..."
        cp -R "$SOURCE_DIR/commands/"* "$TARGET_DIR/commands/" 2>/dev/null
        cp -R "$SOURCE_DIR/skills/"* "$TARGET_DIR/skills/" 2>/dev/null
        ;;
    2)
        echo -e "${GREEN}[2/3]${NC} Creating symlinks..."
        ln -snf "$(realpath "$SOURCE_DIR/commands")" "$TARGET_DIR/commands"
        ln -snf "$(realpath "$SOURCE_DIR/skills")" "$TARGET_DIR/skills"
        ;;
    3)
        echo ""
        echo -e "${GREEN}To use Claude Overdrive globally, add this to your ~/.zshrc:${NC}"
        echo "--------------------------------------------------------"
        echo "function claude-inject() {"
        echo "  local KIT=\"$(realpath "$SOURCE_DIR")\""
        echo "  mkdir -p .claude/commands .claude/skills"
        echo "  cp -R \"\$KIT/commands/\"* .claude/commands/ 2>/dev/null"
        echo "  cp -R \"\$KIT/skills/\"* .claude/skills/ 2>/dev/null"
        echo "  echo \"🚀 Claude Overdrive injected into \$(pwd)\""
        echo "}"
        echo "--------------------------------------------------------"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid option. Exiting.${NC}"
        exit 1
        ;;
esac

echo -e "${GREEN}[3/3]${NC} Finalizing..."
# Ensure permissions
chmod -R +r "$TARGET_DIR"

echo ""
echo -e "${GREEN}✅ SUCCESS: Claude Overdrive is now active in this project!${NC}"
echo "Try running '/plan' or '/init' in the Claude prompts."

#!/bin/bash
# Auto-sync CLAUDE.md to GitHub
# Called by Claude hook after CLAUDE.md changes

SOURCE_FILE="$HOME/.claude/CLAUDE.md"
REPO_DIR="$HOME/Documents/claude-config"
TARGET_FILE="$REPO_DIR/CLAUDE.md"

# Copy current CLAUDE.md to repo
cp "$SOURCE_FILE" "$TARGET_FILE"

cd "$REPO_DIR" || exit 1

# Check if there are changes
if git status --porcelain CLAUDE.md | grep -q .; then
    git add CLAUDE.md
    git commit -m "Auto-sync CLAUDE.md [$(date '+%Y-%m-%d %H:%M')]"
    git push origin master 2>/dev/null
fi

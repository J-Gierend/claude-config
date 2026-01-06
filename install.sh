#!/bin/bash
# Claude Config Installer - Linux/macOS/Git Bash
# Usage: ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
BOOTSTRAP_DIR="$HOME/.claude-bootstrap"
REPO_DIR="$HOME/Documents/claude-config"

echo "[INSTALL] Claude Config Installer"
echo "================================="

# Create .claude directory if not exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "[OK] Creating $CLAUDE_DIR"
    mkdir -p "$CLAUDE_DIR"
fi

# Backup existing CLAUDE.md if present
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    BACKUP="$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
    echo "[WARN] Existing CLAUDE.md found, backing up to $BACKUP"
    cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP"
fi

# Copy CLAUDE.md and spec.md
echo "[OK] Installing CLAUDE.md to $CLAUDE_DIR"
cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
cp "$SCRIPT_DIR/spec.md" "$CLAUDE_DIR/spec.md"

# Clone claude-bootstrap if not exists
if [ ! -d "$BOOTSTRAP_DIR" ]; then
    echo "[OK] Cloning claude-bootstrap framework..."
    git clone https://github.com/alinaqi/claude-bootstrap.git "$BOOTSTRAP_DIR"
else
    echo "[OK] claude-bootstrap already installed, updating..."
    cd "$BOOTSTRAP_DIR" && git pull
fi

# Create .env template if not exists
if [ ! -f "$CLAUDE_DIR/.env" ]; then
    echo "[OK] Creating .env template"
    cat > "$CLAUDE_DIR/.env" << 'EOF'
# Email Configuration (optional)
EMAIL_ADDRESS=your-email@example.com
EMAIL_APP_PASSWORD=your-app-password
EOF
    echo "[WARN] Edit ~/.claude/.env with your credentials"
fi

# Configure auto-sync hook in settings.json
echo "[OK] Configuring auto-sync hook..."
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
SYNC_COMMAND="$REPO_DIR/sync.sh"

# Make sync.sh executable
chmod +x "$REPO_DIR/sync.sh"

# Create or update settings.json with hook
if [ -f "$SETTINGS_FILE" ]; then
    # Use jq if available, otherwise create new
    if command -v jq &> /dev/null; then
        jq --arg cmd "$SYNC_COMMAND" '.hooks.postEdit = [{"matcher": "**/.claude/CLAUDE.md", "command": $cmd}]' "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp"
        mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
    else
        # Fallback: append hook config manually
        cat > "$SETTINGS_FILE" << EOF
{
  "hooks": {
    "postEdit": [
      {
        "matcher": "**/.claude/CLAUDE.md",
        "command": "$SYNC_COMMAND"
      }
    ]
  }
}
EOF
    fi
else
    cat > "$SETTINGS_FILE" << EOF
{
  "hooks": {
    "postEdit": [
      {
        "matcher": "**/.claude/CLAUDE.md",
        "command": "$SYNC_COMMAND"
      }
    ]
  }
}
EOF
fi
echo "[OK] Auto-sync hook configured"

echo ""
echo "[DONE] Installation complete!"
echo "  - CLAUDE.md: $CLAUDE_DIR/CLAUDE.md"
echo "  - Bootstrap: $BOOTSTRAP_DIR"
echo "  - Auto-sync: ENABLED"
echo ""

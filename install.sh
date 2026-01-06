#!/bin/bash
# Claude Config Installer - Linux/macOS/Git Bash
# Usage: ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
BOOTSTRAP_DIR="$HOME/.claude-bootstrap"

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

# Copy CLAUDE.md
echo "[OK] Installing CLAUDE.md to $CLAUDE_DIR"
cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

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

echo ""
echo "[DONE] Installation complete!"
echo "  - CLAUDE.md: $CLAUDE_DIR/CLAUDE.md"
echo "  - Bootstrap: $BOOTSTRAP_DIR"
echo ""

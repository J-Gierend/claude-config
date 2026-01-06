#!/bin/bash
# One-liner bootstrap for claude-config
# Usage: curl -fsSL https://raw.githubusercontent.com/J-Gierend/claude-config/master/bootstrap.sh | bash

set -e

REPO_DIR="$HOME/Documents/claude-config"

echo "========================================"
echo "[BOOTSTRAP] Claude Code + Config"
echo "========================================"

# Step 1: Install Claude Code CLI if not present
if command -v claude &> /dev/null; then
    echo "[OK] Claude Code CLI already installed: $(claude --version 2>/dev/null || echo 'version unknown')"
else
    echo "[INSTALL] Installing Claude Code CLI..."
    curl -fsSL https://claude.ai/install.sh | bash

    # Source shell config to get claude in PATH
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc" 2>/dev/null || true
    fi
    if [ -f "$HOME/.zshrc" ]; then
        source "$HOME/.zshrc" 2>/dev/null || true
    fi

    echo "[OK] Claude Code CLI installed"
fi

# Step 2: Install git if not present
if ! command -v git &> /dev/null; then
    echo "[INSTALL] Installing git..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y git
    elif command -v yum &> /dev/null; then
        sudo yum install -y git
    elif command -v brew &> /dev/null; then
        brew install git
    else
        echo "[FAIL] Cannot install git automatically. Please install git manually."
        exit 1
    fi
fi

# Step 3: Clone or update config repo
mkdir -p "$HOME/Documents"

if [ -d "$REPO_DIR" ]; then
    echo "[OK] Updating existing config..."
    cd "$REPO_DIR" && git pull
else
    echo "[OK] Cloning claude-config..."
    git clone https://github.com/J-Gierend/claude-config.git "$REPO_DIR"
fi

# Step 4: Run installer
cd "$REPO_DIR"
chmod +x install.sh
./install.sh

echo ""
echo "========================================"
echo "[DONE] Claude Code ready to use!"
echo "  Run: claude"
echo "========================================"

#!/bin/bash
# One-liner bootstrap for claude-config
# Usage: curl -fsSL https://raw.githubusercontent.com/J-Gierend/claude-config/master/bootstrap.sh | bash

set -e

REPO_DIR="$HOME/Documents/claude-config"

echo "[BOOTSTRAP] Claude Config"

# Create Documents if not exists
mkdir -p "$HOME/Documents"

# Clone or update repo
if [ -d "$REPO_DIR" ]; then
    echo "[OK] Updating existing installation..."
    cd "$REPO_DIR" && git pull
else
    echo "[OK] Cloning claude-config..."
    git clone https://github.com/J-Gierend/claude-config.git "$REPO_DIR"
fi

# Run installer
cd "$REPO_DIR"
chmod +x install.sh
./install.sh

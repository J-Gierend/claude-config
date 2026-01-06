# Claude Config System Specification

## Overview

Portable, auto-syncing Claude Code configuration system for use across multiple machines (Windows, Linux, macOS).

## Repository

- **URL**: https://github.com/J-Gierend/claude-config
- **Local Path**: `~/Documents/claude-config/`

## Components

### 1. CLAUDE.md (Main Configuration)

Platform-independent configuration file containing:
- Development workflow rules (Concept-First, TDD)
- Subagent policies (Opus only)
- Git worktree protection
- Skill auto-detection
- Email capabilities
- Resource management

**Location**: `~/.claude/CLAUDE.md` (installed via script)

### 2. Install Scripts

| Script | Platform | Usage |
|--------|----------|-------|
| `install.sh` | Linux/macOS | `chmod +x install.sh && ./install.sh` |
| `install.ps1` | Windows | `.\install.ps1` |

**Actions performed**:
1. Creates `~/.claude/` directory
2. Backs up existing `CLAUDE.md` (if present)
3. Copies `CLAUDE.md` to `~/.claude/`
4. Clones/updates `claude-bootstrap` framework to `~/.claude-bootstrap/`
5. Creates `.env` template for email credentials

### 3. Auto-Sync System

Automatically pushes CLAUDE.md changes to GitHub.

#### Sync Scripts

| Script | Platform | Path |
|--------|----------|------|
| `sync.ps1` | Windows | `~/Documents/claude-config/sync.ps1` |
| `sync.sh` | Linux/macOS | `~/Documents/claude-config/sync.sh` |

**Workflow**:
1. Copies `~/.claude/CLAUDE.md` to repo
2. Checks for changes via `git status`
3. If changes: commit with timestamp, push to origin

#### Claude Hook (Windows)

**Location**: `~/.claude/settings.json`

```json
{
  "hooks": {
    "postEdit": [
      {
        "matcher": "**/.claude/CLAUDE.md",
        "command": "powershell -ExecutionPolicy Bypass -File \"$HOME/Documents/claude-config/sync.ps1\""
      }
    ]
  }
}
```

**Trigger**: Runs automatically after Claude edits `CLAUDE.md`

#### Linux/macOS Hook Setup

Add to `~/.claude/settings.json`:
```json
{
  "hooks": {
    "postEdit": [
      {
        "matcher": "**/.claude/CLAUDE.md",
        "command": "~/Documents/claude-config/sync.sh"
      }
    ]
  }
}
```

## File Structure

```
~/Documents/claude-config/
├── CLAUDE.md          # Main configuration (source of truth for repo)
├── README.md          # Quick start guide
├── spec.md            # This specification
├── install.sh         # Linux/macOS installer
├── install.ps1        # Windows installer
├── sync.sh            # Linux/macOS auto-sync script
├── sync.ps1           # Windows auto-sync script
└── .gitignore

~/.claude/
├── CLAUDE.md          # Active configuration (edited by Claude)
├── settings.json      # Claude settings with hooks
├── settings.local.json
└── .env               # Email credentials (not synced)

~/.claude-bootstrap/   # Framework (separate repo)
├── skills/
├── commands/
└── ...
```

## Deployment to New Machine

### Quick Start

```bash
# 1. Clone repo
git clone https://github.com/J-Gierend/claude-config.git ~/Documents/claude-config

# 2. Run installer (auto-configures everything including hooks)
cd ~/Documents/claude-config
./install.sh  # or .\install.ps1 on Windows
```

The installer automatically:
- Copies CLAUDE.md and spec.md to ~/.claude/
- Clones/updates claude-bootstrap framework
- Configures the auto-sync hook in settings.json
- Creates .env template

### Manual Sync

If hook doesn't trigger, run manually:
```bash
~/Documents/claude-config/sync.sh  # Linux/macOS
# or
powershell ~/Documents/claude-config/sync.ps1  # Windows
```

## Dependencies

- Git
- GitHub CLI (`gh`) - for initial repo creation
- PowerShell (Windows) or Bash (Linux/macOS)

## Security Notes

- `.env` file with email credentials is NOT synced to GitHub
- Each machine needs its own `.env` configuration
- SSH keys or GitHub token required for auto-push

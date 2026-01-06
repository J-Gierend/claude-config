# Claude Config

Personal Claude Code configuration framework by Josh.

## One-Liner Install

### Linux / macOS
```bash
curl -fsSL https://raw.githubusercontent.com/J-Gierend/claude-config/master/bootstrap.sh | bash
```

### Windows (PowerShell)
```powershell
iwr -useb https://raw.githubusercontent.com/J-Gierend/claude-config/master/bootstrap.ps1 | iex
```

## Manual Install

### Linux / macOS
```bash
git clone https://github.com/J-Gierend/claude-config.git ~/Documents/claude-config
cd ~/Documents/claude-config
./install.sh
```

### Windows (PowerShell)
```powershell
git clone https://github.com/J-Gierend/claude-config.git $env:USERPROFILE\Documents\claude-config
cd $env:USERPROFILE\Documents\claude-config
.\install.ps1
```

## What Gets Installed

- `~/.claude/CLAUDE.md` - Main configuration file
- `~/.claude-bootstrap/` - Claude Bootstrap framework (cloned from alinaqi/claude-bootstrap)
- `~/.claude/.env` - Email credentials template (optional)

## Configuration

The `CLAUDE.md` file contains:
- Development workflow rules (Concept-First, TDD)
- Subagent policies (Opus only)
- Git worktree protection
- Skill auto-detection
- And more...

## Updating

Pull latest changes and re-run installer:
```bash
cd claude-config
git pull
./install.sh  # or .\install.ps1 on Windows
```

## Based On

- [claude-bootstrap](https://github.com/alinaqi/claude-bootstrap) by alinaqi

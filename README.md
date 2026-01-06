# Claude Config

Personal Claude Code configuration framework by Josh.

## One-Liner Install (includes Claude Code CLI)

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

## What the Bootstrap Does

```
Step 1: Claude Code CLI
        ├── Checks if 'claude' command exists
        ├── If missing: installs via official Anthropic installer
        │   ├── Linux/macOS: curl -fsSL https://claude.ai/install.sh | bash
        │   └── Windows: irm https://claude.ai/install.ps1 | iex
        └── If present: shows version, skips install

Step 2: Git
        ├── Checks if 'git' command exists
        ├── Linux: auto-installs via apt/yum/brew if missing
        └── Windows: exits with error if missing (manual install required)

Step 3: Config Repository
        ├── Creates ~/Documents/ if needed
        ├── Clones https://github.com/J-Gierend/claude-config.git
        └── Or pulls latest if already cloned

Step 4: Installation (install.sh / install.ps1)
        ├── Copies CLAUDE.md → ~/.claude/CLAUDE.md
        ├── Copies spec.md → ~/.claude/spec.md
        ├── Clones claude-bootstrap → ~/.claude-bootstrap/
        ├── Creates ~/.claude/.env template
        └── Configures auto-sync hook in ~/.claude/settings.json

Step 5: Done
        └── Claude Code ready: just run 'claude'
```

## What Gets Installed

| Component | Location | Purpose |
|-----------|----------|---------|
| Claude Code CLI | System PATH | Official Anthropic CLI |
| CLAUDE.md | ~/.claude/ | Dev rules & workflow config |
| spec.md | ~/.claude/ | System documentation |
| claude-bootstrap | ~/.claude-bootstrap/ | Skills framework |
| .env | ~/.claude/ | Email credentials (template) |
| Auto-sync hook | ~/.claude/settings.json | Pushes CLAUDE.md changes to GitHub |

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

# CLAUDE.md - Global Configuration

## Environment Context
- **Platform**: Auto-detected (Windows/Linux/macOS)
- **Mode**: Bypassing Permissions Mode (full access)

---

## Section 1: Claude-Bootstrap Framework

### Framework Location
- **Path**: `~/.claude-bootstrap/`
- **Repository**: https://github.com/alinaqi/claude-bootstrap
- **Skills**: `~/.claude-bootstrap/skills/` (40 Skills)

### Auto-Update (Every Session Start)
```
1. git pull in ~/.claude-bootstrap/
2. Compare with previous state (commit hash)
3. If changes: "[UPDATE] Framework aktualisiert. Neue Skills: x, y"
4. If error: "[WARN] Framework-Update fehlgeschlagen. Nutze lokale Version."
```

### Framework Core Principles (Always Active)
- **TDD-first**: No code without failing test first
- **Security-first**: Pre-commit hooks, no secrets in code
- **Iterative Loops**: Repeat until tests green
- **Complexity Limits**: Max 20 lines/function, 200 lines/file, 3 params/function
- **80% Test Coverage**: Mandatory
- **Code Review**: Before every push

### Always-On Core Skills
| Skill | Purpose |
|-------|---------|
| base.md | Fundamental development rules |
| security.md | Security-first principles |
| iterative-development.md | TDD loops |
| code-review.md | Mandatory reviews |
| commit-hygiene.md | Git best practices |

---

## Section 2: Josh's Overrides (Priority over Framework)

### 1. Concept-First Development
```
WORKFLOW:
1. Create concept and pitch to user
2. Interview/Review with user
3. Finalize spec
4. THEN: TDD-Loop for implementation

NO code changes without explicit:
- "implement", "umsetzen", "build", "mach es", "erstelle", "schreib den code"
```

### 2. Subagent Policy (MANDATORY)
- **ONLY Claude Opus** for ALL subagents - no exceptions
- Never use Sonnet or Haiku
- Parallelize independent tasks with multiple Opus subagents

### 3. Git Worktree Protection
- **NEVER merge** worktrees/feature branches without explicit approval
- After implementation: commit, tests, then STOP
- Report: "Worktree ready for review"
- Only merge on: "merge", "mergen", "zusammenfuehren"

### 4. Code Style
- No emojis/unicode in code - only [OK], [FAIL] etc.
- Modularization: GUI in gui.py, concepts as separate classes
- Complexity limits from Framework apply

### 5. Task Management
- TodoWrite ALWAYS for multi-step tasks
- Finish current task before starting new ones
- Never work without active todo list

### 6. Additional Rules
- Explain ideas before implementing - user decides
- Run syntax/compile check before saying "done"
- Keep concepts separated and modularized

---

## Section 3: Skill-Management

### Auto-Detection at Project Open
```
1. Scan: package.json, requirements.txt, Cargo.toml, go.mod, etc.
2. Detect tech stack automatically
3. Load matching skills from framework
4. Report: "Skills aktiv: python, supabase, security"
```

### Live-Detection During Work
When new dependency added:
```
[SKILL] stripe added to package.json.
        Activate 'web-payments.md'? [y/n]
```

### Skill Triggers (Selection)
| Trigger | Skill |
|---------|-------|
| *.py, requirements.txt | python.md |
| *.ts, tsconfig.json | typescript.md |
| supabase in deps | supabase.md (or stack-specific variant) |
| playwright in deps | playwright-testing.md |
| stripe in deps | web-payments.md |

### Skill Overlap Resolution
**More specific skill wins**
- Python + Supabase = supabase-python.md (not supabase.md)

### Project Skill Storage
`.claude/skills.json`:
```json
{
  "active": ["python", "supabase-python"],
  "auto_detected": true,
  "dismissed": []
}
```

Full skill list and triggers: See `~/.claude/claude-bootstrap-integration.md`

---

## Section 4: Project Initialization

### Empty Folder: Auto-Start
```
[INIT] Empty project folder detected.
       Starting /initialize-project...
```

### /initialize-project Workflow
1. Ask for tech stack
2. Create structure:
   ```
   project/
   ├── .claude/skills.json
   ├── spec.md
   └── guidelines/
       ├── design.md
       └── performance.md
   ```
3. Activate matching skills
4. Report: "Project initialized. Skills: [x, y, z]"

### Guideline Templates (Project-Type Specific)
| Type | Guidelines |
|------|------------|
| Python CLI | design.md, testing.md |
| Web App | design.md, performance.md, accessibility.md |
| Backend API | design.md, performance.md, security.md |
| Godot Game | design.md, performance.md, asset-management.md |

Templates generated on-demand based on tech stack.

### Existing Project: Auto-Detect
1. Scan tech stack from files
2. Load matching skills
3. Short message: "Skills aktiv: python, supabase, security"

---

## Section 5: Email Capability

### Configuration
Credentials stored in: `~/.claude/.env`

```python
import os
from dotenv import load_dotenv

load_dotenv(os.path.expanduser("~/.claude/.env"))
EMAIL = os.getenv("EMAIL_ADDRESS")
PASSWORD = os.getenv("EMAIL_APP_PASSWORD").replace(" ", "")
```

### Rules
- **ALWAYS ask for confirmation** before sending
- Show: recipient, subject, body preview
- Only send on explicit: "ja", "yes", "ok", "send"

### YouTuber Letters Project
- Location: `~/Documents/YouTuber_Briefe/`
- Unsent: root folder (*.txt)
- Sent: `Sent/` subfolder

---

## Section 6: Progressive Thinking

Match thinking level to task complexity:
- **THINK** - Single file edits, simple functions
- **THINK HARDER** - Multi-file changes, new features
- **ULTRATHINK** - System architecture, complex algorithms

---

## Section 7: Resource Management

Before returning to user:
- Stop dev servers: `npx kill-port 5001 3000` (or platform equivalent)
- Close database connections
- Clean up temporary files and processes

---

## Reference Documents
- Full Integration Spec: `~/.claude/claude-bootstrap-integration.md`
- Framework Skills: `~/.claude-bootstrap/skills/`
- Framework README: `~/.claude-bootstrap/README.md`

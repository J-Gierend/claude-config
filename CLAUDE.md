# CLAUDE.md - Global Configuration

## Environment Context
- **Platform**: Auto-detected (Windows/Linux/macOS)
- **Mode**: Bypassing Permissions Mode (full access)

---

## Section 0: SESSION START PROTOCOL (MANDATORY)

**These rules are BINDING. No exceptions.**

At session start, silently internalize and follow these core rules:
- TDD-first: Test before code
- Concept-first: Pitch before implement
- No code without explicit "implement/build/do it/create"
- Opus-only for subagents
- Atomic commits: Pull-Commit-Push cycle

If user's first message is a code request:
- DO NOT start coding
- Pitch concept first
- Wait for explicit approval

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
3. If changes: "[UPDATE] Framework updated. New skills: x, y"
4. If error: "[WARN] Framework update failed. Using local version."
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

### Technology Currency Policy
**Always use up-to-date dependencies and tools:**
- Before integrating any GitHub repo or library, verify it's actively maintained
- If a project has moved to a new repository, use the new one (e.g., rhasspy/piper -> OHF-Voice/piper1-gpl)
- Avoid dependencies with no updates in 2+ years unless no alternative exists
- Prefer pip packages over standalone binaries when both options exist
- When in doubt, check the repo's "last commit" date and issue activity

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
- "implement", "build", "do it", "create", "write the code"
```

### 2. Subagent Policy (MANDATORY)
- **ONLY Claude Opus** for ALL subagents - no exceptions
- Never use Sonnet or Haiku
- Parallelize independent tasks with multiple Opus subagents

### 3. Atomic Commit Workflow (MANDATORY)

**Core Principle:** Work on main branch, use atomic commits as isolation units. NO WORKTREES.

#### Pull-Commit-Push Cycle
1. **PULL** before starting work: `git pull --rebase origin main`
2. **WORK** on one logical unit, run tests
3. **COMMIT** with proper tag: `[TYPE][SCOPE] description`
4. **PUSH** immediately: `git push origin main`
5. If push rejected: auto-rebase and retry

#### Commit Message Format
```
[TYPE][SCOPE] Short description (imperative mood)

Co-Authored-By: Claude <noreply@anthropic.com>
```

#### Type Tags
| Tag | Meaning | Tests Required |
|-----|---------|----------------|
| [FEAT] | New feature | Yes |
| [FIX] | Bug fix | Yes |
| [REFACTOR] | Restructuring | Yes |
| [WIP] | Work in progress | No (squash later) |
| [DOCS], [CONFIG], [STYLE], [ASSET] | Non-code | No |

#### Scope Tags
Project-specific, defined in spec.md. Examples: [PLAYER], [COMBAT], [UI]

#### Commit Rules
- Commit after each logical unit (tests green for code changes)
- Commit before switching concerns
- One concept per commit
- Push immediately after commit
- Auto-rebase on conflicts
- WIP commits must be squashed when feature complete

#### Multi-Instance Coordination
- Multiple Claude instances can work simultaneously
- Pull-Commit-Push cycle keeps everyone synced
- Auto-rebase handles remote changes without asking

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

### 6b. Password Generation Policy (MANDATORY)
**When generating or recommending passwords:**
- **NEVER use predictable patterns** like "ServiceName2026", "Admin123", or words + year
- **ALWAYS generate cryptographically random** passwords using:
  - `openssl rand -base64 32` or equivalent
  - Minimum 24 characters for services, 28+ for admin/root
- **Required complexity:**
  - Mix of uppercase, lowercase, numbers
  - Special characters where supported
  - No dictionary words or common substitutions
- **For production/live systems:**
  - Generate and set the password immediately
  - Never suggest "temporary" weak passwords
  - Treat ALL server credentials as high-security
- **Example of WRONG:** `Operator2026`, `AdminPass123!`, `MyService2025`
- **Example of RIGHT:** `B5HRDE6rZ1PLqQce5eCAslV6N3lC`, `sITLcBR65niTrrewZxWrcoD8RkPH`

### 7. Guideline Compliance Monitoring
- **Proactively check**: Validate every code change against active guidelines
- **On violation**: Immediately inform user with specific hint:
  ```
  [GUIDELINE] Violation of {guideline-name} detected:
              {specific location/problem}
              Offer refactoring? [y/n]
  ```
- **Auto-Refactor**: On "y", automatically fix and show the change
- **Affected Guidelines**:
  - Framework Core Principles (TDD, Complexity Limits, etc.)
  - Project-specific guidelines/ files
  - Clean Code (no duplicates, modularization)

### 8. Documentation Sync Monitoring
- **Proactively check**: Identify relevant docs when features change
- **Affected files**: spec.md, README.md, guidelines/, API docs, comments
- **On mismatch**: Inform user:
  ```
  [DOC-SYNC] Feature changed but documentation outdated:
             Feature: {feature-name}
             Affected docs: {file(s)}
             Update documentation? [y/n]
  ```
- **Auto-Update**: On "y", update documentation accordingly
- **Triggers**: New features, changed APIs, removed functions, refactoring

### 9. Self-Verification Checkpoint (MANDATORY)
**Silently verify before every response:**
- Concept-first (no code without pitch + approval)?
- TDD-first (test before code)?
- Subagents only with Opus?
- TodoWrite for multi-step tasks?
- Atomic commits (pull-commit-push cycle)?

**When to verify:** Before responses, at task start, after context compaction.

**On violation:** Correct silently before responding. Only inform user if already responded incorrectly.

### 10. Post-Compaction Recovery Protocol (CRITICAL)
**Context compaction causes rule amnesia. After detecting compaction:**

1. Silently re-read this CLAUDE.md file completely
2. Re-internalize all rules
3. Continue with user's request

**Detection signs:** Conversation summary at context start, gaps in history.

**Purpose:** Prevent rule drift after long sessions.

---

## Section 3: Skill-Management

### Auto-Detection at Project Open
```
1. Scan: package.json, requirements.txt, Cargo.toml, go.mod, etc.
2. Detect tech stack automatically
3. Load matching skills from framework
4. Report: "Skills active: python, supabase, security"
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
3. Short message: "Skills active: python, supabase, security"

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
- Only send on explicit: "yes", "ok", "send"

### YouTuber Letters Project
- Location: `~/Documents/YouTuber_Letters/`
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

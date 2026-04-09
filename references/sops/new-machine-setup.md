# New Machine Setup

SOP for setting up the W2 engineering assistant on a new machine.

---

## Prerequisites

- macOS (Darwin)
- Homebrew installed
- Git configured with your identity

---

## 1. Install Crush CLI

```bash
# Option A: Homebrew (recommended)
brew install charmbracelet/tap/crush

# Option B: Go install
go install github.com/charmbracelet/crush@latest

# Verify
crush --version
```

---

## 2. Clone the Repo

```bash
git clone <repo-url> ~/repos/work-assistant
cd ~/repos/work-assistant
```

---

## 3. Configure AI Provider

Crush needs an AI provider configured. For Claude (Anthropic):

```bash
# Add to your shell profile (~/.zshrc or ~/.zprofile):
echo 'export ANTHROPIC_API_KEY=<your-key>' >> ~/.zshrc
source ~/.zshrc
```

No additional config changes needed. Model selection is handled via Crush's built-in settings or `ANTHROPIC_MODEL` env var if you want to override defaults.

---

## 4. Install Global Skills and Config

This repo ships a `global/` directory with skills, resources, and agent templates that get symlinked into `~/.config/crush/` for availability in every Crush session.

```bash
# From the repo root
chmod +x global/setup.sh
./global/setup.sh
```

Verify the output shows symlinks created for skills, agents, resources, and config. Verify:

```bash
ls -la ~/.config/crush/skills/   # should show symlinks to global/skills/*
cat ~/.config/crush/crush.json   # should show global config
```

---

## 5. Install Obsidian CLI

```bash
# Option A: Homebrew
brew install obsidian-cli

# Verify
which obsidian
obsidian --version
```

**Requirements:** Obsidian Desktop v1.12.0+ must be installed and running with the CLI toggle enabled in Settings > General > CLI.

---

## 6. Open the Vault in Obsidian Desktop

The vault is embedded at `vault/` in the repo.

1. Open Obsidian Desktop
2. Click "Open folder as vault"
3. Select `<repo-root>/vault/`
4. Name it "The Forge" when prompted

Verify CLI connectivity:
```bash
obsidian "The Forge" version
```

---

## 7. Update Context Files

Fill in your W2-specific details:

```bash
# Open each file and replace placeholder content with your actual info
open context/work.md             # W2 roles, tech stacks, active work areas
open context/current-priorities.md  # Ranked W2 priorities
open context/goals.md            # Q2 engineering goals
```

---

## 8. Verify the Setup

```bash
# Crush reads AGENTS.md correctly
crush

# In Crush, verify skills are available
# Press Ctrl+K and look for /second-brain, /project-init, etc.

# Vault is accessible (Obsidian Desktop must be running)
obsidian "The Forge" search query="test"

# Global skills are discoverable
ls ~/.config/crush/skills/

# Git is clean
git status
```

---

## 9. Optional: AGENTS.local.md

For machine-specific overrides (local paths, dev notes that don't belong in the shared repo):

```bash
echo "# Local Overrides" > AGENTS.local.md
# AGENTS.local.md is gitignored
```

---

## Git Conventions

All commits must follow conventional commits format:
```
<type>(<scope>): <description>

feat(second-brain): add tag audit workflow
fix(project-init): correct vault path reference
docs: update setup SOP for Crush
chore: update context files for Q2
```

Types: `feat`, `fix`, `docs`, `refactor`, `chore`, `style`, `test`, `build`, `ci`, `perf`

Never append Co-Authored-By trailers. Use worktrees for parallel branches.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `crush: command not found` | Install via Homebrew, check PATH |
| `obsidian: command not found` | Install obsidian-cli, check PATH |
| `obsidian "The Forge"` fails | Open Obsidian Desktop first, enable CLI in Settings |
| Vault notes not showing | Obsidian Desktop must be running for CLI IPC |
| API key errors | Check `ANTHROPIC_API_KEY` is exported in shell |

---

## Ongoing Maintenance

| When | Action |
|------|--------|
| Priorities shift | Update `context/current-priorities.md` |
| Start a new quarter | Update `context/goals.md` |
| New W2 role or stack change | Update `context/work.md` |
| Significant decision | Append to `decisions/log.md` |
| Build a new skill | Run `/skill-builder build <name>` |

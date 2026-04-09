# New Machine Setup

Steps to get the ai-projects assistant system fully operational on a new machine.

---

## 1. Prerequisites

Install these before anything else:

| Tool | Install | Verify |
|------|---------|--------|
| Claude Code | `npm install -g @anthropic/claude-code` | `claude --version` |
| obsidian-cli | `brew install obsidian-cli` or follow repo instructions | `which obsidian` |
| git | Included on macOS via Xcode CLT | `git --version` |
| Node / npm | `brew install node` | `node --version` |

---

## 2. Clone the Repo

```bash
git clone <repo-url> ~/repos/mine/ai-projects
cd ~/repos/mine/ai-projects
```

---

## 3. Symlink Global Skills

Makes all root-level skills available from any project on the device -- not just when launched from this repo.

```bash
SKILLS_SRC="$HOME/repos/mine/ai-projects/.claude/skills"
SKILLS_GLOBAL="$HOME/.claude/skills"

mkdir -p "$SKILLS_GLOBAL"

for skill_dir in "$SKILLS_SRC"/*/; do
  skill_name=$(basename "$skill_dir")
  ln -sf "$skill_dir" "$SKILLS_GLOBAL/$skill_name"
  echo "Linked: $skill_name"
done
```

Verify:
```bash
ls -la ~/.claude/skills/
```

Each entry should be a symlink pointing into `~/repos/mine/ai-projects/.claude/skills/`.

**When you add a new root-level skill later**, register it with:
```bash
ln -sf ~/repos/mine/ai-projects/.claude/skills/<skill-name>/ ~/.claude/skills/<skill-name>
```

---

## 4. Configure MCP Servers

Each domain that uses an MCP server needs credentials or environment variables. Set these up before using that domain.

| Domain | Server | What's Needed |
|--------|--------|---------------|
| finances | Monarch Money | API token in env or MCP config |
| real-estate | RentCast | API key |
| real-estate | REICalc | (check domain `.mcp.json`) |
| brain | obsidian-cli | obsidian-cli binary on PATH, vault at `/Users/<you>/Obsidian/The Mind/` |

Update the vault path in `brain/CLAUDE.md` and `brain/.claude/skills/second-brain/SKILL.md` if your vault lives elsewhere.

---

## 5. Configure obsidian-cli Plugin

The `brain/` and `project-initializer/` domains require the obsidian-cli Claude Code plugin. Verify it's enabled:

```bash
cat brain/.claude/settings.json
# Should show: {"enabledPlugins": {"obsidian-cli@obsidian-cli-skill": true}}
```

If the plugin isn't installed, follow the obsidian-cli repo setup instructions to install it as a Claude Code plugin.

---

## 6. Update Context Files

These files drive prioritization and goal-setting across all domains. Update them to reflect your current situation:

- `context/me.md` -- identity, role, #1 priority
- `context/work.md` -- ventures, tech stack, connected MCP servers
- `context/current-priorities.md` -- ranked focus areas (re-rank at the start of each week)
- `context/goals.md` -- quarterly goals (re-write at the start of each quarter)

---

## 7. Verify the Setup

From the repo root, start a Claude Code session and run:

```
/briefing
```

If it returns a morning briefing with calendar, priorities, and financial pulse, the core system is working.

Then test a domain-specific skill:

```
/second-brain review
```

Should run a vault health check against your Obsidian vault.

---

## 8. Optional: CLAUDE.local.md

`CLAUDE.local.md` at the repo root is gitignored. Use it for machine-specific overrides -- local paths, personal API keys referenced by name, or dev environment notes that don't belong in the shared repo.

---

## Ongoing Maintenance

| When | Action |
|------|--------|
| Add a new root-level skill | Run the `ln -sf` command from Step 3 |
| Priorities shift | Update `context/current-priorities.md` |
| Start a new quarter | Update `context/goals.md` |
| Make a significant decision | Append to `decisions/log.md` |
| Add a new domain | Follow domain creation pattern in `CLAUDE.md`; add MCP servers to root `.mcp.json` |

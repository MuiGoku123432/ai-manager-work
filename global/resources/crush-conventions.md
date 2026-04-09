# Crush Conventions

Reference for building skills, configuring projects, and working with the Agent Skills standard in Crush CLI.

---

## Skill Structure (Agent Skills Standard)

Skills are folders containing a `SKILL.md` file. Crush discovers them from both global and project paths.

```
<skill-name>/
  SKILL.md
  references/           (optional -- load on demand, NOT at startup)
    <reference>.md
```

### SKILL.md Format

```markdown
# <Skill Name>

<1-2 sentence description of what this skill does and when to use it.>

## Available Commands

| Command | Description |
|---------|-------------|
| `<command>` | <description> |

If no command is specified, infer the best action from context.

## How to Execute

<Describe tools, services, file paths, and CLI commands used. Be specific.>

## Workflow Execution Pattern

Every workflow follows:
1. **Gather** -- parallel reads/searches to build context
2. **Analyze** -- classify, score, or evaluate
3. **Report** -- structured summary
4. **Execute** -- only after user confirms for destructive ops

## Reference Files

Load on demand -- do NOT load all at startup:
- `references/<file>.md` -- <description>

## Notes

- <Important caveats or edge cases>
```

### Key Rules

- No frontmatter required (unlike Claude Code's SKILL.md which needed name/description/model fields)
- No `model:` field -- Crush uses the `coder` role for skills; `task` role for sub-agents
- Reference files are loaded on demand, never at startup
- Keep main SKILL.md under 200 lines; offload detail to references
- Every workflow: Gather -> Analyze -> Report -> Execute

---

## Config File Structure (`.crush.json`)

```json
{
  "$schema": "https://charm.land/crush.json",
  "options": {
    "initialize_as": "AGENTS.md",
    "context_paths": ["path/to/additional-context.md"],
    "skills_paths": [".crush/skills"],
    "disabled_tools": ["tool-name"],
    "disabled_skills": ["skill-name"]
  },
  "permissions": {
    "allowed_tools": ["Bash(obsidian *)"]
  },
  "mcp": {
    "<server-name>": {
      "type": "stdio",
      "command": "path/to/server",
      "args": [],
      "env": {},
      "timeout": 120,
      "disabled": false
    }
  }
}
```

### Config Merge Order (lowest to highest priority)

1. `~/.config/crush/crush.json` (global)
2. Any `crush.json` found walking up from CWD
3. `.crush/crush.json` (workspace -- highest priority)
4. `.crush.json` (project root)

### Key Config Options

| Option | Purpose |
|--------|---------|
| `options.initialize_as` | Name of the context file to create via `/init` (default: `AGENTS.md`) |
| `options.context_paths` | Additional files loaded as context (supports `~` and env vars) |
| `options.skills_paths` | Additional skill discovery directories |
| `options.disabled_tools` | Hide specific built-in tools |
| `options.disabled_skills` | Disable specific skills by name |
| `permissions.allowed_tools` | Auto-approve specific tool patterns |

---

## Skill Discovery Paths

Crush scans all of these for `SKILL.md` files (follows symlinks):

**Global (available everywhere):**
1. `$CRUSH_SKILLS_DIR` (env override)
2. `~/.config/agents/skills/` (cross-tool standard)
3. `~/.config/crush/skills/`
4. Any path in `options.skills_paths` from the global config

**Project-relative:**
1. `.agents/skills/`
2. `.crush/skills/`
3. `.claude/skills/` (Claude Code compatibility)
4. `.cursor/skills/` (Cursor compatibility)
5. Any path in `options.skills_paths` from the project config

**Deduplication:** If two skills have the same name, the last discovered wins. Project skills override global skills.

---

## Agent Tool Usage

Crush's built-in `agent` tool spawns a sub-task using the `task` agent role. No model selection -- it uses whatever model is configured for `task` in crush.json.

```
# Basic sub-task
agent("Do X and return the result as Y format")

# With context
agent("
  Context: <background info>
  Task: <specific action>
  Return: <expected output format>
")
```

Use agent templates from `~/.config/crush/agents/` as starting points. See `agent-prompt-patterns.md` for usage patterns.

---

## Built-in Tools

| Tool | Description |
|------|-------------|
| `glob` | Find files by pattern |
| `grep` | Search file contents |
| `ls` | List directories |
| `view` | Read file contents |
| `write` | Write files |
| `edit` | Edit files (targeted changes) |
| `patch` | Apply diffs |
| `bash` | Execute shell commands |
| `fetch` | HTTP requests |
| `sourcegraph` | Code search across public repos |
| `agent` | Spawn sub-agent tasks |
| `diagnostics` | LSP diagnostics |

---

## Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Skill folder | kebab-case | `second-brain/` |
| Skill name (in AGENTS.md) | `/kebab-case` | `/second-brain` |
| Reference files | kebab-case | `vault-conventions.md` |
| Agent template files | kebab-case | `capture-agent.md` |
| Project config | `.crush.json` | at repo root |
| Workspace config | `.crush/crush.json` | highest priority |

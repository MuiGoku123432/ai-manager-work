# Claude Code Conventions

Reference doc for building Claude Code domains within this system. Captures exact frontmatter formats, model assignment strategy, WAT rules, and the post-scaffold workflow. Use this when scaffolding a new Claude Code domain project.

---

## Agent Frontmatter

Every agent definition lives at `<domain>/.claude/agents/<agent-name>.md`. Required fields:

```markdown
---
name: <agent-name>
description: <what this agent does and when to spawn it>
tools: "*"
---

You are <role>. <Persona description>. ...
```

**Rules:**
- `tools: "*"` -- quoted or unquoted both work; quoted is the dominant pattern in this repo
- NO `model:` field in agent frontmatter -- model is set at spawn time by the calling agent
- `name` must be kebab-case and match the filename (without `.md`)
- `description` should be specific enough that init-lead or another orchestrator knows exactly when to delegate

**Example:**
```markdown
---
name: research-scout
description: Vault research specialist -- searches the Obsidian vault for prior art, existing projects, prior decisions, and area connections. Delegate all vault searches to this agent during the research and vet phases.
tools: "*"
---

You are a vault research specialist. Your role is to search Connor's Obsidian vault...
```

---

## SKILL.md Frontmatter

Every skill lives at `<domain>/.claude/skills/<skill-name>/SKILL.md`. Supported fields:

```markdown
---
name: <skill-name>
description: <trigger description -- what user input invokes this skill>
argument-hint: [command] [arguments]
model: sonnet
---
```

**Field notes:**
- `name` -- kebab-case, matches the directory name
- `description` -- can be single-line or multi-line with `>` notation:
  ```yaml
  description: >
    Use when the user asks about finances, budgets, spending,
    net worth, or cash flow. Also triggers on "money", "budget check",
    "how am I doing financially".
  ```
- `argument-hint` -- optional, shown in skill listings; use format `[command] [arguments]`
- `model` -- optional; sets the default model for the skill. `sonnet` for most skills; `opus` for open-ended, exploratory, or ambiguous skills (e.g., `/trip-planner`)
- If `model` is omitted, defaults to whatever the invoking context uses

---

## Model Assignment Strategy

| Use Case | Model | Reason |
|----------|-------|--------|
| Lead agents, orchestrators | sonnet | Good judgment, cost-effective at this tier |
| Complex analysis, synthesis, writing | sonnet | Quality needed; can't be delegated down |
| Vault search, CRUD, structured lookups | haiku | Deterministic tasks, no nuanced judgment needed |
| File creation, wiring, scaffolding | haiku | Template-driven, low ambiguity |
| Open-ended exploration, trip planning | opus | Unstructured, creative, needs wider context |
| Root-level skill invocation (default) | sonnet | Safe middle ground |

**Adjustment rules:**
- Downgrade to haiku when: the agent's job is to call a CLI, fill a template, or run a search and return structured data
- Upgrade to opus when: the task has no clear success criteria and benefits from broader knowledge and creativity
- Never assign haiku to agents that make judgment calls (scoring, risk assessment, architecture decisions)

---

## Domain CLAUDE.md Structure

Every domain `CLAUDE.md` should follow this section order:

```markdown
# <Domain Title>

<One-paragraph description of what this domain does, what powers it (MCP, CLI, APIs), and when to use it.>

## Prerequisites

<Any API keys, env vars, binaries, or MCP servers required. Include how to verify (e.g., `which obsidian`).>

## Available Skill

### `/<skill-name>`

<One-paragraph description of the skill and its subcommands.>

| Command | Purpose |
|---------|---------|
| `<subcommand>` | <description> |

## Agent Team

| Agent | Focus | Workflows | Recommended Model |
|-------|-------|-----------|------------------|
| **<lead-agent>** | Lead -- <role> | <assigned workflows> | sonnet |
| **<specialist>** | <role> | <assigned workflows> | haiku |

## Usage Guidance

- <How to invoke the skill>
- <When to spawn agents directly>
- <Any important behavioral notes (ask-before-creating, etc.)>

## Decision Log Integration

<How this domain logs decisions to `decisions/log.md`, if applicable.>
```

**Required sections:** title, prerequisites, available skill, agent team, usage guidance.
**Optional sections:** decision log integration (include if the domain appends to `decisions/log.md`).

---

## settings.json Patterns

`<domain>/.claude/settings.json` has two common forms:

**Empty (no plugins):**
```json
{}
```
Use for: finances, real-estate, project-initializer (after obsidian-cli is loaded), and any domain with no special plugins.

**Obsidian CLI plugin:**
```json
{
  "enabledPlugins": {
    "obsidian-cli@obsidian-cli-skill": true
  }
}
```
Use for: `brain/`, `project-initializer/` -- any domain that uses `obsidian` CLI commands.

**No other plugin patterns exist in this repo yet.** Add new patterns here as they're introduced.

---

## .mcp.json Patterns

**Empty (no MCP servers for this domain):**
```json
{
  "mcpServers": {}
}
```

**With MCP servers (example from finances):**
```json
{
  "mcpServers": {
    "monarch-money": {
      "command": "uvx",
      "args": ["monarch-mcp"]
    }
  }
}
```

When adding a new domain with MCP servers, also add those servers to the root `.mcp.json` so they're available during cross-domain orchestration from the project root.

---

## WAT Framework Rules

**W -- Workflows** (`workflows/`): Markdown SOPs. Don't create or overwrite without asking. They represent Connor's accumulated process decisions.

**A -- Agents** (you): Intelligent coordination, sequencing, failure recovery. Spawn specialists for parallel work. Delegate deterministic tasks down to haiku agents.

**T -- Tools** (`tools/`): Deterministic scripts. Always check `tools/` for an existing script before attempting a task directly or building something new.

**Behavioral rules:**
1. Check `tools/` first -- if a script exists, use it
2. Don't create or overwrite workflows without asking
3. If a task uses paid API calls or credits, ask before running
4. Nothing is written without a pre-flight plan and explicit user confirmation
5. `decisions/log.md` is append-only -- never edit or delete prior entries

---

## Post-Scaffold Skills

After scaffolding a new Claude Code domain, use these root-level skills to build out the agent team and skills:

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| `/skill-builder` | Build or audit a single SKILL.md | After domain scaffold, for each skill |
| `/agent-builder` | Build or audit a single agent definition | After domain scaffold, for each agent |
| `/team-builder` | Build or audit a full lead+specialist team | When defining the full agent team at once |
| `/recursive-research` | Deep external research on any topic | Before vetting, when vault has no prior art |

**Recommended post-scaffold sequence for a Claude Code domain project:**
1. Run `/recursive-research start <topic>` if external research will inform architecture
2. Run `/team-builder` to define the full agent team (lead + specialists, model assignments)
3. Run `/skill-builder` to build each skill definition
4. Populate `references/` files as needed

---

## Context Loading Behavior

**When launched from the domain directory** (e.g., `cd project-initializer/`):
- Domain `CLAUDE.md` loads as project context
- Root `CLAUDE.md` does NOT load automatically

**When launched from repo root with `--add-dir`** (e.g., `claude --add-dir project-initializer/`):
- Root `CLAUDE.md` loads
- Domain `CLAUDE.md` also loads
- Both are active simultaneously -- domain takes precedence within its files

**Global skills (available everywhere):**
All root-level skills are symlinked into `~/.claude/skills/` so they're available from any project on the device -- no `--add-dir` required:
```
~/.claude/skills/agent-builder  -> ai-projects/.claude/skills/agent-builder/
~/.claude/skills/briefing       -> ai-projects/.claude/skills/briefing/
~/.claude/skills/project-init   -> ai-projects/.claude/skills/project-init/
~/.claude/skills/recursive-research -> ai-projects/.claude/skills/recursive-research/
~/.claude/skills/review         -> ai-projects/.claude/skills/review/
~/.claude/skills/skill-builder  -> ai-projects/.claude/skills/skill-builder/
~/.claude/skills/team-builder   -> ai-projects/.claude/skills/team-builder/
~/.claude/skills/trip-planner   -> ai-projects/.claude/skills/trip-planner/
```

The actual files stay in the git repo (versioned, editable). The symlinks just point to them. When you add a new root-level skill, run:
```bash
ln -sf /Users/cfanch06/repos/mine/ai-projects/.claude/skills/<skill-name>/ ~/.claude/skills/<skill-name>
```

---

## Naming Conventions Summary

| Item | Convention | Example |
|------|-----------|---------|
| Domain folders | kebab-case | `project-initializer/`, `recursive-research/` |
| Agent names + filenames | kebab-case | `init-lead.md`, `research-scout.md` |
| Skill names + directories | kebab-case | `project-init/`, `recursive-research/` |
| Obsidian project notes | Title Case | `Sentinovo Migration Frontend.md` |
| Git repo project folders | kebab-case | `sentinovo-migration-frontend/` |
| Reference files | kebab-case | `scoring-rubric.md`, `wiki-conventions.md` |
| Research topic slugs | kebab-case | `mcp-server-patterns`, `battery-chemistry` |

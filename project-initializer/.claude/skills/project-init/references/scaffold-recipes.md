# Scaffold Recipes

Directory and file patterns for each project type. Used by `scaffold-agent` to create the correct structure. Select the recipe that matches the project type confirmed during planning.

---

## Recipe 1: Standard Project

Use for any project that doesn't require a dedicated Claude Code domain.

**Creates:**
- `projects/<name>/README.md` in the Git repo
- `30-Projects/<Title>.md` in Obsidian

**Git repo README.md template:**
```markdown
# <Project Title>

<One-sentence description of what this project is and what it produces.>

**Status:** Active
**Start Date:** YYYY-MM-DD
**Target Date:** YYYY-MM-DD
**Area:** <parent life area>

## Key Dates
| Milestone | Date | Notes |
|-----------|------|-------|
| Project start | YYYY-MM-DD | |
| Phase 1 complete | YYYY-MM-DD | |
| Done | YYYY-MM-DD | |

## Related
- Obsidian: `30-Projects/<Title>.md`
```

**Obsidian note:** Use Variant 1 from `project-note-template.md`.

---

## Recipe 2: Claude Code Domain Project

Use when the project is building a new Claude Code domain (agents, skills, CLAUDE.md).

**Creates:**
- `projects/<name>/README.md` in the Git repo
- `30-Projects/<Title>.md` in Obsidian (Variant 2)
- `<domain-name>/` -- full domain scaffold

**Domain scaffold:**
```
<domain-name>/
  CLAUDE.md
  .mcp.json
  .claude/
    settings.json
    agents/
    skills/
```

**`<domain-name>/CLAUDE.md` starter template:**
```markdown
# <Domain Title>

<One-paragraph description of what this domain does and what powers it.>

## Prerequisites

<List any API keys, env vars, MCP servers, or binaries required.>

## Available Skill

### `/<skill-name>`

<Description of the skill and its subcommands.>

| Command | Purpose |
|---------|---------|
| `<subcommand>` | <description> |

## Agent Team

| Agent | Focus | Workflows |
|-------|-------|-----------|
| **<lead-agent>** | Lead -- <description> | <workflows> |

## Usage Guidance

- **Interactive use**: Run `/<skill-name>` or `/<skill-name> <subcommand>`
- **Lead agent**: Start with `<lead-agent>` for a holistic view
```

**`<domain-name>/.mcp.json` (empty, update later):**
```json
{
  "mcpServers": {}
}
```

**`<domain-name>/.claude/settings.json` (empty, update later):**
```json
{}
```

**Post-scaffold next steps (Claude Code domain):**
After confirming the scaffold, recommend the following sequence to the user:
1. `/recursive-research start <topic>` -- if external research will inform architecture (optional)
2. `/team-builder` -- define the full agent team (lead + specialists with model assignments)
3. `/skill-builder` -- build each skill definition
4. Populate `references/` files

For exact agent frontmatter, SKILL.md format, model assignment strategy, and WAT rules, see `references/claude-code-conventions.md`.

---

## Recipe 3: Claude Code Skill Only

Use when the project adds a new skill to an existing domain (or root), without a new domain.

**Creates:**
- `projects/<name>/README.md` in the Git repo (optional, skip if minor)
- `30-Projects/<Title>.md` in Obsidian (Variant 1)
- Skill directory at the target path

**Skill scaffold:**
```
<target-domain>/.claude/skills/<skill-name>/
  SKILL.md
  references/           (create only if references will be needed)
```

**`SKILL.md` starter template:**
```markdown
---
name: <skill-name>
description: Use when <trigger phrase>. Also triggers on <alternative phrases>.
argument-hint: [command] [arguments]
model: sonnet
---

## What This Skill Does

<1-2 paragraphs explaining what this skill does and when to use it.>

## Available Commands

| Command | Description |
|---------|-------------|
| `<command>` | <description> |

If no command is specified, infer the best action from context.

## How to Execute

<Describe the tools and services used (obsidian CLI, MCP servers, Bash, etc.)>

## Workflow Execution Pattern

Every workflow follows the same pattern:
1. **Gather** -- run parallel searches/reads to build context
2. **Analyze** -- classify, score, or evaluate what was found
3. **Report** -- present findings as a table or structured summary
4. **Execute** -- only after user confirms, make the changes

## Reference Files

Load on demand -- do NOT load all at startup:
- `references/<file>.md` -- <description>

## Notes

- <Any important caveats or edge cases>
```

---

## Recipe 4: Content / Trip Project

Use for The Narrow Road episodes, overlanding trips, or event-based content projects.

**Creates:**
- `projects/<name>/README.md` in the Git repo
- `30-Projects/<Title>.md` in Obsidian (Variant 3)

**Git repo README.md template:**
```markdown
# <Project Title>

<One-sentence description: destination, content goal, dates.>

**Status:** Active
**Trip Dates:** YYYY-MM-DD to YYYY-MM-DD
**Content Type:** <YouTube episode / planning trip / gear test>
**Area:** The Narrow Road

## Key Dates
| Milestone | Date | Notes |
|-----------|------|-------|
| Planning complete | YYYY-MM-DD | |
| Departure | YYYY-MM-DD | |
| Return | YYYY-MM-DD | |
| Video published | YYYY-MM-DD | |

## Related
- Obsidian: `30-Projects/<Title>.md`
- Trip planner skill: `/trip-planner <destination>`
```

**Obsidian note:** Use Variant 3 from `project-note-template.md`.

---

## Post-Scaffold Checklist

After creating the project files, `scaffold-agent` should verify and complete:

- [ ] Git repo `projects/<name>/README.md` created
- [ ] Obsidian `30-Projects/<Title>.md` created with correct frontmatter
- [ ] Parent area note linked (read-modify-write to append `[[<Title>]]` in Connected Projects section)
- [ ] Relevant MOC in `70-Atlas/` updated (or created if none exists)
- [ ] Relationship metadata added to Obsidian note (`depends-on`, `feeds-into`, `supports` as applicable)
- [ ] `decisions/log.md` updated with project creation entry
- [ ] Root `CLAUDE.md` updated if new domain was created (add to Domain Structure, Skills, Agent Teams tables)
- [ ] Root `.mcp.json` updated if new MCP servers were added

---

## Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Git repo folder | kebab-case | `sentinovo-migration-frontend` |
| Obsidian project note | Title Case | `Sentinovo Migration Frontend.md` |
| Claude Code domain folder | kebab-case | `project-initializer/` |
| Agent names | kebab-case | `init-lead`, `research-scout` |
| Skill names | kebab-case | `project-init` |

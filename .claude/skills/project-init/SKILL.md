---
name: project-init
description: Use when someone wants to start a new project, vet a project idea, research prior art, plan a project, scaffold project files, or check project initialization status. Also triggers on "new project", "bootstrap project", "should I build X", "initialize project", "set up project".
argument-hint: [command] [project-name-or-description]
model: sonnet
---

Full skill definition lives at `project-initializer/.claude/skills/project-init/SKILL.md`.

This file makes `/project-init` callable from the repo root. Load the full skill from the subdomain:

```
Read: project-initializer/.claude/skills/project-init/SKILL.md
```

Then execute the requested subcommand using the workflows defined there. Reference files are at:
- `project-initializer/.claude/skills/project-init/references/project-note-template.md`
- `project-initializer/.claude/skills/project-init/references/vetting-criteria.md`
- `project-initializer/.claude/skills/project-init/references/scaffold-recipes.md`
- `project-initializer/.claude/skills/project-init/references/obsidian-wiring-sequences.md`

## Available Commands

| Command | Description |
|---------|-------------|
| `init <name>` | Full guided pipeline: research -> vet -> plan -> scaffold |
| `research <topic>` | Search vault and repo for prior art, related decisions, existing projects |
| `vet <idea>` | Score the idea against priorities, goals, capacity, and feasibility (0-100) |
| `plan <name>` | Create structured project plan with scope, phases, WAT mapping |
| `scaffold <name>` | Create Git repo folder + Obsidian note + wire all vault links |
| `status [name]` | Cross-reference Git repo and Obsidian vault, flag sync gaps |

If no command specified, start `init` and prompt for the project name.

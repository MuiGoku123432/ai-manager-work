# Project Initializer

Bootstrap system for new coding projects. Researches prior art in the Obsidian vault, vets ideas against current priorities, plans structure and phasing, scaffolds both the Git repo and the Obsidian vault, and wires everything together with proper links and MOC entries.

**Use this domain when starting any new project.** Point a new Claude Code session here via `--add-dir` or `cd project-initializer/` to get the full initialization workflow.

## Prerequisites

The `obsidian` CLI binary must be available on PATH. Verify with:
```bash
which obsidian
```

The obsidian-cli plugin is enabled in `.claude/settings.json`. No MCP servers are required -- this domain uses the obsidian CLI + standard tools only.

Context files at the repo root are read directly:
- `context/current-priorities.md`
- `context/goals.md`
- `context/work.md`
- `decisions/log.md`

## Available Skill

### `/project-init`

Full project initialization workflow with 6 subcommands:

| Command | Purpose |
|---------|---------|
| `init <name>` | Full guided pipeline: research -> vet -> plan -> scaffold |
| `research <topic>` | Search vault and repo for prior art, related decisions, existing projects |
| `vet <idea>` | Score the idea against priorities, goals, capacity, and feasibility (0-100) |
| `plan <name>` | Create structured project plan with scope, phases, WAT mapping |
| `scaffold <name>` | Create Git repo folder + Obsidian note + wire all vault links |
| `status [name]` | Cross-reference Git repo and Obsidian vault, flag sync gaps |

Use without a subcommand to start `init` with prompting for the project name.

## Agent Team

| Agent | Focus | Workflows | Recommended Model |
|-------|-------|-----------|------------------|
| **init-lead** | Lead orchestrator -- routes subcommands, manages pipeline, enforces ask-before-creating, logs decisions | init, vet, plan, status | sonnet |
| **research-scout** | Vault search, prior art discovery, duplicate detection | research, vet (Phase 1) | haiku |
| **scaffold-agent** | Git file creation, Obsidian note creation, vault link wiring, domain scaffold | scaffold | haiku |

## Usage Guidance

- **Full guided flow**: Run `/project-init` or `/project-init init <name>` -- walks through all phases with user gates
- **Individual phases**: Use subcommands separately when you have context from a prior session
- **Agent delegation**: Spawn `research-scout` and `scaffold-agent` directly for parallel work on research and status checks
- **From root**: `/project-init` is also installed at the root level and callable from anywhere in the repo
- **Ask-before-creating**: Nothing is written without a pre-flight plan and explicit confirmation -- this applies to every file and every vault operation

## Decision Log Integration

All project decisions are logged to `decisions/log.md` at the repo root:
- Project approved: log with rationale and scope
- Project deferred: log with reason
- Project rejected: log with reason

The log is append-only. Never edit or delete prior entries.

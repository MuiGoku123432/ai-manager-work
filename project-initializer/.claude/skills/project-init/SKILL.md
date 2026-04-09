---
name: project-init
description: Use when someone wants to start a new project, vet a project idea, research prior art, plan a project, scaffold project files, or check project initialization status. Also triggers on "new project", "bootstrap project", "should I build X", "initialize project", "set up project".
argument-hint: [command] [project-name-or-description]
model: sonnet
---

## What This Skill Does

Bootstrap system for new coding projects. Guides through research, vetting, planning, and scaffolding -- then wires everything into the Obsidian vault with proper structure, links, and MOC entries.

Never creates files without user confirmation. Every write operation is preceded by a pre-flight report showing exactly what will be created.

## Available Commands

| Command | Description |
|---------|-------------|
| `init <name>` | Full guided pipeline: research -> vet -> plan -> scaffold |
| `research <topic>` | Search vault and repo for prior art, related decisions, existing projects |
| `vet <idea>` | Score the project idea against priorities, goals, capacity, and feasibility |
| `plan <name>` | Create a structured project plan with scope, phases, and WAT mapping |
| `scaffold <name>` | Create Git repo folder + Obsidian note + wire all vault links |
| `status [name]` | Show initialization status of a project, or cross-reference Git vs Obsidian |

If no command is specified, infer from context. If ambiguous, default to `init` and ask for the project name.

## How to Execute

Vault: "The Mind" | Path: `/Users/cfanch06/Obsidian/The Mind/`

All vault operations use the `obsidian` CLI via Bash:
- `obsidian search query="<query>"` -- keyword search
- `obsidian search:context query="<query>"` -- contextual search
- `obsidian files folder="<path>"` -- list files in folder
- `obsidian read path="<path>"` -- read note content
- `obsidian create path="<path>" content="<text>"` -- create new note
- `obsidian create path="<path>" content="<text>" --overwrite` -- update existing note (always use for updates)
- `obsidian create path="<path>" content="<text>" --append` -- append to existing note
- `obsidian frontmatter "<path>" --edit --key "<key>" --value "<value>"` -- update single frontmatter field
- `obsidian move path="<old>" to="<new>"` -- move or rename (updates all wikilinks)

**Warning:** `obsidian create` without `--overwrite` creates a numbered duplicate (e.g., `Note 1.md`). For complex edits, prefer Read + Edit tools directly on the vault path.

Context files (always read fresh, not from memory):
- `context/current-priorities.md` -- ranked priorities and time-sensitive items
- `context/goals.md` -- Q2 goals and milestones
- `context/work.md` -- tech stack and active ventures
- `decisions/log.md` -- prior decisions that may be relevant

For detailed CLI sequences per workflow, see [references/obsidian-wiring-sequences.md](references/obsidian-wiring-sequences.md).

## Workflow Execution Pattern

1. **Gather** -- parallel vault searches and context file reads
2. **Analyze** -- score, classify, or evaluate findings
3. **Report** -- present findings or creation plan to user
4. **Confirm** -- user approves before any write operation
5. **Execute** -- create files and wire vault connections

Never skip step 4 for any write operation (Git files, Obsidian notes, `decisions/log.md`, root `CLAUDE.md`).

---

## Workflow 1: Research (`research <topic>`)

### Phase 1 -- Gather (PARALLEL)
```
obsidian search query="<topic>"
obsidian search:context query="<topic>"
obsidian files folder="30-Projects"
obsidian search query="<topic>" folder="20-Areas"
```
Also read `decisions/log.md` from the Git repo. Check `projects/` directory for existing folders matching the topic.

### Phase 2 -- Deep Read
For top 5 matching vault notes:
```
FOR EACH match:
  obsidian read path="<match-path>"
```

### Phase 3 -- Report
Present findings as:
- **Existing projects** -- what's already in `30-Projects/` and `projects/` that overlaps
- **Prior decisions** -- relevant entries from `decisions/log.md`
- **Area connections** -- which `20-Areas/` notes this would connect to
- **Resources** -- relevant notes in `40-Resources/`
- **Assessment** -- is this genuinely new, or does something similar already exist?

Label overlap level: None / Adjacent / Significant / Duplicate.

If overlap is None or Adjacent AND the topic involves external knowledge: offer to run `/recursive-research start <topic>` to build a web-sourced knowledge base before vetting. The resulting wiki in `projects/<slug>/wiki/` can ground the vet and plan phases in real external research.

---

## Workflow 2: Vet (`vet <idea>`)

### Phase 1 -- Gather Context (PARALLEL)
```
Read: context/current-priorities.md
Read: context/goals.md
Read: context/work.md
obsidian search query="status: active"    (count active projects)
```
Also run the full `research` workflow (Phase 1-3) to get prior art.

### Phase 2 -- Score
Load `references/vetting-criteria.md`. Score 5 criteria (0-10 each), compute weighted total.

| Criterion | Weight |
|-----------|--------|
| Priority Alignment | 30% |
| Feasibility | 25% |
| Tech Stack Fit | 15% |
| Uniqueness | 15% |
| Timeline Clarity | 15% |

**Score labels:** 80-100 Green Light, 60-79 Worth Considering, 40-59 Needs Refinement, 0-39 Defer.

### Phase 3 -- Report
```
## Vet Report: <Project Name>
Score: XX/100 (Label)

| Criterion | Weight | Raw Score | Weighted | Notes |
|-----------|--------|-----------|----------|-------|
...

Recommendation: <label>
Key Strengths: ...
Key Concerns: ...

Active project count: X (capacity: normal / mild concern / critical)
Closest existing project: [[<name>]] or "none found"

Decision needed: Approve, refine, or defer?
```

### Phase 4 -- Decision Log
On user answer, append to `decisions/log.md`:
```
[YYYY-MM-DD] DECISION: <Approved / Deferred / Rejected> project "<name>" | REASONING: <user's stated reason or vet score rationale> | CONTEXT: <brief scope description>
```

---

## Workflow 3: Plan (`plan <name>`)

Assumes project has been vetted or user is skipping vetting.

### Phase 1 -- Gather
Run `research <name>` if not already done. Read `context/work.md` for stack context. Find parent area note via vault search.

### Phase 2 -- Generate Plan
Present the following for user review and refinement:

1. **Goal** -- one clear sentence defining "done"
2. **Scope** -- what is in scope / explicitly out of scope
3. **Project Type** -- Standard / Claude Code Domain / Skill Only / Content (determines scaffold recipe)
4. **Phases** -- 3-5 phases with clear deliverables per phase and estimated durations
5. **Tech Stack** -- languages, frameworks, tools, MCP servers needed
6. **WAT Mapping** (if Claude Code project):
   - Workflows to create
   - Agents needed (lead + specialists with model assignments)
   - Tools (scripts) needed
   - Skills to build
7. **Dependencies** -- what must complete first? What does this feed into?
8. **Risks and Blockers** -- known risks with mitigation strategies
9. **Timeline** -- estimated start date, target date, phase durations
10. **Parent Area** -- which `20-Areas/` note this connects to
11. **Relationships** -- `depends-on`, `feeds-into`, `supports` any existing projects?

### Phase 3 -- Confirm
Ask: "Ready to scaffold, or do you want to adjust the plan?"

---

## Workflow 4: Scaffold (`scaffold <name>`)

Assumes a plan exists from the `plan` phase or user provides the relevant details.

### Phase 1 -- Pre-flight Duplicate Check (PARALLEL)
```
obsidian search query="<Project Title>"
obsidian search:context query="<project description>"
obsidian files folder="30-Projects"
```
Also check Git repo: `ls projects/`. If either exists, present options: update existing, create alongside, or abort.

### Phase 2 -- Present Creation Plan
Show exactly what will be created before doing anything:
```
## Scaffold Plan: <Project Name>

Git Repo:
  projects/<name>/README.md

Obsidian Vault:
  30-Projects/<Project Title>.md
    - Template: <Variant 1 / 2 / 3>
    - Status: active | Area: <area> | Target: YYYY-MM-DD

Vault Wiring:
  - Append [[<Project Title>]] to 20-Areas/<Area>.md
  - Update 70-Atlas/MOC - <Topic>.md (or create new)
  - Add relationship metadata: <depends-on / feeds-into / supports if applicable>

<If Claude Code domain project:>
Domain Scaffold:
  <domain-name>/CLAUDE.md
  <domain-name>/.mcp.json
  <domain-name>/.claude/settings.json
  <domain-name>/.claude/agents/
  <domain-name>/.claude/skills/

Root Updates:
  CLAUDE.md -- add domain, skill, and agent team entries
```

Ask: "Create all of the above?"

### Phase 3 -- Execute (on confirmation)
Follow the full scaffold sequence from `references/obsidian-wiring-sequences.md`, Sequence 6.

Load `references/project-note-template.md` for the Obsidian note content.
Load `references/scaffold-recipes.md` for the correct project type recipe.

### Phase 4 -- Decision Log
Append to `decisions/log.md`:
```
[YYYY-MM-DD] DECISION: Created project "<name>" | REASONING: <vet score or user rationale> | CONTEXT: <one-sentence scope>
```

### Phase 5 -- Report
List all created artifacts:
```
## Scaffold Complete: <Project Name>

Created:
- projects/<name>/README.md
- 30-Projects/<Project Title>.md [[<Project Title>]]
- Updated: 20-Areas/<Area>.md
- Updated: 70-Atlas/MOC - <Topic>.md
- decisions/log.md updated

<If Claude Code domain:>
- <domain-name>/ (full domain scaffold)
- Root CLAUDE.md updated

Next steps:
1. Review the Obsidian note and refine phases/tasks
2. Add relationship metadata if any dependencies were identified
3. <Any skill-builder or agent-builder work needed>
```

---

## Workflow 5: Init (`init <name>`)

Orchestrated pipeline that chains Workflows 1-4 with user gates between phases.

```
Phase 1: research <name>
  -> Present research findings
  -> Gate: "Continue to vetting, or stop here?"

Phase 2: vet <name>
  -> Present vet report and score
  -> Gate: "Approve, refine, or defer?"
  -> On defer/reject: log decision, stop

Phase 3: plan <name>
  -> Present structured plan
  -> Gate: "Ready to scaffold, or adjust the plan?"

Phase 4: scaffold <name>
  -> Present creation plan
  -> Gate: "Create all of the above?"
  -> On confirm: execute scaffold
```

User can abort at any gate. If aborting after vetting, still log the decision to `decisions/log.md`.

---

## Workflow 6: Status (`status [name]`)

### If name provided:
```
PARALLEL:
  obsidian search query="<name>"
  obsidian files folder="30-Projects"
```
Check Git repo for `projects/<name>/`. Read any matching Obsidian note. Report: exists in Git / exists in Obsidian / current status / last updated / phases complete.

### If no name provided:

```
PARALLEL:
  obsidian files folder="30-Projects"
  # Bash: ls projects/ in Git repo
```

Cross-reference both lists. Report as a table:
```
| Project | Git Repo | Obsidian | Status | Last Updated | Target Date |
|---------|----------|----------|--------|--------------|-------------|
| <name>  | Yes      | Yes      | active | YYYY-MM-DD   | YYYY-MM-DD  |
| <name>  | Yes      | No       | --     | --           | --          |
| <name>  | No       | Yes      | paused | YYYY-MM-DD   | YYYY-MM-DD  |
```

Flag any projects that exist in only one place as "sync gap -- consider scaffolding the missing record."

---

## Reference Files

Load on demand -- do NOT load all at startup:
- `references/project-note-template.md` -- Obsidian project note templates (3 variants)
- `references/vetting-criteria.md` -- Scoring rubric, weights, output format
- `references/scaffold-recipes.md` -- Directory patterns per project type
- `references/obsidian-wiring-sequences.md` -- Exact CLI sequences for vault wiring
- `references/claude-code-conventions.md` -- Agent/skill frontmatter formats, model assignment strategy, WAT rules, post-scaffold workflow

## Notes

- Always check for duplicates before creating anything
- Never write to any file without presenting a pre-flight plan and getting confirmation
- For best results, use `init` for the full guided pipeline; individual subcommands work best when you already have context from prior steps in the same session
- `decisions/log.md` is append-only -- never edit or delete existing entries
- When creating a Claude Code domain project, use `/skill-builder` and `/agent-builder` skills after scaffold for guided agent and skill definition
- The obsidian `create` command overwrites -- always read before writing to existing notes

# Project Init

Bootstrap system for new W2 engineering projects. Guides through research, vetting, planning, and scaffolding -- then wires everything into the embedded Obsidian vault ("The Forge") with proper structure, links, and MOC entries.

Never creates files without user confirmation. Every write operation is preceded by a pre-flight report showing exactly what will be created.

## Available Commands

| Command | Description |
|---------|-------------|
| `init <name>` | Full guided pipeline: research -> vet -> plan -> scaffold |
| `research <topic>` | Search vault and repo for prior art, related decisions, existing projects |
| `vet <idea>` | Score the project idea against priorities, goals, capacity, and feasibility |
| `plan <name>` | Create a structured project plan with scope, phases, and WAT mapping |
| `scaffold <name>` | Create Git repo folder + Obsidian note + wire all vault links |
| `status [name]` | Show initialization status of a project, or cross-reference Git vs vault |

If no command is specified, infer from context. If ambiguous, default to `init` and ask for the project name.

## How to Execute

**Vault:** "The Forge" | **Path:** `vault/` (embedded, relative)

Use Crush's native file tools for vault CRUD. Use obsidian CLI for search:
```bash
obsidian --vault ./vault search query="<query>"
obsidian --vault ./vault search:context query="<query>"
obsidian --vault ./vault files folder="<path>"
```

Context files (always read fresh, not from memory):
- `context/current-priorities.md`
- `context/goals.md`
- `context/work.md`
- `decisions/log.md`

For detailed vault wiring sequences, see [references/obsidian-wiring-sequences.md](references/obsidian-wiring-sequences.md).

## Workflow Execution Pattern

1. **Gather** -- parallel vault searches and context file reads
2. **Analyze** -- score, classify, or evaluate findings
3. **Report** -- present findings or creation plan to user
4. **Confirm** -- user approves before any write operation
5. **Execute** -- create files and wire vault connections

Never skip step 4 for any write operation.

---

## Workflow 1: Research (`research <topic>`)

### Phase 1 -- Gather (PARALLEL)
```
obsidian --vault ./vault search query="<topic>"
obsidian --vault ./vault search:context query="<topic>"
glob vault/30-Projects/**/*.md
grep -r "<topic>" vault/20-Areas/
```
Also read `decisions/log.md`. Check `projects/` directory for existing folders.

### Phase 2 -- Deep Read
Read the top 5 matching vault notes directly via file tools.

### Phase 3 -- Report
Present:
- **Existing projects** -- what's in `vault/30-Projects/` and `projects/` that overlaps
- **Prior decisions** -- relevant entries from `decisions/log.md`
- **Area connections** -- which `vault/20-Areas/` notes this connects to
- **Assessment** -- is this genuinely new, or does something similar exist?

Label overlap: None / Adjacent / Significant / Duplicate.

If overlap is None or Adjacent AND topic involves external knowledge: offer to run `/recursive-research start <topic>` first.

---

## Workflow 2: Vet (`vet <idea>`)

### Phase 1 -- Gather Context (PARALLEL)
```
Read: context/current-priorities.md
Read: context/goals.md
Read: context/work.md
glob vault/30-Projects/**/*.md   (count active projects)
```
Also run the full `research` workflow.

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
...
Decision needed: Approve, refine, or defer?
```

### Phase 4 -- Decision Log
Append to `decisions/log.md`:
```
[YYYY-MM-DD] DECISION: <Approved / Deferred / Rejected> project "<name>" | REASONING: <reason> | CONTEXT: <brief scope>
```

---

## Workflow 3: Plan (`plan <name>`)

### Phase 1 -- Gather
Run `research <name>` if not done. Read `context/work.md` for stack context.

### Phase 2 -- Generate Plan
Present for user review:
1. **Goal** -- one clear sentence defining "done"
2. **Scope** -- in scope / out of scope
3. **Project Type** -- Standard / Crush Skill / Tool / Research
4. **Phases** -- 3-5 phases with deliverables and durations
5. **Tech Stack** -- languages, frameworks, tools
6. **WAT Mapping** (for Crush projects):
   - Workflows to create
   - Skills to build (`.crush/skills/<name>/`)
   - Tools (scripts) needed
7. **Dependencies** -- what must complete first? What does this feed into?
8. **Risks and Blockers** -- known risks with mitigations
9. **Timeline** -- start date, target date, phase durations
10. **Parent Area** -- which `vault/20-Areas/` note this connects to
11. **Relationships** -- `depends-on`, `feeds-into`, `supports` any existing projects?

### Phase 3 -- Confirm
Ask: "Ready to scaffold, or do you want to adjust the plan?"

---

## Workflow 4: Scaffold (`scaffold <name>`)

### Phase 1 -- Pre-flight Duplicate Check (PARALLEL)
```
obsidian --vault ./vault search query="<Project Title>"
obsidian --vault ./vault search:context query="<project description>"
glob vault/30-Projects/**/*.md
# Bash: ls projects/
```

### Phase 2 -- Present Creation Plan
```
## Scaffold Plan: <Project Name>

Git Repo:
  projects/<name>/README.md

Vault:
  vault/30-Projects/<Project Title>.md
    - Status: active | Area: <area> | Target: YYYY-MM-DD

Vault Wiring:
  - Append [[<Project Title>]] to vault/20-Areas/<Area>.md
  - Update vault/70-Atlas/MOC - <Topic>.md (or create new)
  - Add relationship metadata: <depends-on / feeds-into / supports if applicable>

<If Crush skill project:>
Crush Skill Scaffold:
  .crush/skills/<skill-name>/SKILL.md
  .crush/skills/<skill-name>/references/

Root Updates:
  AGENTS.md -- add skill to available skills table
```

Ask: "Create all of the above?"

### Phase 3 -- Execute (on confirmation)
Follow `references/obsidian-wiring-sequences.md`, Sequence 6.
Load `references/project-note-template.md` for note content.
Load `references/scaffold-recipes.md` for the correct recipe.

### Phase 4 -- Decision Log
Append to `decisions/log.md`:
```
[YYYY-MM-DD] DECISION: Created project "<name>" | REASONING: <rationale> | CONTEXT: <scope>
```

---

## Workflow 5: Init (`init <name>`)

Orchestrated pipeline chaining Workflows 1-4 with user gates.

```
Phase 1: research <name> -> Gate: continue or stop?
Phase 2: vet <name> -> Gate: approve, refine, or defer?
Phase 3: plan <name> -> Gate: scaffold or adjust?
Phase 4: scaffold <name> -> Gate: create all?
```

User can abort at any gate. Log decision to `decisions/log.md` after vetting regardless.

---

## Workflow 6: Status (`status [name]`)

Cross-reference `vault/30-Projects/` and `projects/` repo folder.

Report:
```
| Project | Git Repo | Vault | Status | Last Updated | Target Date |
|---------|----------|-------|--------|--------------|-------------|
```

Flag projects existing in only one place as "sync gap."

---

## Reference Files

Load on demand:
- `references/project-note-template.md` -- Obsidian project note templates (2 variants)
- `references/vetting-criteria.md` -- Scoring rubric, weights, output format
- `references/scaffold-recipes.md` -- Directory patterns per project type (Crush conventions)
- `references/obsidian-wiring-sequences.md` -- Exact sequences for vault wiring

## Notes

- Always check for duplicates before creating anything
- Never write to any file without presenting a pre-flight plan and getting confirmation
- `decisions/log.md` is append-only -- never edit or delete existing entries
- For Crush skill projects, use `/skill-builder` after scaffold for guided SKILL.md authoring

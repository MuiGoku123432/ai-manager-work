# Skill Builder

Build or audit Crush skills following the Agent Skills standard (agentskills.io). Produces `.crush/skills/<name>/SKILL.md` files that work with Crush CLI (and are cross-compatible with Claude Code, Cursor, and other Agent Skills-compatible tools).

## When to Use

Trigger when Connor wants to:
- Build a new skill for a recurring task
- Audit an existing skill for quality or completeness
- Understand what makes a well-structured SKILL.md

## Available Commands

| Command | Description |
|---------|-------------|
| `build <name>` | Guided creation of a new SKILL.md |
| `audit <name>` | Review an existing skill and suggest improvements |
| `list` | List all skills currently in `.crush/skills/` |

## Agent Skills Standard

Skills are folders containing a `SKILL.md` file:

```
.crush/skills/<skill-name>/
  SKILL.md
  references/           (optional -- load on demand, NOT at startup)
    <reference>.md
```

### SKILL.md Structure

```markdown
# <Skill Name>

<1-2 sentence description of what this skill does and when to use it.>

## Available Commands

| Command | Description |
|---------|-------------|
| `<command>` | <description> |

If no command is specified, infer the best action from context.

## How to Execute

<Describe the tools and services used. Be specific about file paths, CLI commands, and data sources.>

## Workflow Execution Pattern

Every workflow follows:
1. **Gather** -- parallel reads/searches to build context
2. **Analyze** -- classify, score, or evaluate
3. **Report** -- structured summary of findings
4. **Execute** -- only after user confirms

Never skip step 4 for destructive operations.

## Reference Files

Load on demand -- do NOT load all at startup:
- `references/<file>.md` -- <description>

## Notes

- <Important caveats or edge cases>
```

### Key Rules

- No frontmatter needed (Crush does not require it, unlike Claude Code's SKILL.md)
- No `model:` field -- Crush's `coder` model handles skills; `task` model handles sub-agents
- Reference files live in `references/` subdirectory and are loaded on demand, never at startup
- Keep the main SKILL.md under 200 lines; offload detail to references
- Every workflow should follow the Gather -> Analyze -> Report -> Execute pattern
- Never confirm before reading; always confirm before writing

---

## Workflow: `build <name>`

### Phase 1 -- Requirements Gathering

Ask Connor:
1. What does this skill do in one sentence?
2. What triggers should activate it? (describe natural language patterns)
3. What commands or subcommands should it support?
4. What data sources does it read? (vault, context files, git, external APIs)
5. What does it write or create?
6. Are there any destructive operations that need confirmation?
7. Will it need reference files (rubrics, templates, conventions)?

### Phase 2 -- Present Draft

Generate a complete SKILL.md draft. Present for review.

Key things to get right:
- Trigger description is specific enough to avoid false positives
- Every command has a clear, distinct purpose
- Workflow steps are concrete (what tool? what path? what format?)
- Reference files are called out but not inlined

### Phase 3 -- Confirm and Create

After Connor approves:
1. Create `.crush/skills/<name>/SKILL.md`
2. Create `.crush/skills/<name>/references/` if references are needed (empty with .gitkeep)
3. Update `AGENTS.md` -- add the skill to the Available Skills table

---

## Workflow: `audit <name>`

### Phase 1 -- Read
Read `.crush/skills/<name>/SKILL.md` and all files in `references/` if they exist.

### Phase 2 -- Score
Evaluate against these quality gates:

| Gate | Pass Criteria |
|------|--------------|
| Trigger clarity | Natural language patterns are specific and unambiguous |
| Command structure | Each command has a distinct, non-overlapping purpose |
| Workflow concreteness | Steps name specific tools, paths, and formats |
| Confirmation gates | Destructive operations require explicit user confirmation |
| Reference discipline | References are loaded on demand, not at startup |
| Length | Main SKILL.md is under 200 lines |
| Data sources | All reads are explicit -- no assumptions about what's available |

### Phase 3 -- Report

```
## Skill Audit: <name>

| Gate | Status | Notes |
|------|--------|-------|
| Trigger clarity | Pass / Fail | <detail> |
| Command structure | Pass / Fail | <detail> |
| Workflow concreteness | Pass / Fail | <detail> |
| Confirmation gates | Pass / Fail | <detail> |
| Reference discipline | Pass / Fail | <detail> |
| Length | Pass / Fail | N lines |
| Data sources | Pass / Fail | <detail> |

Overall: Pass / Needs Work

Recommended changes:
- <change 1>
- <change 2>
```

### Phase 4 -- Fix (on confirmation)
Apply recommended changes to the SKILL.md.

---

## Workflow: `list`

```
glob .crush/skills/**/*.md
```

Report as a table:
```
| Skill | Commands | Reference Files | Lines |
|-------|----------|-----------------|-------|
| <name> | cmd1, cmd2 | N | N |
```

## Notes

- Always update AGENTS.md after creating a new skill
- Cross-compatibility: skills in `.crush/skills/` are also readable by Claude Code and Cursor that support the Agent Skills standard
- Don't create skills for one-off tasks -- build a skill when you've seen the same request 3+ times

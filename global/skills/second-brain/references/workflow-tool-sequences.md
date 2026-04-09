# Workflow Tool Sequences

Exact tool sequences for each `/second-brain` workflow. Vault: "The Forge".

**File access strategy:**
- Obsidian CLI (works from any directory): `obsidian "The Forge" <command>`
- Crush native tools (only when vault is at `vault/` in current repo): `view vault/<path>`, `glob vault/**/*.md`, etc.
- Wikilink-safe moves always use CLI: `obsidian "The Forge" move`

All commands below show the CLI form. When in the W2 repo, substitute `obsidian "The Forge" read path="<p>"` with `view vault/<p>` for speed.

---

## `capture <title>`

```
# Phase 1 -- Dedup check (PARALLEL)
obsidian "The Forge" search query="<title keywords>"
obsidian "The Forge" search:context query="<title keywords>"

# Phase 2 -- If no duplicate: create note
obsidian "The Forge" create path="00-Inbox/<Descriptive Title>.md" content="
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - fleeting
---

## Summary
<summary>

## Context
<context>

## Related
<wikilink if applicable>
"

# Phase 3 -- Confirm
obsidian "The Forge" read path="00-Inbox/<Title>.md"
```

---

## `find <query>`

```
# PARALLEL:
obsidian "The Forge" search query="<query>"
obsidian "The Forge" search:context query="<query>"
obsidian "The Forge" tags counts sort=count

# Read top 5 matching notes:
obsidian "The Forge" read path="<path-to-match>"   (for each)
```

Report: table of matches with title, folder, tags, relevance summary.

---

## `organize` (inbox processing)

```
# Phase 1 -- Read inbox
obsidian "The Forge" files folder="00-Inbox"
obsidian "The Forge" read path="00-Inbox/<note>.md"   (for each)

# Phase 2 -- Classify each note:
# Type: permanent | literature | project | area-update | trash
# Target: 20-Areas | 30-Projects | 40-Resources | 80-Lab | delete

# Phase 3 -- Report classification plan, ask for confirmation

# Phase 4 -- Execute moves (on confirmation)
obsidian "The Forge" move path="00-Inbox/<note>.md" to="<target>/<note>.md"
```

---

## `project status [name]`

```
# If name provided:
obsidian "The Forge" search query="<name>"
obsidian "The Forge" read path="30-Projects/<Project>.md"

# If no name: list all
obsidian "The Forge" files folder="30-Projects"
obsidian "The Forge" read path="30-Projects/<Project>.md"   (for each)
```

Report per project: status, current phase, last updated, stale flag (> 14 days), open task count, days to target.

---

## `project map`

```
obsidian "The Forge" files folder="30-Projects"
obsidian "The Forge" read path="30-Projects/<Project>.md"   (for each, extract relationship metadata)
```

Build ASCII dependency graph from `depends-on`, `feeds-into`, `supports` fields.

---

## `review` (vault health score)

```
# PARALLEL:
obsidian "The Forge" files folder="00-Inbox"     (inbox count)
obsidian "The Forge" files folder="30-Projects"  (project count + status distribution)
obsidian "The Forge" files folder="20-Areas"     (area note count)
obsidian "The Forge" tags counts sort=count      (tag health)
```

Health score (0-100): link density (25%) + tag coverage (20%) + freshness (20%) + organization (20%) + frontmatter completeness (15%).

---

## `daily`

```
# Check if today's note exists
obsidian "The Forge" read path="50-Daily/YYYY-MM-DD.md"

# If not: create from template
obsidian "The Forge" read path="60-Templates/Daily Note.md"
obsidian "The Forge" create path="50-Daily/YYYY-MM-DD.md" content="<template content>"
```

---

## `weekly`

```
# PARALLEL:
obsidian "The Forge" files folder="50-Daily"    (last 7 daily notes)
obsidian "The Forge" files folder="30-Projects" (active projects)

# Read each daily note from the past 7 days
obsidian "The Forge" read path="50-Daily/<date>.md"   (for each)

# Read each active project note
obsidian "The Forge" read path="30-Projects/<Project>.md"   (for each with status: active)
```

Generate weekly synthesis. Write to `50-Daily/YYYY-W##.md`.

---

## `link <note>`

```
# PARALLEL:
obsidian "The Forge" search:context query="<note title and keywords>"
obsidian "The Forge" search query="<key terms>"

# Read target note
obsidian "The Forge" read path="<path>/<note>.md"

# Read top 5 candidates
obsidian "The Forge" read path="<candidate-path>"   (for each)
```

Suggest bidirectional links. On confirmation, edit both target and candidate notes.

For automation, use the vault-linker agent template from `~/.config/crush/agents/vault-linker.md`.

---

## `moc [topic]`

```
# PARALLEL:
obsidian "The Forge" search query="MOC - <topic>"
obsidian "The Forge" search:context query="<topic>"
obsidian "The Forge" files folder="70-Atlas"

# If MOC exists: read-modify-write
obsidian "The Forge" read path="70-Atlas/MOC - <Topic>.md"
# Edit to add new links, then:
obsidian "The Forge" create path="70-Atlas/MOC - <Topic>.md" content="<updated>" --overwrite
```

---

## `inbox` (batch processing)

Same as `organize` but processes all inbox items in a single batch with one confirmation.

---

## `tag [query]`

```
# PARALLEL:
obsidian "The Forge" tags counts sort=count
obsidian "The Forge" search query="tags:"
```

Identify orphan tags, missing tags, naming inconsistencies. Present fix plan. Edit frontmatter on confirmation.

# Workflow Tool Sequences

Exact CLI command sequences for each second-brain workflow. All commands use the `obsidian` CLI (v1.12+) via Bash.

---

## Workflow 1: Capture (`capture <title>`)

### Phase 1 — Gather Context
```
PARALLEL:
  obsidian search query="<title keywords>"
  obsidian files folder="00-Inbox"
```

### Phase 2 — Check for Duplicates
Review search results. If a similar note exists, present it to the user with options:
- Update existing note
- Create new note anyway
- Cancel

### Phase 3 — Create (on confirmation)
```
obsidian create path="00-Inbox/<title>.md" content="<frontmatter + body>"
```

Frontmatter for captures:
```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - fleeting
---
```

### Phase 4 — Report
Confirm creation with link: `[[<title>]]`. Suggest related notes to link to.

---

## Workflow 2: Find (`find <query>`)

### Phase 1 — Parallel Search
```
PARALLEL:
  obsidian search query="<query>"
  obsidian search:context query="<query>"
  obsidian tags counts sort=count
```

### Phase 2 — Enrich Results
For top 5 results:
```
FOR EACH result:
  obsidian read path="<note-path>"
```

### Phase 3 — Report
Present results grouped by:
1. Best matches (from search)
2. Contextual matches (from search:context)
3. Related tags
4. Suggested follow-up searches

---

## Workflow 3: Organize (`organize`)

### Phase 1 — Audit
```
PARALLEL:
  obsidian files folder="00-Inbox"
  obsidian tags counts sort=count
  obsidian search query="tags: []"
```

### Phase 2 — Analyze
For each inbox item:
```
obsidian read path="<inbox-note-path>"
```

Classify each note:
- Determine note type (fleeting, literature, permanent, project)
- Determine target folder
- Identify missing frontmatter fields
- Suggest tags

### Phase 3 — Report
Present reorganization plan as a table:
| Note | Current Location | Proposed Location | Actions Needed |
|------|-----------------|-------------------|----------------|

### Phase 4 — Execute (on confirmation, one at a time)
```
FOR EACH approved move:
  obsidian read path="<path>"
  obsidian create path="<path>" content="<updated frontmatter + content>"
  obsidian move path="<old-path>" to="<new-path>"
```

---

## Workflow 4: Project Status (`project status [name]`)

### Phase 1 — Gather
```
IF name provided:
  PARALLEL:
    obsidian search query="<name>"
    obsidian search:context query="project <name>"
ELSE:
  obsidian files folder="30-Projects"
```

### Phase 2 — Load Project Data
```
FOR EACH project note:
  obsidian read path="<project-path>"
```

Extract from each: status, area, phases, target-date, updated date, tasks, relationships.

### Phase 3 — Health Assessment
For each project, evaluate:
- Last updated (fresh < 7 days, stale > 30 days)
- Phase progress vs target date
- Blocker status
- Link count

### Phase 4 — Report
Present project status table:
| Project | Status | Phase | Health | Target Date | Notes |
|---------|--------|-------|--------|-------------|-------|

If single project: show full detail with phases, tasks, decisions log, connected notes.

---

## Workflow 5: Project Map (`project map`)

### Phase 1 — Gather All Projects
```
obsidian files folder="30-Projects"
```

### Phase 2 — Load Relationships
```
FOR EACH project:
  obsidian read path="<project-path>"
```

Extract: depends-on, feeds-into, shares-resource, supports, area.

### Phase 3 — Build Map
Construct relationship graph:
```
Project A --depends-on--> Project B
Project A --feeds-into--> Project C
Project D --supports--> Area: Career
Project A --shares-resource--> Project D (shared: budget)
```

### Phase 4 — Report
Present:
1. ASCII relationship diagram
2. Dependency chain (critical path)
3. Cluster analysis (which projects are tightly coupled)
4. Orphaned projects (no relationships)
5. Bottleneck projects (many dependents)

---

## Workflow 6: Review (`review`)

### Phase 1 — Vault Health Scan
```
PARALLEL:
  obsidian files folder="00-Inbox"
  obsidian files folder="30-Projects"
  obsidian files folder="70-Atlas"
  obsidian tags counts sort=count
  obsidian search query="status: active"
```

### Phase 2 — Deep Audit
```
FOR EACH active project:
  obsidian read path="<project-path>"

FOR EACH MOC:
  obsidian read path="<moc-path>"
```

### Phase 3 — Calculate Health Score
Score each metric (see review-checklists.md):
- Link Density (25%)
- Tag Coverage (20%)
- Freshness (20%)
- Organization (20%)
- Frontmatter Completeness (15%)

### Phase 4 — Report
```
Vault Health Score: XX/100

| Metric | Score | Details |
|--------|-------|---------|
| Link Density | XX/25 | Avg X.X links/note |
| Tag Coverage | XX/20 | XX% notes tagged |
| Freshness | XX/20 | XX% updated in 30 days |
| Organization | XX/20 | XX notes in inbox |
| Frontmatter | XX/15 | XX% complete |

Issues Found:
- X orphaned notes
- X stale active projects
- X inbox items older than 7 days
- X notes missing frontmatter

Recommendations:
1. ...
2. ...
```

---

## Workflow 7: Daily (`daily`)

### Phase 1 — Check Existing
```
PARALLEL:
  obsidian search query="YYYY-MM-DD"
  obsidian files folder="50-Daily"
```

### Phase 2 — Create or Load
```
IF daily note exists:
  obsidian read path="50-Daily/YYYY-MM-DD.md"
ELSE:
  obsidian create path="50-Daily/YYYY-MM-DD.md" template="Daily Note"
```

Note: If template application fails, create manually:
```
obsidian create path="50-Daily/YYYY-MM-DD.md" content="<daily note frontmatter + sections>"
```

### Phase 3 — Context Gathering
```
PARALLEL:
  obsidian search query="status: active"
  obsidian files folder="00-Inbox"
```

### Phase 4 — Report
Present:
- Today's daily note (existing content or new template)
- Active project summaries
- Inbox items to process
- Suggested priorities

---

## Workflow 8: Weekly (`weekly`)

### Phase 1 — Gather Week's Data
```
PARALLEL:
  obsidian search query="YYYY-W##"
  obsidian files folder="50-Daily"
  obsidian files folder="00-Inbox"
  obsidian search query="status: active"
```

### Phase 2 — Load Daily Notes
```
FOR EACH daily note from this week:
  obsidian read path="50-Daily/YYYY-MM-DD.md"
```

### Phase 3 — Create or Update Weekly Note
```
IF weekly note exists:
  obsidian read path="50-Daily/YYYY-W##.md"
ELSE:
  obsidian create path="50-Daily/YYYY-W##.md" template="Weekly Note"
```

### Phase 4 — Compile and Report
Synthesize the week:
- Accomplishments across daily notes
- Project progress summary
- Inbox processing status
- Vault health snapshot
- Next week priorities

---

## Workflow 9: Link (`link <note>`)

### Phase 1 — Load Target Note
```
obsidian search query="<note>"
obsidian read path="<found-path>"
```

### Phase 2 — Discover Connections
```
PARALLEL:
  obsidian search:context query="<note content keywords>"
  obsidian search query="<key terms from note>"
  obsidian tags counts sort=count
```

### Phase 3 — Analyze and Suggest
For top 10 candidates:
```
FOR EACH candidate:
  obsidian read path="<candidate-path>"
```

Evaluate connection strength:
- Shared concepts
- Shared tags
- Same area or project
- Complementary ideas

### Phase 4 — Report
Present link suggestions:
| Candidate Note | Connection Type | Strength | Rationale |
|---------------|----------------|----------|-----------|

### Phase 5 — Execute (on confirmation)
```
FOR EACH approved link:
  obsidian read path="<note-path>"
  obsidian create path="<note-path>" content="<updated content with link in Related section>"
```

---

## Workflow 10: MOC (`moc [topic]`)

### Phase 1 — Discover or Load
```
IF topic provided:
  PARALLEL:
    obsidian search query="MOC - <topic>"
    obsidian search:context query="<topic>"
    obsidian tags counts sort=count
ELSE:
  obsidian files folder="70-Atlas"
```

### Phase 2 — Gather Related Notes
```
FOR EACH relevant note:
  obsidian read path="<note-path>"
```

### Phase 3 — Build or Update MOC
Organize notes into sections:
- Key Concepts
- Deep Dives
- Projects
- Resources
- Related MOCs

### Phase 4 — Report
Present proposed MOC structure.

### Phase 5 — Execute (on confirmation)
```
IF new MOC:
  obsidian create path="70-Atlas/MOC - <Topic>.md" content="<MOC frontmatter + structured content>"
ELSE:
  obsidian read path="<moc-path>"
  obsidian create path="<moc-path>" content="<updated content>"
```

---

## Workflow 11: Inbox (`inbox`)

### Phase 1 — Load Inbox
```
obsidian files folder="00-Inbox"
```

### Phase 2 — Classify Each Item
```
FOR EACH inbox note:
  obsidian read path="00-Inbox/<note>.md"
```

For each note, determine:
- Note type (fleeting → permanent, literature, project, or discard)
- Target folder
- Required frontmatter updates
- Tags to add
- Notes to link to

### Phase 3 — Report
Present processing plan:
| Note | Type | Target | Tags | Links | Action |
|------|------|--------|------|-------|--------|

### Phase 4 — Execute (on confirmation)
```
FOR EACH approved action:
  obsidian read path="<path>"
  obsidian create path="<path>" content="<updated content>"
  obsidian move path="00-Inbox/<note>.md" to="<target-folder>/<note>.md"
```

---

## Workflow 12: Tag (`tag [query]`)

### Phase 1 — Gather Tag Data
```
PARALLEL:
  obsidian tags counts sort=count
  IF query:
    obsidian search query="#<query>"
```

### Phase 2 — Analyze
- List all tags with counts
- Identify inconsistencies (e.g., `#project-active` vs `#project/active`)
- Find notes with no tags
- Find tags with only 1 use (candidates for removal)
- Check tag taxonomy compliance (see vault-conventions.md)

### Phase 3 — Report
```
Tag Summary:
- Total unique tags: XX
- Notes without tags: XX
- Orphan tags (1 use): XX

Tag Taxonomy:
| Category | Tags | Count |
|----------|------|-------|

Issues:
- Non-standard tags: [list]
- Suggested merges: [list]
- Untagged notes: [list]
```

### Phase 4 — Execute (on confirmation)
```
FOR EACH approved fix:
  obsidian read path="<note-path>"
  obsidian create path="<note-path>" content="<fix tag in frontmatter>"
```

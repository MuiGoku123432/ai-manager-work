# Project Tracking Framework

Standards for tracking projects, their lifecycle, relationships, and health within "The Mind" vault.

---

## Project Lifecycle

```
active → paused → active → done → archived
```

| Status | Tag | Folder | Meaning |
|--------|-----|--------|---------|
| Active | `#project/active` | `30-Projects/` | Currently being worked on |
| Paused | `#project/paused` | `30-Projects/` | On hold, will resume later |
| Done | `#project/done` | `30-Projects/` | Completed, available for reference |
| Archived | `#project/archived` | `30-Projects/Archive/` | No longer relevant, cold storage |

### Status Transition Rules
- **active → paused**: Set `status: paused` in frontmatter, add pause reason to decisions log
- **paused → active**: Set `status: active`, update target date if shifted
- **active → done**: Set `status: done`, add completion date, write final summary
- **done → archived**: Move to `30-Projects/Archive/`, set `status: archived`
- Projects should not skip states (e.g., active → archived). Complete or pause first.

## Standard Project Note Structure

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - project/active
status: active
area: <parent-area>
start-date: YYYY-MM-DD
target-date: YYYY-MM-DD
---

# Project Title

## Goal
One clear sentence: what does "done" look like?

## Phases
- [ ] Phase 1: <description>
- [ ] Phase 2: <description>
- [ ] Phase 3: <description>

## Current Phase
What is actively being worked on right now.

## Decisions Log
| Date | Decision | Rationale |
|------|----------|-----------|
| YYYY-MM-DD | <what was decided> | <why> |

## Tasks
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

## Connected Notes
- [[Related Project]]
- [[Relevant Area Note]]
- [[Resource or Reference]]

## Notes
Running notes, observations, and context.
```

## Relationship Types

Projects can relate to each other and to areas. Track these relationships with links and optional metadata.

| Relationship | Notation | Example |
|-------------|----------|---------|
| **depends-on** | `depends-on:: [[Other Project]]` | Can't start Phase 2 until Other Project completes |
| **feeds-into** | `feeds-into:: [[Other Project]]` | Output of this project is input to another |
| **shares-resource** | `shares-resource:: [[Other Project]]` | Both projects use the same budget, tool, or person |
| **same-area** | Implicit via `area:` field | Both under `area: home` |
| **supports** | `supports:: [[Area Note]]` | Project exists to improve an ongoing area |

### Relationship Display
When mapping relationships, use this notation in project maps:

```
Project A --depends-on--> Project B
Project A --feeds-into--> Project C
Project A --shares-resource--> Project D (shared: budget)
Project A --supports--> Area: Home
```

## Phase Tracking

Phases represent major milestones within a project. Track them with checkboxes in the Phases section.

### Phase Status Convention
- `- [ ] Phase`: Not started
- `- [/] Phase`: In progress (if supported by vault theme)
- `- [x] Phase`: Complete

### Phase Progress Calculation
```
Phase Progress = completed phases / total phases × 100%
```

Report as: "Phase 2 of 4 (50%)"

## Project Health Indicators

| Indicator | Healthy | Warning | Critical |
|-----------|---------|---------|----------|
| **Last Updated** | Within 7 days | 8-30 days stale | 30+ days stale |
| **Target Date** | On track or ahead | Within 2 weeks of target | Past target date |
| **Phase Progress** | On expected pace | 1 phase behind | 2+ phases behind |
| **Blockers** | None | Has blockers, workaround exists | Blocked, no path forward |
| **Connected Notes** | 3+ links | 1-2 links | 0 links (orphaned project) |

### Health Score
- **Healthy**: All indicators green — project is on track
- **Needs Attention**: 1-2 warnings — check in during next review
- **At Risk**: Any critical indicator — address immediately

## Querying Projects

### Dataview Queries for Project Tracking

**All active projects:**
```dataview
TABLE status, area, target-date
FROM "30-Projects"
WHERE status = "active"
SORT target-date ASC
```

**Stale projects (not updated in 30+ days):**
```dataview
TABLE status, updated, target-date
FROM "30-Projects"
WHERE status = "active" AND updated < date(today) - dur(30 days)
SORT updated ASC
```

**Projects by area:**
```dataview
TABLE status, start-date, target-date
FROM "30-Projects"
WHERE area = "<area-name>"
SORT status ASC
```

**Project relationships:**
```dataview
TABLE depends-on, feeds-into, shares-resource, supports
FROM "30-Projects"
WHERE status = "active"
```

# Project Tracking Framework

How W2 engineering projects are tracked in "The Forge" vault.

---

## Project Lifecycle

```
active -> paused -> done -> archived
```

| Status | Tag | Description |
|--------|-----|-------------|
| `active` | `#project/active` | Currently being worked |
| `paused` | `#project/paused` | On hold (external dependency, deprioritized) |
| `done` | `#project/done` | Delivered, no further work expected |
| `archived` | `#project/archived` | Historical, moved to `archives/` in repo |

**Status transitions:** Always update both the `status` frontmatter field and the tag. Update `updated` date on every change.

---

## Standard Project Note Structure

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - project/active
status: active
area: <career | learning | engineering>
start-date: YYYY-MM-DD
target-date: YYYY-MM-DD
---

depends-on:: [[Other Project]]
feeds-into:: [[Other Project]]
supports:: [[Area Note]]

# <Project Title>

## Goal
One clear sentence: what does "done" look like?

## Scope
**In scope:** ...
**Out of scope:** ...

## Phases
- [ ] Phase 1: <description>
- [ ] Phase 2: <description>
- [ ] Phase 3: <description>

## Current Phase
What is actively being worked on right now.

## Tech Stack
Languages, frameworks, tools.

## Decisions Log
| Date | Decision | Rationale |
|------|----------|-----------|

## Tasks
- [ ] Task 1 (due: YYYY-MM-DD)
- [ ] Task 2

## Connected Notes
- [[Related Project]]
- [[Career]]
- [[Engineering]]

## Notes
Running observations and context.
```

---

## Relationship Types

| Type | Use When |
|------|----------|
| `depends-on` | This project cannot progress until another completes |
| `feeds-into` | Output of this project is direct input to another |
| `supports` | This project improves an ongoing area (not a dependency) |

---

## Health Indicators

A project note is **healthy** when:
- Updated within the last 7 days
- Has at least one task in the `## Tasks` section
- Status tag matches the frontmatter `status` field
- At least one `## Connected Notes` link exists
- Phase checkboxes reflect actual progress

A project note is **stale** when:
- Not updated in > 14 days
- All phases checked but status is still `active`
- No tasks in the task section

---

## Project Map (Dependency Graph)

The `/second-brain project map` command reads all `vault/30-Projects/*.md` files, extracts relationship metadata, and builds an ASCII dependency graph:

```
[Project A] --feeds-into--> [Project B]
[Project C] --depends-on--> [Project A]
[Project D] --supports--> [Career]
```

Projects with no relationships are listed separately as "standalone."

---

## Dataview Queries (for Obsidian Dataview plugin)

List all active projects:
```dataview
TABLE status, area, target-date FROM "30-Projects"
WHERE status = "active"
SORT target-date ASC
```

Projects with approaching deadlines:
```dataview
TABLE target-date, area FROM "30-Projects"
WHERE status = "active" AND target-date <= date(today) + dur(14 days)
SORT target-date ASC
```

# Project Note Template

Canonical Obsidian note templates for `30-Projects/`. Used by `scaffold-agent` when creating new project notes. Select the variant that matches the project type.

---

## Variant 1: Standard Project

Use for any project that is not primarily a Claude Code domain build or a content/trip project.

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

# <Project Title>

## Goal
One clear sentence: what does "done" look like?

## Scope

**In scope:**
- Item 1
- Item 2

**Out of scope:**
- Item 1
- Item 2

## Phases
- [ ] Phase 1: <description>
- [ ] Phase 2: <description>
- [ ] Phase 3: <description>

## Current Phase
What is actively being worked on right now.

## Tech Stack
- Language/Framework: ...
- Tools: ...
- Dependencies: ...

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

---

## Variant 2: Claude Code Domain Project

Use when the project is building a new Claude Code domain, agent team, skill, or AI tool. Adds a WAT Mapping section.

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - project/active
  - ai-tooling
status: active
area: <parent-area>
start-date: YYYY-MM-DD
target-date: YYYY-MM-DD
---

# <Project Title>

## Goal
One clear sentence: what does "done" look like?

## Scope

**In scope:**
- Item 1
- Item 2

**Out of scope:**
- Item 1
- Item 2

## Phases
- [ ] Phase 1: <description>
- [ ] Phase 2: <description>
- [ ] Phase 3: <description>

## Current Phase
What is actively being worked on right now.

## WAT Mapping

**Workflows:**
- Workflow 1: <name and purpose>
- Workflow 2: <name and purpose>

**Agents:**
| Agent | Role | Model |
|-------|------|-------|
| <name> | Lead -- <description> | sonnet |
| <name> | Specialist -- <description> | haiku |

**Tools (scripts):**
- `tools/<script>.py` -- <description>

**Skills:**
- `/<skill-name>` -- <description>

## Tech Stack
- Language/Framework: ...
- MCP Servers: ...
- Claude Code version: ...

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

---

## Variant 3: Content / Trip Project

Use for The Narrow Road episodes, overlanding trips, or any content production project. Adds content planning sections.

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - project/active
  - content
  - trip
status: active
area: the-narrow-road
start-date: YYYY-MM-DD
target-date: YYYY-MM-DD
---

# <Project Title>

## Goal
One clear sentence: what does "done" look like?

## Concept
2-3 sentences on the episode theme, gospel angle, and intended audience takeaway.

## Phases
- [ ] Phase 1: Planning and logistics
- [ ] Phase 2: Production (filming)
- [ ] Phase 3: Post-production and publish

## Current Phase
What is actively being worked on right now.

## Logistics
- Location: ...
- Dates: ...
- Vehicle: ...
- Travel party: ...

## Content Plan
- Episode theme: ...
- Gospel angle: ...
- Key shots: ...
- Interview/conversation targets: ...

## Gear
- [ ] Camera gear: DJI Air 3S, ...
- [ ] Vehicle prep: ...
- [ ] Camp gear: ...

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

---

## Frontmatter Field Reference

| Field | Required | Values | Notes |
|-------|----------|--------|-------|
| `created` | Yes | YYYY-MM-DD | Date note was created |
| `updated` | Yes | YYYY-MM-DD | Updated every time the note is modified |
| `tags` | Yes | project/active, project/paused, project/done, project/archived | Start with project/active |
| `status` | Yes | active, paused, done, archived | Must match tag |
| `area` | Yes | career, finances, overlanding, the-narrow-road, home, health, faith, sentinovo | Parent life area |
| `start-date` | Yes | YYYY-MM-DD | When work began or is planned to begin |
| `target-date` | Yes | YYYY-MM-DD | Target completion date |

## Relationship Metadata (optional, add below frontmatter)

```
depends-on:: [[Other Project]]
feeds-into:: [[Other Project]]
shares-resource:: [[Other Project]]
supports:: [[Area Note]]
```

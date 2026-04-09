# Project Note Template

Obsidian note templates for `vault/30-Projects/`. Two variants -- select based on project type.

---

## Variant 1: Standard W2 Project

Use for any W2 engineering project.

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
- Infrastructure: ...

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
- [[Career]]
- [[Engineering]]

## Notes
Running notes, observations, and context.
```

---

## Variant 2: Crush Skill / AI Tooling Project

Use when building a new Crush skill, MCP server, or AI tool. Adds a WAT Mapping section.

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - project/active
  - ai-tooling
status: active
area: engineering
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

**Skills (Crush):**
| Skill | Purpose |
|-------|---------|
| `/<skill-name>` | <description> |

**Tools (scripts):**
- `tools/<script>.sh` -- <description>

## Tech Stack
- Language/Framework: ...
- Crush CLI version: ...
- MCP Servers: ...

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
- [[Engineering]]

## Notes
Running notes, observations, and context.
```

---

## Frontmatter Field Reference

| Field | Required | Values |
|-------|----------|--------|
| `created` | Yes | YYYY-MM-DD |
| `updated` | Yes | YYYY-MM-DD -- update every time the note is modified |
| `tags` | Yes | project/active, project/paused, project/done, project/archived |
| `status` | Yes | active, paused, done, archived -- must match tag |
| `area` | Yes | career, learning, engineering |
| `start-date` | Yes | YYYY-MM-DD |
| `target-date` | Yes | YYYY-MM-DD |

## Relationship Metadata (optional, add below frontmatter)

```
depends-on:: [[Other Project]]
feeds-into:: [[Other Project]]
supports:: [[Area Note]]
```

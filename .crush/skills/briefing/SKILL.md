# Briefing

Daily morning briefing. Fast, compact, action-oriented. Pulls current priorities, active project status, and approaching deadlines, then creates today's daily note in the embedded vault.

## When to Use

Trigger this when Connor says "good morning", "what's on the agenda", "daily briefing", or "what should I focus on today".

## How to Execute

Runs fast -- keep the whole briefing to under 2 minutes of reading. No fluff.

**Sources:**
- `context/current-priorities.md` -- top priorities
- `context/goals.md` -- Q2 milestones with deadlines
- `vault/30-Projects/*.md` -- active project notes (read for blockers and current phase)
- `vault/50-Daily/YYYY-MM-DD.md` -- yesterday's daily note (if exists, pull open tasks)

## Workflow

### Phase 1 -- Gather (PARALLEL)
```
Read: context/current-priorities.md
glob vault/30-Projects/**/*.md -> read each active project note
Read yesterday's daily note if it exists: vault/50-Daily/<yesterday>.md
Check for time-sensitive items in context/current-priorities.md
```

### Phase 2 -- Report

```
## Briefing -- YYYY-MM-DD (Day of Week)

### Focus
<#1 priority and what specifically needs to happen today>

### Projects
| Project | Current Phase | Blocker | Next Action |
|---------|---------------|---------|-------------|
| <name> | <phase> | None / <blocker> | <next action> |

### Time-Sensitive
| Item | Target | Days Out |
|------|--------|----------|
| <item> | YYYY-MM-DD | N days |

### Carried Over (from yesterday)
- [ ] <open task from yesterday's daily note, if any>
```

### Phase 3 -- Create Daily Note

After the briefing, create today's daily note in the vault:

```
vault/50-Daily/YYYY-MM-DD.md
```

Content:
```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - daily
---

# YYYY-MM-DD

## Focus
<top priority from briefing>

## Tasks
- [ ] <carried-over task>

## Notes

## End of Day
```

If today's daily note already exists, append the focus and any carried-over tasks instead of overwriting.

## Notes

- Keep the briefing tight -- lead with the single most important focus
- If nothing is time-sensitive, say so explicitly
- Don't pull in personal items -- W2 scope only

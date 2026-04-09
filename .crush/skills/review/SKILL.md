# Review

W2 work status review. Pulls active project status from the embedded vault, checks priorities alignment, and produces a structured digest. Run weekly for a full review or use quick-status for a fast snapshot.

## Available Commands

| Command | Description |
|---------|-------------|
| `weekly` | Full weekly review: project status, priorities check, goal pulse, vault health |
| `monthly` | Deeper monthly review: goal progress, project lifecycle review, planning ahead |
| `quick` | Fast snapshot: active projects, blockers, next actions |

If no command specified, default to `weekly`.

## How to Execute

All data comes from the embedded vault and context files. No MCP calls needed.

**Sources:**
- `context/current-priorities.md` -- ranked priorities
- `context/goals.md` -- Q2 milestones
- `context/work.md` -- active work areas
- `vault/30-Projects/*.md` -- project status and health
- `vault/20-Areas/*.md` -- area-level notes
- `vault/50-Daily/` -- recent daily notes for week context
- `decisions/log.md` -- recent decisions

## Workflow Execution Pattern

1. **Gather** -- parallel reads of context files and vault projects
2. **Analyze** -- assess status, flag blockers, calculate completion
3. **Report** -- structured digest with clear action items
4. **Next actions** -- end with a prioritized list of what to do next

---

## Workflow: `weekly`

### Phase 1 -- Gather (PARALLEL)
```
Read: context/current-priorities.md
Read: context/goals.md
glob vault/30-Projects/**/*.md  -> read each project note
glob vault/50-Daily/*.md        -> read last 7 daily notes
Read: decisions/log.md          -> last 5 entries
```

### Phase 2 -- Analyze
For each active project:
- Current phase and what's in progress
- Blockers or risks
- Whether it's on track for target date
- Last updated date (stale if > 7 days)

For priorities:
- Is active work aligned with ranked priorities?
- Are any time-sensitive items approaching?

For goals:
- Which Q2 milestones are on track / at risk / complete?

### Phase 3 -- Report

```
## Weekly Review -- YYYY-MM-DD

### Projects
| Project | Status | Current Phase | Blockers | Target | On Track? |
|---------|--------|---------------|----------|--------|-----------|
| <name> | active | Phase N: ... | None / <blocker> | YYYY-MM-DD | Yes / At Risk |

### Priority Alignment
Top priorities vs active work -- aligned? Any drift?

### Goal Pulse
| Goal | Milestone | Status |
|------|-----------|--------|
| ... | ... | On Track / At Risk / Done |

### Decisions This Week
- [YYYY-MM-DD] <decision summary>

### Next Actions
1. <highest priority action>
2. <second action>
3. <third action>
```

---

## Workflow: `monthly`

All of weekly, plus:
- Which projects changed status (started, completed, paused) this month?
- Which goals have milestones due next month?
- Vault health check (run `/second-brain review`)
- Recommendation: any projects to archive, restart, or re-scope?

---

## Workflow: `quick`

30-second snapshot:
```
## Quick Status -- YYYY-MM-DD

Active projects: N
Blockers: <list or "none">
Highest priority right now: <from priorities file>
Next action: <one clear thing>
```

## Notes

- This review is work-scoped only -- no personal finance or personal projects
- Always read context files fresh, not from memory
- If a project note hasn't been updated in > 14 days, flag it as "needs update"

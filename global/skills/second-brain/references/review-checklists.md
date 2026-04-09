# Review Checklists

Checklists for daily, weekly, and monthly vault reviews. Run via `/second-brain review` or manually.

---

## Daily Review (5 minutes)

Run at end of workday.

- [ ] Process anything captured to `vault/00-Inbox/` today
- [ ] Update today's daily note (`vault/50-Daily/YYYY-MM-DD.md`) with end-of-day summary
- [ ] Mark completed tasks in active project notes
- [ ] Check if any time-sensitive items in `context/current-priorities.md` need action tomorrow

---

## Weekly Review (20-30 minutes)

Run on Fridays or the last workday of the week.

### Inbox
- [ ] All inbox items older than 7 days are processed (promoted, discarded, or deferred)
- [ ] Inbox item count < 10

### Projects
- [ ] All active project notes updated (current phase, task status)
- [ ] Any project that should have moved status (done, paused) is updated
- [ ] `context/current-priorities.md` reflects actual focus this week
- [ ] `decisions/log.md` has any significant decisions from the week

### Knowledge
- [ ] Compile weekly note at `vault/50-Daily/YYYY-W##.md` (use `/second-brain weekly`)
- [ ] Any significant technical insights worth permanent capture?

### Planning
- [ ] Top priorities for next week are clear
- [ ] Any time-sensitive items approaching in next 7 days?

---

## Monthly Review (60 minutes)

Run on the last workday of the month.

### Projects
- [ ] Which projects completed this month? Update status to `done`, archive from `active`
- [ ] Which projects started? Add to vault if not already there
- [ ] Which projects are stale (no updates > 14 days) and why?
- [ ] Re-rank priorities in `context/current-priorities.md`

### Goals
- [ ] Check `context/goals.md` -- which Q2 milestones are on track vs at risk?
- [ ] Any goals to add or remove?

### Vault Health
- [ ] Run `/second-brain review` (health score check)
- [ ] Fix any critical health issues (orphan notes, missing frontmatter, broken links)
- [ ] Clean up any tag inconsistencies (run `/second-brain tag`)

### Knowledge
- [ ] Any research projects to start or wrap up (`/recursive-research status`)?
- [ ] Are MOCs in `vault/70-Atlas/` up to date?
- [ ] Any notes in `vault/80-Lab/` that graduated to permanent knowledge?

---

## Vault Health Score Formula

Score 0-100. Run via `/second-brain review`.

| Metric | Weight | Formula |
|--------|--------|---------|
| Link Density | 25% | avg wikilinks per non-inbox, non-template note (target: >= 3) |
| Tag Coverage | 20% | % of notes with a meaningful tag (not just `#fleeting`) |
| Freshness | 20% | % of project notes updated in last 14 days |
| Organization | 20% | 100 - (2 * inbox_count_over_10) -- max deduction at 50+ notes |
| Frontmatter | 15% | % of notes with all required frontmatter fields |

**Health labels:**
- 80-100: Healthy vault
- 60-79: Minor maintenance needed
- 40-59: Significant maintenance needed
- 0-39: Vault is neglected -- prioritize cleanup

---

## Quick Health Checks (use these before a review)

```bash
# Count inbox items
glob vault/00-Inbox/*.md | wc -l

# List stale project notes (last modified > 14 days)
# find vault/30-Projects/ -name "*.md" -mtime +14

# Check tag distribution
obsidian --vault ./vault tags counts sort=count

# List notes with no tags (missing frontmatter)
grep -rL "^tags:" vault/ --include="*.md"
```

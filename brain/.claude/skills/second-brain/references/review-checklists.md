# Review Checklists

Periodic review checklists and vault health metrics for "The Mind" vault.

---

## Daily Review Checklist

Run at end of day or start of next day. Uses the daily note template from `60-Templates/`.

- [ ] **Process Inbox**: Move or link all notes from `00-Inbox/` to proper locations
- [ ] **Review Today's Captures**: Ensure all fleeting notes have context
- [ ] **Update Active Projects**: Log progress on any project worked on today
- [ ] **Check Tomorrow's Tasks**: Identify top 3 priorities for tomorrow
- [ ] **Gratitude/Reflection**: Add reflection entry to daily note
- [ ] **Link New Notes**: Connect any new notes to existing notes or MOCs

### Daily Note Sections
```markdown
## Morning
- Top 3 priorities
- Schedule/appointments

## Captures
- Notes, ideas, observations from the day

## Progress
- What was accomplished
- Blockers encountered

## Reflection
- What went well
- What to improve
- Gratitude
```

## Weekly Review Checklist

Run once per week (suggested: Sunday evening or Monday morning). Creates/updates the weekly note.

### Phase 1: Collect
- [ ] **Process all inbox items**: `00-Inbox/` should be empty after this
- [ ] **Review all daily notes** from the past week
- [ ] **Collect loose tasks**: Any tasks scattered across notes → project notes
- [ ] **Check calendar**: Upcoming commitments that need preparation

### Phase 2: Review
- [ ] **Active projects review**: For each active project:
  - Is it still active? (pause or complete if not)
  - Update `updated:` date in frontmatter
  - Log any decisions made this week
  - Check phase progress
- [ ] **Stale note check**: Any notes updated 30+ days ago that are still `active`
- [ ] **Orphan check**: Notes with zero backlinks — link or archive
- [ ] **Tag audit**: Review recently created tags for consistency

### Phase 3: Plan
- [ ] **Set weekly goals**: 3-5 outcomes for the coming week
- [ ] **Identify project focus**: Which 1-2 projects get priority this week
- [ ] **Schedule deep work**: Block time for priority projects
- [ ] **Someday/maybe review**: Anything from parking lot ready to activate?

### Weekly Note Sections
```markdown
## Week in Review
- Key accomplishments
- Decisions made
- Lessons learned

## Project Status
| Project | Status | Progress | Notes |
|---------|--------|----------|-------|

## Next Week
- Goals
- Focus projects
- Key dates

## Vault Health
- Inbox items processed: X
- Orphans found: X
- Projects reviewed: X
```

## Monthly Review Checklist

Deeper review of areas, goals, and vault structure.

### Areas Review
- [ ] **Review each area** (`20-Areas/`): Is it getting appropriate attention?
- [ ] **Area balance check**: Any area neglected for 30+ days?
- [ ] **Update area MOCs**: Add new notes, remove stale links

### Projects Review
- [ ] **Full project audit**: Review all projects, not just active ones
- [ ] **Archive completed projects**: Move `done` projects older than 30 days to archive
- [ ] **Dependency check**: Any blocked projects that can be unblocked?
- [ ] **New project candidates**: Anything from areas that needs a dedicated project?

### Knowledge Review
- [ ] **MOC maintenance**: Update all active MOCs with new notes
- [ ] **Progressive summarization pass**: Layer 2-3 on recently captured resources
- [ ] **Link graph review**: Check for note clusters that need a new MOC

### Vault Health
- [ ] **Run full vault health audit** (see metrics below)
- [ ] **Template check**: Are templates still serving their purpose?
- [ ] **Tag taxonomy review**: Consolidate or rename inconsistent tags

## Quarterly Review Checklist

Strategic review of goals and direction.

- [ ] **Review quarterly goals**: What was accomplished? What wasn't?
- [ ] **Set next quarter goals**: 3-5 high-level outcomes
- [ ] **Area life audit**: Rate satisfaction in each area (1-10), identify focus areas
- [ ] **Project pipeline**: Plan which projects to start, pause, or retire
- [ ] **System review**: Is the vault structure still working? Any friction points?
- [ ] **Archive sweep**: Move stale resources and done projects to archive

---

## Vault Health Metrics

### Health Score (0-100)

| Metric | Weight | Scoring |
|--------|--------|---------|
| **Link Density** | 25% | Avg outgoing links per note. 0 links = 0pts, 1-2 = 25-50pts, 3-5 = 50-75pts, 6+ = 75-100pts |
| **Tag Coverage** | 20% | % of notes with at least 1 tag. <50% = 0-25pts, 50-70% = 25-50pts, 70-90% = 50-75pts, 90%+ = 75-100pts |
| **Freshness** | 20% | % of active notes updated in last 30 days. <30% = 0-25pts, 30-60% = 25-50pts, 60-80% = 50-75pts, 80%+ = 75-100pts |
| **Organization** | 20% | % of notes NOT in inbox. <70% = 0-25pts, 70-85% = 25-50pts, 85-95% = 50-75pts, 95%+ = 75-100pts |
| **Frontmatter Completeness** | 15% | % of notes with required frontmatter fields. <50% = 0-25pts, 50-70% = 25-50pts, 70-90% = 50-75pts, 90%+ = 75-100pts |

### Score Labels
- **80-100**: Excellent — vault is well-maintained and highly connected
- **60-79**: Good — solid foundation, minor maintenance needed
- **40-59**: Needs Attention — growing debt in organization or linking
- **0-39**: Critical — vault needs significant cleanup effort

### Key Metrics to Track

| Metric | How to Measure | Healthy Target |
|--------|---------------|----------------|
| **Inbox Count** | Notes in `00-Inbox/` | < 10 |
| **Inbox Age** | Oldest unprocessed inbox note | < 7 days |
| **Orphan Count** | Notes with 0 backlinks | < 10% of vault |
| **Orphan Ratio** | Orphans / total notes | < 0.10 |
| **Stale Active Projects** | Active projects not updated in 30+ days | 0 |
| **Tag Coverage** | Notes with ≥1 tag / total notes | > 90% |
| **Avg Link Density** | Total outgoing links / total notes | > 3.0 |
| **MOC Coverage** | Notes linked from at least 1 MOC / total permanent notes | > 60% |
| **Daily Note Streak** | Consecutive days with a daily note | Personal goal |
| **Weekly Review Streak** | Consecutive weeks with a weekly review | 4+ |

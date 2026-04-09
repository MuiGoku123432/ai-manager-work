# Vault Conventions

Standards and conventions for "The Mind" Obsidian vault.

---

## Folder Structure

| Folder | Purpose | What Goes Here |
|--------|---------|----------------|
| `00-Inbox/` | Capture landing zone | New notes, unprocessed captures, quick thoughts |
| `10-Faith/` | Spiritual growth | Scripture notes, devotionals, prayer journal entries |
| `20-Areas/` | Ongoing life areas | Career, health, finances, relationships — things you maintain |
| `30-Projects/` | Active projects | Time-bound efforts with a clear goal and end state |
| `40-Resources/` | Reference material | Articles, book notes, how-tos, research |
| `50-Daily/` | Periodic notes | Daily notes, weekly reviews, monthly/quarterly reflections |
| `60-Templates/` | Note templates | Templates for all note types |
| `70-Atlas/` | Maps of Content | MOCs, index notes, dashboards |
| `80-Lab/` | Ideas and research | Crazy ideas, random thoughts, shower thoughts, deep research dives |

## Naming Conventions

- **Daily notes**: `YYYY-MM-DD` (e.g., `2026-03-20`)
- **Weekly notes**: `YYYY-[W]WW` (e.g., `2026-W12`)
- **Monthly notes**: `YYYY-MM` (e.g., `2026-03`)
- **Project notes**: Descriptive title, no date prefix (e.g., `Kitchen Renovation`)
- **MOCs**: `MOC - <Topic>` (e.g., `MOC - Personal Finance`)
- **Literature notes**: `<Author> - <Title>` (e.g., `Tiago Forte - Building a Second Brain`)
- **Permanent notes**: Clear, declarative title (e.g., `Compound Interest Favors Early Action`)
- Use title case for note names
- No special characters except hyphens in file names

## Frontmatter Standards

### All Notes (minimum)
```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: []
---
```

### Project Notes
```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - project/active
status: active  # active | paused | done | archived
area: ""        # parent area (e.g., career, home)
start-date: YYYY-MM-DD
target-date: YYYY-MM-DD
---
```

### Area Notes
```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - area/<name>
---
```

### Literature/Resource Notes
```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - resource
source: ""
author: ""
type: article | book | video | podcast | course
---
```

### MOC Notes
```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - moc
scope: ""  # topic, area, project, or home
---
```

### Daily Notes
```yaml
---
created: YYYY-MM-DD
tags:
  - daily
---
```

### Weekly Notes
```yaml
---
created: YYYY-MM-DD
tags:
  - weekly
week: WW
year: YYYY
---
```

## Tag Taxonomy

### Status Tags (projects)
- `#project/active` — currently being worked on
- `#project/paused` — on hold, will resume
- `#project/done` — completed, may archive
- `#project/archived` — reference only

### Area Tags
- `#area/career`
- `#area/health`
- `#area/finance`
- `#area/relationships`
- `#area/home`
- `#area/faith`
- `#area/learning`

### Content Type Tags
- `#resource` — reference material
- `#moc` — map of content
- `#daily` — daily note
- `#weekly` — weekly note
- `#monthly` — monthly note
- `#fleeting` — quick capture, needs processing
- `#permanent` — distilled, evergreen note
- `#literature` — from a specific source
- `#idea` — wild idea, half-baked concept, "what if" thinking (80-Lab)
- `#research` — deep research dive or investigation (80-Lab)
- `#thought` — random observation or shower thought (80-Lab)

### Habit Tags (for daily notes)
- `#habit/exercise`
- `#habit/reading`
- `#habit/prayer`
- `#habit/journaling`

## Link Conventions

- Use `[[wikilinks]]` for internal links (not markdown links)
- Use `[[Note Title|display text]]` when the note title is too long
- Link to MOCs from individual notes when relevant
- Link related notes to each other bidirectionally when the relationship is meaningful
- Prefer linking to existing notes over creating duplicates
- Use `[[Note Title#Heading]]` to link to specific sections

## Note Sections

### Standard Note Structure
1. **Title** (H1) — matches filename
2. **Summary** — 1-2 sentence overview (for MOC listings)
3. **Body** — main content
4. **Related** — links to connected notes
5. **Sources** — external references (if applicable)

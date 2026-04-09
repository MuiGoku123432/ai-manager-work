# Vault Conventions

Standards for "The Forge" -- Connor's W2 Obsidian vault.

---

## Folder Structure

| Folder | Purpose | Typical Note Types |
|--------|---------|-------------------|
| `00-Inbox/` | Capture landing zone -- unprocessed notes | Fleeting, auto-captured |
| `20-Areas/` | Ongoing work areas | Area notes (permanent) |
| `30-Projects/` | Active W2 projects | Project notes |
| `40-Resources/` | Reference material | Literature notes, how-tos |
| `50-Daily/` | Daily and weekly notes | Periodic notes |
| `60-Templates/` | Note templates | Templates only |
| `70-Atlas/` | MOCs and vault dashboard | MOC notes, Home note |
| `80-Lab/` | Wild ideas, research dives | Lab notes, research syntheses |

---

## Note Types

| Type | Description | Primary Folder |
|------|-------------|---------------|
| Fleeting | Quick captures, unprocessed ideas | `00-Inbox/` |
| Permanent | Distilled, long-term knowledge | `20-Areas/`, `40-Resources/` |
| Literature | Notes from a specific source (book, article, video) | `40-Resources/` |
| Project | Scoped project with phases, tasks, target date | `30-Projects/` |
| Periodic | Daily or weekly notes | `50-Daily/` |
| MOC | Map of Content -- index of notes on a topic | `70-Atlas/` |
| Lab | Experimental ideas, research outputs | `80-Lab/` |

---

## Frontmatter Standard

Every note requires at minimum:

```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - <type>
---
```

**Project notes** also require:
```yaml
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
```

**Relationship metadata** (add below frontmatter, before the title):
```
depends-on:: [[Other Project]]
feeds-into:: [[Other Project]]
supports:: [[Area Note]]
```

---

## Tag Taxonomy

| Tag | Use When |
|-----|----------|
| `#project/active` | Project currently being worked |
| `#project/paused` | Project on hold |
| `#project/done` | Project complete |
| `#project/archived` | Project archived to history |
| `#area/<name>` | Marks an area note (career, learning, engineering) |
| `#fleeting` | Quick capture, not yet processed |
| `#permanent` | Distilled, long-term knowledge |
| `#literature` | Notes from a specific source |
| `#moc` | Map of Content |
| `#research` | Research output (from recursive-research) |
| `#lab` | Experimental idea or deep dive |
| `#daily` | Daily note |
| `#weekly` | Weekly synthesis note |

---

## Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Project notes | Title Case | `W2 Feature Migration.md` |
| Area notes | Title Case | `Career.md`, `Engineering.md` |
| Daily notes | YYYY-MM-DD | `2026-04-09.md` |
| Weekly notes | YYYY-W## | `2026-W15.md` |
| MOC notes | MOC - Topic | `MOC - Lockheed Martin.md` |
| Lab notes | Title Case | `Experiment - GraphQL vs REST.md` |
| Research synthesis | Topic + Synthesis | `COBOL Migration - Research Synthesis.md` |

---

## Link Conventions

- Use `[[wikilinks]]` for all internal links (not markdown links)
- Link target is the note filename without `.md`
- Section links: `[[Note Title#Section Heading]]`
- Display text: `[[Note Title|display text]]`
- Always create bidirectional links: if A links to B, add A to B's Related section
- Never use absolute paths -- wikilinks are vault-relative

---

## Work Areas

The `vault/20-Areas/` folder tracks ongoing work dimensions:

| Area Note | Content |
|-----------|---------|
| `Career.md` | W2 career trajectory, performance notes, skills development |
| `Learning.md` | ASU coursework, professional certifications, book notes |
| `Engineering.md` | Technical patterns, architecture decisions, code conventions |

Each area note maintains an **Active Projects** section with wikilinks to current `30-Projects/` notes.

---

## Compliance Note

Vault contents are gitignored. Only folder scaffolding (`.gitkeep` files) is tracked in git. This ensures no company-sensitive data enters version control.

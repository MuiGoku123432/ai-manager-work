# Obsidian Wiring Sequences

Exact tool sequences for wiring a newly scaffolded project into "The Forge" vault at `vault/`. Uses Crush native file tools for CRUD and obsidian CLI for search/move operations.

**Critical notes:**
- Never overwrite a vault note without reading it first
- Use `write` (full overwrite) when creating new notes, `edit` for targeted changes to existing ones
- `obsidian --vault ./vault move` is the only safe way to rename notes -- it updates all wikilinks
- For adding a link to an existing note's section, prefer Read + Edit (not full rewrite)

---

## Sequence 1: Create Project Note

```
# Step 1 -- Check for duplicates first (PARALLEL)
obsidian --vault ./vault search query="<Project Title>"
obsidian --vault ./vault search:context query="<project topic keywords>"
glob vault/30-Projects/*.md

# Step 2 -- If no duplicate, write the note
# write vault/30-Projects/<Project Title>.md
# Content: Variant 1 or 2 from project-note-template.md

# Step 3 -- Verify creation
view vault/30-Projects/<Project Title>.md
```

---

## Sequence 2: Link to Parent Area Note

```
# Step 1 -- Find the area note
glob vault/20-Areas/*.md

# Step 2 -- Read the full area note
view vault/20-Areas/<Area Name>.md

# Step 3 -- Edit to add project link
# Find the "## Active Projects" section
# Add: - [[<Project Title>]]
# If no such section exists, add it before the ## Notes section
edit vault/20-Areas/<Area Name>.md

# Step 4 -- If no area note exists, create one
# write vault/20-Areas/<Area Name>.md
# Content:
# ---
# created: YYYY-MM-DD
# updated: YYYY-MM-DD
# tags:
#   - area/<name>
# ---
#
# # <Area Name>
#
# ## Overview
# <Brief description of this work area.>
#
# ## Active Projects
# - [[<Project Title>]]
#
# ## Notes
```

---

## Sequence 3: Update or Create MOC

```
# Step 1 -- Check if a relevant MOC exists
obsidian --vault ./vault search query="MOC - <topic>"
glob vault/70-Atlas/*.md

# Step 2A -- If MOC exists: read-modify-write
view vault/70-Atlas/MOC - <Topic>.md
# Add project link under ## Projects section
edit vault/70-Atlas/MOC - <Topic>.md

# Step 2B -- If no MOC exists: create one
# write vault/70-Atlas/MOC - <Topic>.md
# Content:
# ---
# created: YYYY-MM-DD
# updated: YYYY-MM-DD
# tags:
#   - moc
# ---
#
# # MOC - <Topic>
#
# Map of Content for <topic description>.
#
# ## Key Concepts
# - <Link to foundational notes>
#
# ## Projects
# - [[<Project Title>]]
#
# ## Resources
# - <Link to reference material>
#
# ## Related MOCs
# - [[MOC - <Related Topic>]]
```

---

## Sequence 4: Add Relationship Metadata

```
# Step 1 -- Read the project note
view vault/30-Projects/<Project Title>.md

# Step 2 -- Edit to add relationship metadata
# Place these lines between the closing --- of frontmatter and the # title
# Add only relationships that apply:
#
# depends-on:: [[Other Project]]
# feeds-into:: [[Other Project]]
# supports:: [[Area Note]]
#
edit vault/30-Projects/<Project Title>.md
```

---

## Sequence 5: Duplicate Detection

Always run before creating any note.

```
# Run in PARALLEL:
obsidian --vault ./vault search query="<project title keywords>"
obsidian --vault ./vault search:context query="<project description>"
glob vault/30-Projects/*.md

# Check Git repo too:
# ls projects/
```

**Decision matrix:**

| Finding | Action |
|---------|--------|
| Exact title match in vault | Present existing note, ask: update existing or cancel |
| Very similar project (> 80% overlap) | Present both, ask user to confirm they're different |
| Related project (different scope) | Proceed, add `depends-on` or `feeds-into` relationship |
| No match | Proceed with creation |

---

## Sequence 6: Full Scaffold Sequence

Complete order of operations after user confirms:

```
1. PARALLEL: duplicate check (vault search + glob + ls projects/)

2. On no duplicate confirmed:
   Write projects/<name>/README.md

3. Write vault/30-Projects/<Title>.md (from project-note-template.md)

4. Verify creation:
   view vault/30-Projects/<Title>.md

5. PARALLEL:
   a. Find area note (glob vault/20-Areas/)
   b. Find relevant MOC (glob vault/70-Atlas/)

6. Read area note -> edit to add project link (Sequence 2)

7. Read MOC or create if none exists (Sequence 3)

8. If relationships identified during planning:
   Edit project note to add relationship metadata (Sequence 4)

9. If Crush skill project:
   Write .crush/skills/<name>/SKILL.md
   Update AGENTS.md Available Skills table

10. Edit decisions/log.md to append creation entry

11. REPORT: list all created artifacts with paths
```

---

## Common Errors and Fixes

| Error | Likely Cause | Fix |
|-------|-------------|-----|
| Wikilink not resolving | Title case mismatch | Use the exact note filename (without .md) in wikilinks |
| Area note not found | Folder not yet seeded | Create the area note first with Sequence 2 Step 4 |
| MOC search returns nothing | MOC doesn't exist yet | Create a new MOC using Sequence 3 Step 2B |
| Duplicate project created | Skipped Sequence 5 | Never skip duplicate detection |

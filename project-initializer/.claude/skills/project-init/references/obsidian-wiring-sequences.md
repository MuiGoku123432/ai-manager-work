# Obsidian Wiring Sequences

Exact CLI command sequences for wiring a newly scaffolded project into the Obsidian vault. All commands use the `obsidian` CLI via Bash.

**Vault:** "The Mind" | **Path:** `/Users/cfanch06/Obsidian/The Mind/`

**Critical CLI notes:**
- Always use `--overwrite` when updating existing notes: `obsidian create path="..." content="..." --overwrite`
- Without `--overwrite`, the CLI creates a duplicate with a number suffix (e.g., `Note 1.md`)
- For targeted changes, use `obsidian frontmatter "<path>" --edit --key "<key>" --value "<value>"`
- For complex content edits, prefer Read + Edit tools directly on the vault path
- `obsidian move path="<old>" to="<new>"` -- use quoted paths for filenames with spaces

---

## Sequence 1: Create Project Note

```
# Step 1 -- Check for duplicates first (PARALLEL)
obsidian search query="<Project Title>"
obsidian search:context query="<project topic keywords>"

# Step 2 -- If no duplicate, create the note
obsidian create path="30-Projects/<Project Title>.md" content="<full note content from template>"
```

**After creation, confirm:**
```
obsidian read path="30-Projects/<Project Title>.md"
```

---

## Sequence 2: Link to Parent Area Note

Use this to add the new project to the relevant area note in `20-Areas/`. This is a read-modify-write sequence.

```
# Step 1 -- Find the area note
obsidian search query="<area name>"
obsidian files folder="20-Areas"

# Step 2 -- Read the full area note (CRITICAL: read the whole thing)
obsidian read path="20-Areas/<Area Name>.md"

# Step 3 -- In memory: append the project link
# Find the "## Projects" or "## Connected Projects" or "## Active Projects" section
# Append: - [[<Project Title>]]
# If no such section exists, add one at the end

# Step 4 -- Write the full updated content back
obsidian create path="20-Areas/<Area Name>.md" content="<full updated content>"
```

**If no area note exists for the relevant area:**
```
obsidian create path="20-Areas/<Area Name>.md" content="---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - area
---

# <Area Name>

## Overview
<Brief description of this life area.>

## Active Projects
- [[<Project Title>]]

## Notes
"
```

---

## Sequence 3: Update or Create MOC

Use this to add the project to the relevant Map of Content in `70-Atlas/`.

```
# Step 1 -- Check if a relevant MOC exists
obsidian search query="MOC - <topic>"
obsidian files folder="70-Atlas"

# Step 2A -- If MOC exists: read-modify-write
obsidian read path="70-Atlas/MOC - <Topic>.md"
# In memory: add project under the ## Projects section
# Write back:
obsidian create path="70-Atlas/MOC - <Topic>.md" content="<full updated content>"

# Step 2B -- If no MOC exists: create a new one
obsidian create path="70-Atlas/MOC - <Topic>.md" content="---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - moc
---

# MOC - <Topic>

Map of Content for <topic description>.

## Key Concepts
- <Link to foundational notes>

## Projects
- [[<Project Title>]]

## Resources
- <Link to reference material>

## Related MOCs
- [[MOC - <Related Topic>]]
"
```

---

## Sequence 4: Add Relationship Metadata

Add relationship annotations to the project note. These are inline metadata fields that Dataview can query.

```
# Step 1 -- Read the project note
obsidian read path="30-Projects/<Project Title>.md"

# Step 2 -- In memory: add relationship metadata immediately below frontmatter
# Format (add only the relationships that apply):
#
# depends-on:: [[Other Project]]
# feeds-into:: [[Other Project]]
# shares-resource:: [[Other Project]]
# supports:: [[Area Note]]
#
# Place these lines between the closing --- of frontmatter and the # Project Title heading

# Step 3 -- Write back
obsidian create path="30-Projects/<Project Title>.md" content="<full updated content>"
```

**Relationship types:**

| Type | Use When |
|------|----------|
| `depends-on` | This project cannot start Phase N until another project completes |
| `feeds-into` | Output of this project is direct input to another project |
| `shares-resource` | Both projects compete for the same budget, tool, or time block |
| `supports` | This project exists to improve an ongoing life area |

---

## Sequence 5: Duplicate Detection

Always run before creating any note.

```
# Run in parallel
PARALLEL:
  obsidian search query="<project title keywords>"
  obsidian search:context query="<project description>"
  obsidian files folder="30-Projects"

# Check Git repo too (via Bash)
ls /path/to/ai-projects/projects/
```

**Decision matrix:**
| Finding | Action |
|---------|--------|
| Exact title match in vault | Present existing note, ask: update existing or cancel |
| Very similar project (>80% overlap) | Present both, ask user to confirm they're different |
| Related project (different scope) | Proceed, but add `depends-on` or `feeds-into` relationship |
| No match | Proceed with creation |

---

## Sequence 6: Full Scaffold Sequence (Combined)

The complete order of operations for `scaffold-agent` after user confirms:

```
1. PARALLEL: duplicate check (vault search + Git ls)

2. On no duplicate confirmed:
   CREATE projects/<name>/README.md (Bash: mkdir + Write)

3. CREATE 30-Projects/<Title>.md (obsidian create with full template)

4. VERIFY creation:
   obsidian read path="30-Projects/<Title>.md"

5. PARALLEL:
   a. Find area note (obsidian search + files folder)
   b. Find relevant MOC (obsidian search + files folder)

6. READ area note (obsidian read)
   MODIFY in memory (append project link)
   WRITE back (obsidian create)

7. READ MOC or CREATE if none exists (obsidian read or create)

8. IF relationships identified during planning:
   READ project note
   ADD relationship metadata
   WRITE back

9. IF Claude Code domain project:
   CREATE domain directory structure (Bash: mkdir -p)
   WRITE CLAUDE.md, .mcp.json, .claude/settings.json

10. APPEND to decisions/log.md (Read + Edit)

11. REPORT: list all created artifacts with paths
```

---

## Common Errors and Fixes

| Error | Likely Cause | Fix |
|-------|-------------|-----|
| `obsidian create` overwrites content | Forgot to read first | Always read before writing to existing notes |
| Area note not found | Area name doesn't match file name exactly | Use `obsidian files folder="20-Areas"` to find the exact filename |
| MOC search returns no results | MOC may not exist yet | Create a new MOC using Sequence 3, Step 2B |
| Duplicate project created | Skipped duplicate detection | Never skip Sequence 5 |
| Broken wikilinks | Title case mismatch | Use the exact note filename (without `.md`) in wikilinks |

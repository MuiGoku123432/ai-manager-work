# Vault Linker Agent

**Purpose:** Discover connections between vault notes and create bidirectional wikilinks. Keeps the knowledge graph well-connected by auto-relating projects, areas, and resources.

**When to use:** Pass this prompt to the `agent` tool after creating a new note or project, or when running `/second-brain link <note>` to discover connections for an existing note.

**Model:** Task agent (haiku -- file reads and simple edits, no complex reasoning)

---

## Prompt Template

```
You are a vault linker agent for the Obsidian vault "The Forge".

Target note: <path to the note to find connections for>
Vault name: "The Forge"

Instructions:
1. Read the target note:
   obsidian "The Forge" read path="<note-path>"

2. Extract key concepts, project names, technologies, and topics from the note.

3. Search for related notes (PARALLEL):
   obsidian "The Forge" search:context query="<concept 1>"
   obsidian "The Forge" search:context query="<concept 2>"
   obsidian "The Forge" search query="<key term>"

4. Read the top 5 candidate notes.

5. For each candidate that has a genuine connection:
   - Determine the relationship type: depends-on, feeds-into, supports, related
   - Check if the target note already links to the candidate (avoid duplicates)
   - Check if the candidate already links back to the target

6. Present a connection plan:
   | Connection | Type | Target Note Action | Candidate Note Action |
   |-----------|------|-------------------|----------------------|
   | [[Candidate A]] | related | Add to ## Connected Notes | Add back-link to target |

7. On confirmation (or if running autonomously), execute the plan:
   - Edit the target note to add links in ## Connected Notes
   - Edit each candidate note to add the reciprocal link
   - Report all edits made

Report:
- Connections found: N
- Links added to target note: <list>
- Back-links added to: <list>
- Already connected (skipped): <list>
```

---

## Example Invocation

```
agent("
  You are a vault linker agent for the Obsidian vault 'The Forge'.
  Target note: 30-Projects/API Migration Project.md

  1. Read the target note using: obsidian 'The Forge' read path='30-Projects/API Migration Project.md'
  2. Extract key concepts (GraphQL, REST, service mesh, Windstream, federation)
  3. Search for related notes:
     - obsidian 'The Forge' search:context query='GraphQL Federation'
     - obsidian 'The Forge' search:context query='Windstream API'
     - obsidian 'The Forge' search query='service mesh'
  4. Read top 5 candidates
  5. Build connection plan
  6. Execute: add [[wikilinks]] to both the target note and each candidate
  7. Report all links added
")
```

---

## Relation Types

| Type | Use When |
|------|----------|
| `depends-on` | This project cannot progress until another completes |
| `feeds-into` | Output of this note/project is input to another |
| `supports` | This project improves an ongoing area |
| `related` | General topical connection with no dependency |

---

## Notes

- Always check for existing links before adding to avoid duplicates
- For project notes, add relationships as frontmatter inline metadata (`depends-on::`, `feeds-into::`, `supports::`) in addition to wikilinks in the Connected Notes section
- Never remove existing links -- only add new ones
- If the target note has no `## Connected Notes` section, add one before the `## Notes` section

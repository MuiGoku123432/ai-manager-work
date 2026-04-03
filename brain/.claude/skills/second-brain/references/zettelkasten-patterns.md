# Zettelkasten Patterns

Note types, linking strategies, progressive summarization, and MOC patterns for "The Mind" vault.

---

## Note Types

| Type | Purpose | Location | Lifespan | Tag |
|------|---------|----------|----------|-----|
| **Fleeting** | Quick captures, raw thoughts | `00-Inbox/` | Temporary — process within 48h | `#fleeting` |
| **Literature** | Ideas from a specific source | `40-Resources/` | Permanent | `#literature` |
| **Permanent** | Distilled, standalone ideas | `40-Resources/` or relevant area | Permanent | `#permanent` |
| **Project** | Active work with a goal | `30-Projects/` | Until archived | `#project/*` |
| **Periodic** | Daily/weekly/monthly reflections | `50-Daily/` | Permanent | `#daily`, `#weekly`, `#monthly` |
| **MOC** | Maps of Content — index notes | `70-Atlas/` | Permanent, evolving | `#moc` |

### Note Type Lifecycle
```
Fleeting → (process) → Literature or Permanent
Literature → (distill) → Permanent
Permanent → (connect) → linked to MOCs and other permanents
Project → (complete) → Done/Archived
```

## Progressive Summarization

Layer notes over time to make them more useful. Each pass adds a layer of distillation.

| Layer | Action | Marker |
|-------|--------|--------|
| **L1: Capture** | Save the full note/excerpt | Raw text |
| **L2: Bold** | Bold the most important passages | **bold text** |
| **L3: Highlight** | Highlight the key sentences within bold | ==highlighted== |
| **L4: Summary** | Write a 1-2 sentence summary at the top | Summary section |
| **L5: Remix** | Create a new permanent note from the distilled idea | New note with link back |

### When to Apply Each Layer
- **L1**: Always — every note starts here
- **L2**: When you revisit a note for the first time
- **L3**: When you revisit again and need to find the key point fast
- **L4**: When you want the note to be scannable in a MOC listing
- **L5**: When the idea stands on its own and connects to other ideas

## Linking Strategies

### When to Link
- Two notes share a concept, not just a keyword
- One note provides evidence, context, or counterpoint to another
- A note belongs in a MOC's scope
- A project note references a resource or area

### When NOT to Link
- The connection is trivial or obvious (don't link every mention of "budget")
- The link would be one-directional with no value to the target note
- A tag would serve the purpose better than a link

### Link Density Guidelines
- **Permanent notes**: 3-8 outgoing links (to related permanents, sources, MOCs)
- **Literature notes**: 1-3 outgoing links (to source, related permanents)
- **Project notes**: 3-10 links (to related projects, areas, resources)
- **MOC notes**: 10-50+ links (this is their purpose)
- **Daily notes**: 0-5 links (to whatever was referenced that day)

### Backlink Hygiene
- Periodically review notes with 0 backlinks (orphans)
- Notes with many backlinks are likely MOC candidates
- If a note has 10+ backlinks, consider whether it should be promoted to a MOC

## MOC Patterns

Maps of Content are index notes that organize other notes around a theme.

### MOC Types

| Type | Scope | Example | Location |
|------|-------|---------|----------|
| **Topic MOC** | A subject or concept | `MOC - Personal Finance` | `70-Atlas/` |
| **Project MOC** | A complex project's context | `MOC - Kitchen Renovation` | `70-Atlas/` |
| **Area MOC** | An ongoing life area | `MOC - Health & Fitness` | `70-Atlas/` |
| **Home MOC** | Top-level dashboard | `MOC - Home` | `70-Atlas/` |

### MOC Structure
```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - moc
scope: topic
---

# MOC - <Topic>

Brief description of what this MOC covers.

## Key Concepts
- [[Note 1]] — one-line summary
- [[Note 2]] — one-line summary

## Deep Dives
- [[Detailed Note A]] — longer exploration of sub-topic
- [[Detailed Note B]] — another angle

## Projects
- [[Active Project]] — current work related to this topic

## Resources
- [[Book Note]] — external source
- [[Article Note]] — external source

## Related MOCs
- [[MOC - Related Topic]]
```

### When to Create a MOC
- You have 5+ notes on a topic and finding them requires searching
- A tag is being used as navigation (tags should classify, MOCs should navigate)
- You want to create a curated reading path through a topic
- A project is complex enough to need its own index

### When to Update a MOC
- A new permanent note is created that fits the MOC's scope
- During weekly or monthly reviews
- When the MOC's structure no longer reflects how you think about the topic

## Atomic Notes Principle

Each permanent note should express one idea clearly enough that it can be understood without reading linked notes. Test: if you read only this note, does it make sense on its own?

### Good Atomic Note
- Title is a clear statement: "Compound Interest Favors Early Action"
- Body explains the idea in 2-5 paragraphs
- Links to related notes for deeper exploration
- Can be linked to from multiple MOCs

### Bad Atomic Note
- Title is vague: "Finance Thoughts"
- Body covers 5 different topics
- Makes no sense without reading 3 other notes first
- Only fits in one context

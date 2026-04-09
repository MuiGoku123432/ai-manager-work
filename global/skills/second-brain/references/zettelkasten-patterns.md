# Zettelkasten Patterns

Note-taking philosophy and patterns for "The Forge" vault. Based on the Zettelkasten method adapted for W2 engineering work.

---

## Note Types

| Type | Purpose | Folder | Lifespan |
|------|---------|--------|---------|
| Fleeting | Quick capture -- raw idea, observation, action item | `00-Inbox/` | Hours to days -- process or discard |
| Literature | Notes from a specific source (doc, book, article, video) | `40-Resources/` | Long-term |
| Permanent | Distilled knowledge, your own synthesis | `20-Areas/`, `40-Resources/` | Permanent |
| Project | Scoped deliverable with phases and tasks | `30-Projects/` | Duration of project |
| Periodic | Daily or weekly log | `50-Daily/` | Reference |
| MOC | Index of notes on a topic, not a note itself | `70-Atlas/` | Evolving |
| Lab | Experimental -- wild ideas, half-baked hypotheses | `80-Lab/` | Speculative |

---

## Atomic Notes Principle

One idea per note. A note should be small enough to be fully understood in isolation.

**Too broad:** "Everything I know about GraphQL"
**Right size:** "GraphQL Federation -- how subgraph schemas compose"

When a note grows beyond ~500 words, consider splitting it or making it a MOC that links to smaller notes.

---

## Progressive Summarization

For literature notes from a long source, summarize in 5 layers:

1. **Capture** -- paste key quotes and highlights as-is (in `00-Inbox/`)
2. **Bold** -- bold the most important phrases on first pass
3. **Highlight** -- highlight the most important bolded phrases
4. **Mini-summary** -- write a 2-3 sentence summary at the top
5. **Remix** -- rewrite the core ideas in your own words (this becomes a permanent note)

You don't need all 5 layers for every note. Short sources may only need layers 1-3.

---

## Linking Strategies

**Link when you think of it, not later.** The moment you write a note and think "this relates to X," add the link immediately.

**Types of links to add:**
- `[[Concept A]]` -- when this note mentions or depends on another concept
- `[[Project B]]` -- when this note affects or is affected by a project
- `[[Area Note]]` -- when this note belongs to a life/work area

**Bidirectional links:** If A links to B, add the link from B to A's Related section. The `/second-brain link` command automates this.

**Dense linking = healthy vault.** A note with no links is an orphan -- it has value but can't be found by traversal.

---

## MOC Patterns

MOCs (Maps of Content) are index notes, not content notes. They collect links -- they don't explain concepts themselves.

**When to create a MOC:**
- You have 5+ notes on a topic and can't find the right one without searching
- A topic spans multiple projects and areas
- You want a home page for a domain area

**MOC structure:**
```markdown
# MOC - <Topic>

<1-2 sentence description of the topic scope>

## Core Concepts
- [[Concept 1]] -- <one-line description>
- [[Concept 2]] -- <one-line description>

## Projects
- [[Project A]] -- <one-line description>

## Resources
- [[Literature Note 1]] -- <source title>

## Related MOCs
- [[MOC - <Adjacent Topic>]]
```

---

## Inbox Processing Rules

The inbox is a temporary landing zone -- not a storage location.

Every note in `00-Inbox/` should be processed within 7 days:
- **Promote** to the correct folder (20-Areas, 30-Projects, 40-Resources, 80-Lab)
- **Discard** if it has no lasting value
- **Defer** only if you're actively working on it and expect to process it soon

The `/second-brain organize` and `/second-brain inbox` commands help with batch processing.

---

## Engineering-Specific Patterns

**Decision Records:** Engineering decisions go in the project note's `## Decisions Log` section first, then important ones get captured to `00-Inbox/` via auto-capture for permanent storage.

**Architecture Notes:** High-level architecture insights go in `vault/20-Areas/Engineering.md` as permanent notes, linked back to the relevant project.

**Code Patterns:** Reusable code patterns and conventions belong in `vault/40-Resources/` as literature or permanent notes, not in project notes.

# Wiki Conventions

Standards for the research wiki in `projects/<slug>/wiki/`. The wiki is a set of interlinked markdown files that grow with each iteration.

---

## Folder Structure

```
wiki/
  index.md          -- Root node: overview, source bibliography, links to all subtopic pages
  <subtopic-1>.md   -- One page per sub-topic from program.md
  <subtopic-2>.md
  ...
```

## Naming Conventions

- All filenames: lowercase-kebab-case (e.g., `graphql-federation-gateway.md`)
- Match the sub-topic names from `program.md` as closely as possible
- No spaces or special characters in filenames

## Frontmatter

Every wiki page:

```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
topic: <parent research topic>
sources:
  - source-1: <URL>
  - source-2: <URL>
gaps: <number of [GAP] markers on this page>
---
```

## index.md Structure

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
topic: <Research Topic>
sources:
  - source-1: <URL>
  - source-2: <URL>
---

# <Research Topic> -- Knowledge Base

## Overview
<2-4 sentence executive summary of what we know so far>

## Sub-Topics
- [[subtopic-1]] -- <one-line description>
- [[subtopic-2]] -- <one-line description>

## Source Bibliography
| ID | URL | Domain | Key Claims | Fetch Status |
|----|-----|--------|-----------|--------------|
| source-1 | <URL> | <domain> | <what it supports> | Fetched / Snippet only |

## Current Status
- Completeness: XX% (N of M sub-topics fully covered)
- Open gaps: N
- Unresolved conflicts: N
- Total sources: N
```

## Subtopic Page Structure

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
topic: <parent topic>
sources:
  - source-1
  - source-3
gaps: 2
---

# <Sub-Topic Title>

## Summary
<1-2 sentence summary of what we know about this sub-topic>

## Key Facts
- Fact one [source-1][source-3].
- Fact two [source-2].
- [UNVERIFIED: claim that needs more sources -- 2/3 sources]

## Details
<Longer-form content organized by aspect>

## Gaps and Unknowns
- [GAP: what specific information is missing and why it matters]

## Conflicts
- [CONFLICT: Source-1 says X while Source-4 says Y -- unresolved]

## Related
- [[other-subtopic]] -- <how they connect>
```

## Marker Syntax

Use these markers exactly as written -- they are counted for scoring.

| Marker | Purpose | Example |
|--------|---------|---------|
| `[GAP: description]` | Missing knowledge | `[GAP: no information found on authentication patterns]` |
| `[CONFLICT: ...]` | Unresolved contradiction | `[CONFLICT: Source-1 says stdio, Source-3 says HTTP -- unverified which is standard]` |
| `[UNVERIFIED: claim -- N/3 sources]` | Insufficient source coverage | `[UNVERIFIED: max 1000 tokens per tool call -- 1/3 sources]` |
| `[source-N]` | Inline citation | `The spec uses JSON-RPC 2.0 [source-1][source-2].` |

## Link Conventions

- Use `[[wikilinks]]` between wiki pages (not markdown links)
- Link to related subtopics within the body, not just in the Related section
- Link both directions when the relationship is meaningful

## Source Quality Tiers

| Tier | Description | Trust Level |
|------|-------------|-------------|
| Primary | Official docs, spec text, authors' own writing | Highest |
| Secondary | Reputable technical blogs, Stack Overflow | High |
| Tertiary | General web articles, aggregators | Medium -- cross-verify |
| Snippet-only | Search result snippet (page not fetched) | Low -- note as such |

## Completeness Counting

A subtopic page is "gap-free" (contributing to completeness) when:
- It has zero `[GAP]` markers
- It has at least 3 unique sources cited
- It has at least one paragraph of substantive content

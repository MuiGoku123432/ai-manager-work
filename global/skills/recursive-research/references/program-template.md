# Program Template

Template for `program.md` -- the research strategy file. Each research project in `projects/<slug>/` gets one. Edit this file to guide the research loop. The agents read it at the start of every iteration.

---

## Template

```markdown
# Research Program: <Topic>

## Research Question
<The primary question this research should answer. Be specific.>

## Goal
<What "done" looks like. What will someone be able to do or understand after reading the output?>

## Scope

**In scope:**
- <Sub-topic 1>
- <Sub-topic 2>
- <Sub-topic 3>

**Out of scope:**
- <What to explicitly ignore>
- <Adjacent topics to skip>

## Sub-Topics to Explore

List the expected sub-topics. These become the expected wiki pages for completeness scoring.

1. <Sub-topic 1>
2. <Sub-topic 2>
3. <Sub-topic 3>
4. <Sub-topic 4>
5. <Sub-topic 5>

## Search Strategy

**Primary search terms:**
- <term 1>
- <term 2>

**Technical/academic terms:**
- <specialized vocabulary>
- <field-specific terms>

**Known key sources (optional):**
- <URL or author or publication if you already know it>

**Search angles to try:**
- Overview: "<topic> overview 2025"
- Recent: "<topic> latest developments 2026"
- Debates: "<topic> controversy problems limitations"
- Practitioners: "<topic> best practices real-world"
- Comparisons: "<topic> vs alternatives"

## Termination Criteria

- Max iterations: 10
- Completeness threshold: 85%
- Minimum sources per claim: 3

## Quality Constraints

- Cross-verify all major claims across 3+ independent sources
- Flag contradictions between sources with [CONFLICT] markers
- Prefer primary sources over secondary summaries when available
- Note the date of sources -- prefer content from 2024-2026 for fast-moving topics

## Notes

<Any specific guidance for the research agent. Examples:>
- Focus on practical implementation details, not theory
- Prioritize open-source options over commercial
- Connor's use case is: <description>
```

---

## Example: Filled program.md

```markdown
# Research Program: GraphQL Federation Patterns

## Research Question
What are the best patterns for implementing GraphQL Federation in a Go microservices architecture, and what open-source examples exist as of 2026?

## Goal
A practical guide: choose a federation approach, understand the spec, find reference implementations in Go, and know the common pitfalls.

## Scope

**In scope:**
- GraphQL Federation spec fundamentals
- Building federation gateways in Go
- Subgraph schema design patterns
- Performance considerations at scale
- Open-source Go Federation examples

**Out of scope:**
- Federation in non-Go languages
- GraphQL vs REST debate
- Client-side caching strategies

## Sub-Topics to Explore

1. Federation spec overview and core concepts
2. Gateway implementation in Go
3. Subgraph design patterns
4. Schema composition and type merging
5. Authentication and authorization at federation layer
6. Performance and caching patterns
7. Existing open-source Go federation implementations

## Search Strategy

**Primary search terms:**
- "GraphQL Federation Go"
- "Apollo Federation Go implementation"

**Technical terms:**
- "subgraph schema stitching"
- "federated gateway resolver"

**Search angles:**
- Overview: "GraphQL federation tutorial 2025 2026"
- Go-specific: "Go graphql federation library"
- Debates: "GraphQL federation problems limitations"
- Practitioners: "GraphQL federation production patterns"

## Termination Criteria

- Max iterations: 8
- Completeness threshold: 80%
- Minimum sources per claim: 3

## Notes

- Focus on production-ready patterns, not toy examples
- Prefer Go-native solutions over wrappers around JS libraries
```

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
# Research Program: Claude Code MCP Server Patterns

## Research Question
What are the best patterns for building and deploying Model Context Protocol (MCP) servers with Claude Code, and what open-source examples exist as of 2026?

## Goal
A practical guide: choose an MCP server approach, understand the spec, find reference implementations, and know the common pitfalls.

## Scope

**In scope:**
- MCP spec fundamentals (tools, resources, prompts)
- Building MCP servers in Go and Python
- Deploying MCP servers locally and in Docker
- Claude Code integration patterns
- Open-source MCP server examples

**Out of scope:**
- MCP clients other than Claude Code
- Enterprise MCP server hosting
- SDK internals / protocol binary format

## Sub-Topics to Explore

1. MCP spec overview and core concepts
2. Building MCP servers in Go
3. Building MCP servers in Python
4. Claude Code .mcp.json configuration patterns
5. Local vs remote MCP server deployment
6. Authentication and security patterns
7. Existing open-source MCP servers as reference

## Search Strategy

**Primary search terms:**
- "Model Context Protocol MCP server"
- "Claude Code MCP integration"

**Technical terms:**
- "MCP tools resources prompts"
- "JSON-RPC MCP transport"

**Search angles to try:**
- Overview: "MCP server tutorial 2025 2026"
- Recent: "Model Context Protocol updates 2026"
- Debates: "MCP server limitations problems"
- Practitioners: "Claude Code MCP server examples"

## Termination Criteria

- Max iterations: 8
- Completeness threshold: 80%
- Minimum sources per claim: 3

## Notes

- Connor is building MCP servers in Go for Sentinovo
- Prefer Go examples over Python when both exist
- Focus on stdio transport pattern (used in existing servers like monarchmoney, rentcast)
```

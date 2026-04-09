# Agent Prompt Patterns

How to effectively use Crush's `agent` tool with the templates in `~/.config/crush/agents/`.

---

## How the `agent` Tool Works

Crush's `agent` tool spawns a sub-task that runs using the `task` agent role. The sub-task gets its own context window, executes the prompt, and returns a result. Key properties:

- Runs sequentially (not truly parallel in the background)
- Uses the `task` role model (configured in crush.json)
- Has access to the same tools as the main session
- Returns a single result string to the caller
- No persistent state between agent calls -- each call is fresh

**When to use it:**
- Delegating a bounded, well-defined sub-task (capture a note, run searches, update wiki pages)
- Keeping the main conversation clean by offloading mechanical work
- Running something that has a clear input/output contract

**When NOT to use it:**
- Complex multi-step reasoning that needs back-and-forth
- Tasks that require the user's input mid-execution
- Simple file reads or writes you can do inline

---

## Using Templates from `~/.config/crush/agents/`

Templates are markdown files with a prompt template and usage notes. Use them by:

1. Reading the template
2. Filling in the `<placeholders>` with your specific values
3. Passing the filled prompt to the `agent` tool

```
# Read the template
view ~/.config/crush/agents/capture-agent.md

# Fill in and invoke
agent("
  You are a note capture agent for the Obsidian vault 'The Forge'.
  Capture: 'Decision - Chose PostgreSQL over MongoDB for user sessions'
  ...
")
```

---

## Available Templates

| Template | File | Use Case |
|----------|------|---------|
| Capture Agent | `capture-agent.md` | Save a decision, insight, or lesson to vault inbox |
| Research Scout | `research-scout.md` | Run parallel web searches on a topic |
| Synthesis Agent | `synthesis-agent.md` | Update wiki pages with new research findings |
| Vault Linker | `vault-linker.md` | Create bidirectional wikilinks between related notes |

---

## Capture Pattern

Use after any significant decision or breakthrough. Typical trigger: you just made a non-obvious architectural choice.

```
agent("
  Vault: 'The Forge'
  Task: Capture a note titled '<Decision - Short Description>'
  
  Step 1: Run obsidian 'The Forge' search query='<keywords>' to check for duplicates.
  Step 2: If no duplicate, create 00-Inbox/<Decision - Short Description>.md with:
    - Frontmatter: created, updated, tags: [fleeting], source-project: <name>
    - ## Summary: <2-4 sentences>
    - ## Context: <where this came from>
    - ## Related: [[wikilink if applicable]]
  Step 3: Report 'Captured: <path>' or 'Skipped: already exists'
")
```

---

## Research Scout Pattern

Use at the start of each `/recursive-research iterate` cycle to gather sources.

```
agent("
  Research scout task for topic: <topic>
  Gaps to fill: <list from program.md>
  
  Run 4 searches:
  - '<query 1>'
  - '<query 2>'
  - '<query 3>'
  - '<topic> problems limitations 2025 2026'
  
  For each result: attempt full fetch, fall back to snippet.
  Return: URL, fetch status, 3-5 key claims, gaps addressed, source tier.
  End with: gaps addressed, gaps still open.
")
```

---

## Synthesis Pattern

Use after research scout returns findings.

```
agent("
  Synthesis task for: projects/<slug>/wiki/
  
  New findings: <paste structured findings from scout>
  
  Read current wiki state, integrate findings, update pages.
  Close [GAP] markers where addressed. Add [CONFLICT] where contradictions found.
  
  Report: pages updated, gaps closed, new gaps found, clarity score.
")
```

---

## Vault Linker Pattern

Use after creating a new project note or when running `/second-brain link`.

```
agent("
  Vault linker for: vault/30-Projects/<Project>.md in vault 'The Forge'
  
  Read the note, extract key concepts.
  Search: obsidian 'The Forge' search:context query='<concept>' (run 3 searches)
  Read top 5 candidates.
  Build connection plan.
  Execute: add [[wikilinks]] to target and reciprocal links to candidates.
  Report all links added.
")
```

---

## Composing Multiple Agents

Run agents sequentially when each depends on the previous result:

```
# Step 1: Scout gathers sources
scout_results = agent("Research scout: <topic>, gaps: <list>...")

# Step 2: Synthesis integrates findings
agent("Synthesis: integrate these findings into wiki: " + scout_results)

# Step 3: Capture key insight
agent("Capture note: 'Insight - <topic> revealed X'...")
```

Do NOT run agents in parallel -- the `agent` tool is sequential and each call should complete before the next.

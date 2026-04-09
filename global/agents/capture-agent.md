# Capture Agent

**Purpose:** Auto-capture a noteworthy insight, decision, or lesson to the Obsidian vault "The Forge". Searches for duplicates before creating.

**When to use:** Pass this prompt to the `agent` tool after completing a significant task, making a design decision, or encountering a debugging breakthrough worth preserving.

**Model:** Task agent (haiku -- cheap, fast, no complex reasoning needed)

---

## Prompt Template

Copy and fill in the `<placeholders>`, then pass to the `agent` tool:

```
You are a note capture agent for the Obsidian vault named "The Forge".

Task: Capture a note titled "<Descriptive Title>" to the vault.

Step 1 -- Search for duplicates:
  Run: obsidian "The Forge" search query="<title keywords>"
  If a very similar note already exists, report "Skipped: already exists at <path>" and stop.

Step 2 -- Create the note:
  If no duplicate found, create a new note at: 00-Inbox/<Descriptive Title>.md

  Use this exact content:
  ---
  created: <YYYY-MM-DD>
  updated: <YYYY-MM-DD>
  tags:
    - fleeting
  source-project: <project name, or omit if not project-specific>
  ---

  ## Summary
  <2-4 sentences summarizing what was learned or decided>

  ## Context
  <1-2 sentences: what project, conversation, or situation this came from>

  ## Related
  <[[wikilink]] to a relevant project or area note, or omit if none>

Step 3 -- Report:
  "Captured: 00-Inbox/<Title>.md" or "Skipped: already exists at <path>"
```

---

## Example Invocation

```
agent("
  You are a note capture agent for the Obsidian vault 'The Forge'.
  Capture: 'Decision - GraphQL Federation over REST for service mesh'
  
  Step 1: Run obsidian 'The Forge' search query='GraphQL Federation decision'
  If similar note exists, report skip.
  
  Step 2: Create 00-Inbox/Decision - GraphQL Federation over REST for Service Mesh.md
  ---
  created: 2026-04-09
  updated: 2026-04-09
  tags: [fleeting]
  source-project: api-migration
  ---
  
  ## Summary
  Chose GraphQL Federation over a REST gateway for the service mesh. Federation allows independent subgraph evolution without a central schema owner, which fits the team structure better.
  
  ## Context
  API architecture review for the Windstream project. Comparing federation vs REST gateway.
  
  ## Related
  [[API Migration Project]]
  
  Report result.
")
```

---

## Notes

- Keep the Summary to 2-4 sentences -- the point is capture, not synthesis
- The Related section should use wikilinks to existing vault notes -- only add if you know the note exists
- If the vault name is different in a project, adjust the `obsidian "<vault-name>"` command
- This agent does not need to read or analyze complex content -- just write the note

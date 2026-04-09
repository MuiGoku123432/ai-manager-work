---
name: second-brain
description: Use when someone asks to capture a note, find something in Obsidian, organize the inbox, check project status, do a vault review, create a daily or weekly note, discover links, build a MOC, process inbox items, or audit tags. Also use when asked to search the vault, add a task to Obsidian, or pull info from notes.
argument-hint: [command] [arguments]
model: sonnet
---

## What This Skill Does

Manages Connor's Obsidian vault ("The Mind") through the obsidian CLI. Handles capture, search, organization, project tracking, periodic notes, and vault maintenance.

## Available Commands

| Command | Description |
|---------|-------------|
| `capture <title>` | Create a new note in 00-Inbox |
| `find <query>` | Search vault with context and tag suggestions |
| `organize` | Process and classify inbox items |
| `project status [name]` | Show project health metrics |
| `project map` | Visualize project dependencies |
| `review` | Calculate vault health score |
| `daily` | Create or load today's daily note |
| `weekly` | Compile weekly synthesis from daily notes |
| `link <note>` | Discover and suggest connections for a note |
| `moc [topic]` | Build or update Maps of Content |
| `inbox` | Classify and process all unprocessed inbox items |
| `tag [query]` | Audit and fix tag inconsistencies |

If no command is specified, infer the best action from context.

## How to Execute

All commands use the `obsidian` CLI via Bash. The available CLI operations are:

- `obsidian search query="<query>"` -- keyword search
- `obsidian search:context query="<query>"` -- contextual search
- `obsidian files folder="<path>"` -- list files in folder
- `obsidian read path="<path>"` -- read note content
- `obsidian create path="<path>" content="<text>"` -- create or overwrite note
- `obsidian create path="<path>" template="<name>"` -- create from template
- `obsidian move path="<old>" to="<new>"` -- move or rename note
- `obsidian tags counts sort=count` -- list all tags with counts

For detailed command sequences per workflow, see [references/workflow-tool-sequences.md](references/workflow-tool-sequences.md).

## Key Conventions

- Vault name: "The Mind" | Vault path: `/Users/cfanch06/Obsidian/The Mind/`
- Vault folder structure: `00-Inbox`, `10-Faith`, `20-Areas`, `30-Projects`, `40-Resources`, `50-Daily`, `60-Templates`, `70-Atlas`, `80-Lab`
- `80-Lab/` is for wild ideas, random thoughts, and deep research -- not inbox captures. Index note: `80-Lab/Lab Index.md`
- All notes get frontmatter: `created`, `updated`, `tags` at minimum
- Projects add: `status`, `area`, `start-date`, `target-date`
- Use `[[wikilinks]]` for internal links
- Daily notes: `50-Daily/YYYY-MM-DD.md`
- Weekly notes: `50-Daily/YYYY-W##.md`
- MOCs: `70-Atlas/MOC - <Topic>.md`

For full conventions, see [references/vault-conventions.md](references/vault-conventions.md).

## Workflow Execution Pattern

Every workflow follows the same pattern:
1. **Gather** -- run parallel searches/reads to build context
2. **Analyze** -- classify, score, or evaluate what was found
3. **Report** -- present findings as a table or structured summary
4. **Execute** -- only after user confirms, make the changes

Never skip step 4 confirmation for destructive operations (moves, overwrites, bulk edits).

## Task Management in Obsidian

To create tasks for Connor in Obsidian:
1. Find or create the relevant project note in `30-Projects/`
2. Add tasks under a `## Tasks` section using `- [ ] task description`
3. If the task has a deadline, append `(due: YYYY-MM-DD)`
4. For standalone tasks not tied to a project, add them to today's daily note

## Reference Files

- [vault-conventions.md](references/vault-conventions.md) -- folder structure, naming, frontmatter, tags
- [project-tracking-framework.md](references/project-tracking-framework.md) -- project lifecycle, health metrics
- [zettelkasten-patterns.md](references/zettelkasten-patterns.md) -- note types, progressive summarization
- [review-checklists.md](references/review-checklists.md) -- vault health scoring, review cycles
- [workflow-tool-sequences.md](references/workflow-tool-sequences.md) -- exact CLI sequences per workflow

## Notes

- Always check for duplicates before creating notes (search first)
- Present a confirmation plan before bulk operations
- When organizing, classify notes by type before proposing moves
- If a template fails, fall back to manual creation with proper frontmatter
- The vault name is "The Mind"

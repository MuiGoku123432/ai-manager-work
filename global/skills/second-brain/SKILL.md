# Second Brain

Manages Connor's Obsidian vault "The Forge". Handles note capture, search, organization, project tracking, periodic notes, and vault maintenance.

Works from any project -- uses the obsidian CLI with the vault name so the vault doesn't need to be in the current directory. When invoked from the W2 engineering repo, Crush native file tools can also access notes directly at `vault/`.

## Available Commands

| Command | Description |
|---------|-------------|
| `capture <title>` | Create a new note in vault/00-Inbox |
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

**Vault name:** "The Forge" | **CLI access:** `obsidian "The Forge" <command>`

Use the obsidian CLI as the primary access method -- it works from any project directory:
```bash
obsidian "The Forge" search query="<query>"         # semantic keyword search
obsidian "The Forge" search:context query="<q>"     # contextual search
obsidian "The Forge" files folder="<path>"          # list folder contents
obsidian "The Forge" tags counts sort=count         # tag audit
obsidian "The Forge" move path="<old>" to="<new>"   # rename (updates wikilinks)
obsidian "The Forge" read path="<path>"             # read a note
obsidian "The Forge" create path="<path>" content="<text>" --overwrite
```

**When in the W2 engineering repo**, Crush native file tools also work on `vault/` directly (faster for simple reads/writes):
```bash
view vault/<path>          # read a note
write vault/<path>         # write a note
edit vault/<path>          # targeted edit
glob vault/**/*.md         # list notes
grep <pattern> vault/      # search content
```

**Warning:** `obsidian "The Forge" create` without `--overwrite` creates a numbered duplicate. Always use `--overwrite` for existing notes, or use the native file tools for updates.

For detailed command sequences per workflow, see [references/workflow-tool-sequences.md](references/workflow-tool-sequences.md).

## Key Conventions

- Vault name: "The Forge"
- Vault folders: `00-Inbox`, `20-Areas`, `30-Projects`, `40-Resources`, `50-Daily`, `60-Templates`, `70-Atlas`, `80-Lab`
- `80-Lab/` is for wild ideas and deep research -- not inbox captures. Index note: `80-Lab/Lab Index.md`
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

To create tasks in the vault:
1. Find or create the relevant project note in `30-Projects/`
2. Add tasks under a `## Tasks` section using `- [ ] task description`
3. If the task has a deadline, append `(due: YYYY-MM-DD)`
4. For standalone tasks not tied to a project, add them to today's daily note

## Reference Files

Load on demand -- do NOT load all at startup:
- [vault-conventions.md](references/vault-conventions.md) -- folder structure, naming, frontmatter, tags
- [project-tracking-framework.md](references/project-tracking-framework.md) -- project lifecycle, health metrics
- [zettelkasten-patterns.md](references/zettelkasten-patterns.md) -- note types, progressive summarization
- [review-checklists.md](references/review-checklists.md) -- vault health scoring, review cycles
- [workflow-tool-sequences.md](references/workflow-tool-sequences.md) -- exact tool sequences per workflow

## Notes

- Always check for duplicates before creating notes (search or glob first)
- Present a confirmation plan before bulk operations
- When organizing, classify notes by type before proposing moves
- Vault contents are gitignored -- never assume git tracks note changes

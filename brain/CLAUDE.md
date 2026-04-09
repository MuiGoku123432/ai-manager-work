# Brain (Second Brain)

Obsidian vault management domain for "The Mind" -- Connor's personal knowledge base. Handles note capture, search, organization, project tracking, periodic notes, and vault maintenance.

## Vault

- **Name:** The Mind
- **Path:** `/Users/cfanch06/Obsidian/The Mind/`
- **Access:** via the `obsidian` CLI binary (not an MCP server -- configured as a plugin in `.claude/settings.json`)

## Folder Structure

| Folder | Purpose |
|--------|---------|
| `00-Inbox/` | Capture landing zone -- unprocessed notes |
| `10-Faith/` | Prayer journal, discipleship notes, scripture |
| `20-Areas/` | Ongoing life areas (career, faith, finances, relationships, health, learning) |
| `30-Projects/` | Active projects with phases, tasks, and target dates |
| `40-Resources/` | Reference material, book notes, how-tos |
| `50-Daily/` | Daily and weekly notes |
| `60-Templates/` | Note templates |
| `70-Atlas/` | MOCs, Home note, Vault Dashboard |
| `80-Lab/` | Wild ideas, random thoughts, deep research dives |

## Prerequisites

The `obsidian` CLI binary must be on PATH. Verify with `which obsidian`.

No MCP servers. All vault operations go through the CLI:
```bash
obsidian search query="<query>"
obsidian search:context query="<query>"
obsidian files folder="<path>"
obsidian read path="<path>"
obsidian create path="<path>" content="<text>" --overwrite
obsidian create path="<path>" content="<text>" --append
obsidian move path="<old>" to="<new>"
obsidian frontmatter "<path>" --edit --key "<key>" --value "<value>"
obsidian tags counts sort=count
```

**Important:** Always use `--overwrite` when updating existing notes via `obsidian create`. Without it, the CLI creates a duplicate with a number suffix. For targeted field changes, use `obsidian frontmatter` or edit the file directly at the vault path.

## Available Skill

### `/second-brain`

12-workflow vault manager:

| Command | Purpose |
|---------|---------|
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

## Usage Guidance

- **Interactive use**: Run `/second-brain` or `/second-brain <command>` for guided vault operations
- **No agent team**: This domain uses the skill directly -- no lead/specialist agents. The skill handles all workflows.
- **Direct vault edits**: For complex content changes, prefer editing at `/Users/cfanch06/Obsidian/The Mind/<path>` using Read + Edit tools rather than the obsidian CLI create command

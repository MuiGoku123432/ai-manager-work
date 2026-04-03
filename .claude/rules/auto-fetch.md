# Auto-Fetch from Obsidian

When a conversation topic might have relevant context in Connor's Obsidian vault ("The Mind"), proactively search the vault and pull in useful notes. Do this early in the conversation -- before making recommendations or plans -- so your answers are grounded in existing knowledge.

## When to Fetch

Search the vault when:

- Connor mentions a project by name (check `30-Projects/` for project notes)
- A topic comes up that likely has prior research or decisions (search by keywords)
- You're about to make a recommendation and want to check if prior decisions exist
- A conversation references something from a past session that might have been captured
- Connor asks about priorities, goals, or plans (check `20-Areas/` and `30-Projects/`)
- A trip, event, or deadline is discussed (check for existing planning notes)
- Spiritual, faith, or prayer topics arise (check `10-Faith/`)

## When NOT to Fetch

- Trivial or purely code-focused conversations where vault context won't help
- When you already have the information from context files (`context/me.md`, `context/work.md`, etc.)
- When Connor explicitly says he doesn't need vault context

## How to Fetch

Run these obsidian CLI commands directly (no subagent needed -- fetching is fast and should inform the current response):

**Quick keyword search:**
```bash
obsidian search query="<relevant keywords>"
```

**Contextual search (finds related notes even without exact keyword match):**
```bash
obsidian search:context query="<topic or question>"
```

**Read a specific note when you find a match:**
```bash
obsidian read path="<note-path>"
```

**Check a project folder:**
```bash
obsidian files folder="30-Projects"
```

Run searches in parallel when checking multiple topics.

## How to Use Fetched Context

- Summarize what you found briefly: "I found a note on this from [date] -- here's what you decided..."
- Flag if current discussion contradicts a prior decision
- Reference vault notes with `[[wikilinks]]` when relevant
- If a note is stale or outdated, suggest updating it
- Don't dump raw note contents -- synthesize into your response

## Priority Folders

| Folder | When to Check |
|--------|--------------|
| `30-Projects/` | Any project name is mentioned |
| `20-Areas/` | Ongoing life areas (career, health, finances, faith) |
| `10-Faith/` | Spiritual topics, prayer, scripture |
| `40-Resources/` | Research, book notes, reference material |
| `50-Daily/` | Recent daily/weekly notes for current context |
| `70-Atlas/` | MOCs for broad topic overviews |
| `00-Inbox/` | Recent captures that may not be organized yet |

# Recursive Research

Karpathy-style AutoResearch ratchet loop for deep autonomous research on any topic. Runs iterative cycles using WebSearch and WebFetch, builds a living interlinked wiki knowledge base, and commits only improvements (git-based ratchet). Runs in a single session or unattended overnight via `tools/research-loop.sh`.

Can be invoked standalone or delegated to by the `project-initializer` when a project topic needs external research before vetting and planning.

## Prerequisites

- `WebSearch` and `WebFetch` are native Claude Code tools -- no MCP servers required
- `WebFetch` has a domain allowlist in `settings.local.json`. The skill works without expanding it (falls back to search snippets), but richer research benefits from adding: `en.wikipedia.org`, `arxiv.org`, `stackoverflow.com`, `developer.mozilla.org`
- `obsidian` CLI must be on PATH (for `export` subcommand only)
- The repo must be a git repository (for ratchet commits)

## Available Skill

### `/recursive-research`

| Command | Purpose |
|---------|---------|
| `start <topic>` | Initialize research project, seed wiki, run first iteration |
| `iterate [slug]` | Run one improvement cycle: search -> verify -> synthesize -> score -> ratchet |
| `synthesize [slug]` | Produce polished synthesis report from current wiki state |
| `status [slug]` | Show scores, gaps, iteration history; list all projects if no arg |
| `export [slug]` | Export synthesis to Obsidian `80-Lab/` with frontmatter |

## Agent Team

| Agent | Focus | Workflows | Recommended Model |
|-------|-------|-----------|------------------|
| **research-lead** | Lead orchestrator -- manages iterations, computes scores, makes ratchet commit decisions | start, iterate, status | sonnet |
| **search-agent** | Web search -- parallel WebSearch queries, WebFetch with graceful domain-block fallback | iterate (Phase 2-3) | haiku |
| **synthesis-agent** | Wiki authoring -- writes/updates pages, resolves conflicts, produces reports, self-critiques | iterate (Phase 4), synthesize | sonnet |

## Usage Guidance

- **Single session**: Run `/recursive-research start <topic>` for a guided first run, then `/recursive-research iterate` repeatedly
- **Unattended loop**: `tmux new-session -d -s research './tools/research-loop.sh <slug> 15'` -- runs up to 15 iterations, commits only improvements, auto-synthesizes when done
- **From project-init**: When `/project-init research <topic>` finds no vault prior art, it will offer to delegate to `/recursive-research start <topic>` for external research before vetting
- **Review progress**: `git log --oneline --grep="research("` shows only committed iterations

## Project Output Structure

Each research topic creates a self-contained project:
```
projects/<topic-slug>/
  program.md     -- edit this to guide the research strategy
  wiki/          -- living knowledge base (index.md + subtopic pages)
  reports/       -- timestamped synthesis reports
  sources/       -- raw fetch summaries
  results.md     -- iteration log and scores
```

## Decision Log Integration

Significant research completions (when `export` is run) are logged to `decisions/log.md`:
```
[YYYY-MM-DD] RESEARCH: Completed "<topic>" -- N iterations, N sources, XX% complete | OUTPUT: 80-Lab/<topic> - Research Synthesis.md
```

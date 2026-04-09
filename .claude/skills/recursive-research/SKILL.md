---
name: recursive-research
description: Use when someone wants to do deep autonomous research on a topic, run iterative research cycles, build a research knowledge base, synthesize findings from multiple sources, or export research results to Obsidian. Triggers on "research deeply", "auto-research", "recursive research", "build a knowledge base on", "deep research", "should I build X" (when external knowledge is needed).
argument-hint: [command] [topic or project-slug]
model: sonnet
---

## What This Skill Does

Karpathy-style AutoResearch ratchet loop. Runs iterative research cycles using WebSearch and WebFetch, builds a living interlinked wiki knowledge base, and only commits improvements (ratchet pattern via git). Run one iteration at a time or unattended overnight via `tools/research-loop.sh`.

Designed to be invoked standalone OR delegated to by `/project-init` when a project topic needs external research before vetting and planning.

## Available Commands

| Command | Description |
|---------|-------------|
| `start <topic>` | Initialize research project, seed wiki, run first iteration |
| `iterate [project-slug]` | Run one improvement cycle: search -> verify -> synthesize -> score -> ratchet |
| `synthesize [project-slug]` | Produce polished synthesis report from current wiki state |
| `status [project-slug]` | Show scores, gaps, iteration history; list all projects if no arg |
| `export [project-slug]` | Export synthesis to Obsidian 80-Lab/ with proper frontmatter |

If no command specified, infer from context. If topic provided without a command, run `start`.

## Tools Available

- `WebSearch` -- keyword and query searches (no domain restrictions)
- `WebFetch` -- fetch full page content (domain allowlist applies; falls back to snippet on block)
- `obsidian` CLI -- for `export` subcommand only
- `Bash` -- for git operations and filesystem

**WebFetch fallback rule:** If a domain is blocked, log it as "source-N: snippet only (domain blocked)" in the wiki bibliography and use the WebSearch snippet. Never skip a source entirely -- snippets contain real signal.

**To expand the WebFetch allowlist:** Add domains to `allowedTools` in `~/.claude/settings.local.json`. Suggested additions for research: en.wikipedia.org, arxiv.org, stackoverflow.com, developer.mozilla.org.

## Project Structure (created by `start`)

```
projects/<topic-slug>/
  program.md     -- research strategy (edit to guide the loop)
  sources/       -- raw fetched content summaries
  wiki/          -- interlinked knowledge base
    index.md     -- overview, bibliography, subtopic links
    <subtopic>.md
  reports/       -- timestamped synthesis reports
  results.md     -- iteration log with scores
  README.md
```

## Workflow: `start <topic>`

**Phase 1 -- Setup:**
1. Slugify topic name (e.g., "Battery Chemistry" -> `battery-chemistry`)
2. Check if `projects/<slug>/` already exists -- if so, offer to resume with `iterate`
3. Create directory structure: `program.md` (from template), `sources/`, `wiki/`, `reports/`, `results.md`, `README.md`
4. Generate `program.md` using `references/program-template.md` -- populate research question, infer 5 sub-topics, set default termination criteria

**Phase 2 -- Initial Search (delegate to search-agent, haiku):**
"Run 5 WebSearch queries covering: overview, key concepts, recent developments, debates/limitations, key examples. Return structured findings with URLs and key claims per result."

**Phase 3 -- Seed Wiki (delegate to synthesis-agent, sonnet):**
"Create `wiki/index.md` with overview and links to 3-5 subtopic pages. Create each subtopic page with initial content from search results. Mark unknown areas with `[GAP: description]`. Follow wiki-conventions.md."

**Phase 4 -- Initial Score:**
Count sources, gaps, conflicts. Write iteration 1 row to `results.md`. Commit: `git add projects/<slug>/ && git commit -m "research(<slug>): initialize -- iteration 1, N sources, XX% complete"`

---

## Workflow: `iterate [project-slug]`

Core ratchet step. Run one improvement cycle.

**Phase 1 -- Load State:**
Read `program.md`, `results.md`, all `wiki/*.md`. Extract:
- All `[GAP: ...]` markers (prioritize by importance per program.md)
- All `[CONFLICT: ...]` markers
- All `[UNVERIFIED: ...]` markers
- Scores from last iteration

**Phase 2 -- Search (delegate to search-agent, haiku):**
"Fill knowledge gaps for '<topic>'. Gaps: [ranked list]. Run 3-5 targeted WebSearch queries. For each result: URL, key claims, which gap it addresses. Prioritize gaps by importance."

**Phase 3 -- Fetch and Verify:**
For top 5 URLs from Phase 2, attempt WebFetch. Log fetch status (fetched / snippet only / blocked) for bibliography.

Cross-verification: for each new claim, count independent source support. Mark `[UNVERIFIED]` if < 3.

**Phase 4 -- Synthesize (delegate to synthesis-agent, sonnet):**
"Update wiki with new findings. Fill gaps where possible (remove `[GAP]` only when substantively addressed). Add citations. Identify new conflicts. Create new subtopic pages if a topic has grown large enough. Self-critique clarity 1-10. Return: pages updated, gaps closed, conflicts found."

**Phase 5 -- Score:**
Load `references/scoring-rubric.md`. Compute:
- Source count delta
- Completeness delta (gap-free pages / expected sub-topics from program.md)
- Conflict delta (resolved vs new)
- Synthesis clarity
- Composite score

**Phase 6 -- Ratchet Decision:**
Commit if any threshold met:
- Net new verified sources >= 2
- Completeness increased >= 3%
- Net conflicts resolved >= 1

If commit: `git commit -m "research(<slug>): iteration N -- +X sources, completeness XX%->YY%, Z gaps remaining"`
If no commit: log reason to `results.md`. After 3 consecutive no-commits, suggest revising program.md.

**Phase 7 -- Termination Check:**
If completeness >= threshold from program.md OR iteration >= max: recommend `synthesize` and `export`.

Report:
```
## Iteration N Complete

| Metric | Previous | Current | Delta |
|--------|----------|---------|-------|
| Sources | N | N | +N |
| Completeness | XX% | YY% | +Z% |
| Conflicts | N | N | ±N |
| Composite | X.XX | Y.YY | +Z.ZZ |

Committed: Yes / No (<reason>)
Remaining gaps: N
Next: continue iterating / synthesize and export
```

---

## Workflow: `synthesize [project-slug]`

**Phase 1 -- Gather:**
Read all `wiki/*.md`, `results.md`, `program.md`.

**Phase 2 -- Generate Report (delegate to synthesis-agent, sonnet):**
Produce synthesis report structured as:
1. Executive Summary (3-5 sentences answering the research question)
2. Key Findings (numbered list, most important discoveries)
3. Detailed Analysis (by sub-topic, with inline citations `[source-N]`)
4. Conflicting Evidence (unresolved contradictions with analysis)
5. Remaining Gaps (what is still unknown)
6. Source Quality Assessment (confidence level, fetch coverage)
7. Bibliography (numbered list with URLs and domains)

Use only claims with 3+ source support unless flagged as `[UNVERIFIED]`.

**Phase 3 -- Save:**
Write to `reports/YYYY-MM-DD-synthesis.md`. Commit: `git commit -m "research(<slug>): synthesis report -- N sources, XX% complete"`

---

## Workflow: `status [project-slug]`

**If project-slug provided:**
Read `results.md` and all `wiki/*.md`. Report:
- Iteration count and date range
- Score dashboard with trend (last 3 iterations)
- Gap count and top 3 most important gaps
- Conflict count
- Recommendation: iterate more / synthesize / export

**If no argument:**
List all `projects/*/program.md` files. For each, read `results.md` and report a one-line status:
```
| Project | Iterations | Completeness | Gaps | Last Updated | Status |
|---------|-----------|-------------|------|--------------|--------|
```

---

## Workflow: `export [project-slug]`

**Phase 1 -- Pre-check:**
Verify `reports/` contains at least one synthesis report. If not, suggest `synthesize` first.

**Phase 2 -- Vault Search:**
`obsidian search:context query="<topic keywords>"` -- find related notes to wikilink.

**Phase 3 -- Format:**
Transform latest synthesis report for Obsidian with frontmatter:
```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - lab/research
  - topic/<slug>
status: complete
source-count: N
completeness: XX%
iterations: N
---
```

**Phase 4 -- Export:**
```bash
obsidian create path="80-Lab/<Topic> - Research Synthesis.md" content="<formatted>" --overwrite
obsidian create path="80-Lab/Lab Index.md" content="- [[80-Lab/<Topic> - Research Synthesis|<Topic>]] -- research synthesis, N sources" --append
```

---

## Unattended Loop Mode

For multi-iteration overnight runs, use `tools/research-loop.sh`:

```bash
# In tmux (survives terminal close)
tmux new-session -d -s research 'cd /path/to/ai-projects && ./tools/research-loop.sh <topic-slug> 15'

# Direct
./tools/research-loop.sh <topic-slug> [max-iterations] [interval-seconds]
```

## Reference Files

Load on demand:
- `references/scoring-rubric.md` -- metric definitions, normalization, ratchet thresholds
- `references/program-template.md` -- template for program.md strategy files
- `references/wiki-conventions.md` -- wiki page structure, markers, citation format

## Notes

- WebFetch domain restrictions are expected -- the skill degrades gracefully to snippets
- For fast-moving topics (AI, software), prioritize sources from 2024-2026
- The wiki compounds across sessions -- each `iterate` builds on prior state from disk
- `results.md` is the authoritative score history -- never delete rows
- The ratchet ensures git history is clean: `git log --oneline --grep="research("` shows only progress

# Recursive Research

Karpathy-style AutoResearch ratchet loop. Runs iterative research cycles using web fetch and search, builds a living interlinked wiki knowledge base, and only commits improvements (ratchet pattern via git). Run one iteration at a time or unattended overnight via `tools/research-loop.sh`.

Can be invoked standalone OR delegated to by `/project-init` when a project topic needs external research before vetting and planning.

## Available Commands

| Command | Description |
|---------|-------------|
| `start <topic>` | Initialize research project, seed wiki, run first iteration |
| `iterate [project-slug]` | Run one improvement cycle: search -> verify -> synthesize -> score -> ratchet |
| `synthesize [project-slug]` | Produce polished synthesis report from current wiki state |
| `status [project-slug]` | Show scores, gaps, iteration history; list all projects if no arg |
| `export [project-slug]` | Export synthesis to vault/80-Lab/ with proper frontmatter |

If no command specified, infer from context. If topic provided without a command, run `start`.

## Tools Available

- `fetch` -- HTTP requests for fetching web content
- Web search: use Crush's built-in search capability or `fetch` against a search API
- `bash` -- for git operations and filesystem
- Direct file tools -- for wiki authoring and reading

**Fetch fallback rule:** If a domain is blocked or unavailable, log it as "source-N: snippet only (unavailable)" in the wiki bibliography and use whatever snippet is available. Never skip a source entirely -- partial signal beats no signal.

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

**Phase 2 -- Initial Search:**
Use the `agent` tool to delegate: "Run 5 search queries covering: overview, key concepts, recent developments, debates/limitations, key examples. Return structured findings with URLs and key claims per result."

**Phase 3 -- Seed Wiki:**
Use the `agent` tool to delegate: "Create `wiki/index.md` with overview and links to 3-5 subtopic pages. Create each subtopic page with initial content from search results. Mark unknown areas with `[GAP: description]`. Follow wiki-conventions.md."

**Phase 4 -- Initial Score:**
Count sources, gaps, conflicts. Write iteration 1 row to `results.md`. Commit:
```bash
git add projects/<slug>/ && git commit -m "research(<slug>): initialize -- iteration 1, N sources, XX% complete"
```

---

## Workflow: `iterate [project-slug]`

Core ratchet step. Run one improvement cycle.

**Phase 1 -- Load State:**
Read `program.md`, `results.md`, all `wiki/*.md`. Extract:
- All `[GAP: ...]` markers (prioritize by importance per program.md)
- All `[CONFLICT: ...]` markers
- All `[UNVERIFIED: ...]` markers
- Scores from last iteration

**Phase 2 -- Search (delegate via `agent` tool):**
"Fill knowledge gaps for '<topic>'. Gaps: [ranked list]. Run 3-5 targeted searches. For each result: URL, key claims, which gap it addresses."

**Phase 3 -- Fetch and Verify:**
For top 5 URLs from Phase 2, attempt to fetch content. Log fetch status for bibliography.

Cross-verification: for each new claim, count independent source support. Mark `[UNVERIFIED]` if < 3.

**Phase 4 -- Synthesize (delegate via `agent` tool):**
"Update wiki with new findings. Fill gaps where possible. Add citations. Identify new conflicts. Create new subtopic pages if a topic has grown. Self-critique clarity 1-10. Return: pages updated, gaps closed, conflicts found."

**Phase 5 -- Score:**
Load `references/scoring-rubric.md`. Compute composite score from source count, completeness, conflicts, clarity.

**Phase 6 -- Ratchet Decision:**
Commit if any threshold met (see scoring-rubric.md). If commit:
```bash
git commit -m "research(<slug>): iteration N -- +X sources, completeness XX%->YY%, Z gaps remaining"
```
If no commit: log reason to `results.md`. After 3 consecutive no-commits, suggest revising program.md.

**Phase 7 -- Termination Check:**
If completeness >= threshold OR iteration >= max: recommend `synthesize` and `export`.

---

## Workflow: `synthesize [project-slug]`

Read all `wiki/*.md`, `results.md`, `program.md`. Produce structured report:
1. Executive Summary (3-5 sentences answering the research question)
2. Key Findings (numbered, most important discoveries)
3. Detailed Analysis (by sub-topic, inline citations)
4. Conflicting Evidence (unresolved contradictions)
5. Remaining Gaps
6. Source Quality Assessment
7. Bibliography (numbered, URLs)

Use only claims with 3+ source support unless flagged `[UNVERIFIED]`.

Write to `reports/YYYY-MM-DD-synthesis.md`. Commit.

---

## Workflow: `status [project-slug]`

**If project-slug provided:** Read `results.md` and wiki pages. Report score dashboard, gap count, recommendation.

**If no argument:** List all `projects/*/program.md`. Report one-line status per project.

---

## Workflow: `export [project-slug]`

1. Verify `reports/` has at least one synthesis report
2. Search vault for related notes to wikilink: `obsidian "The Forge" search:context query="<topic>"`
3. Format synthesis with frontmatter (`lab/research`, `topic/<slug>`, `status: complete`, etc.)
4. Export to vault: `obsidian "The Forge" create path="80-Lab/<Topic> - Research Synthesis.md" content="<formatted>" --overwrite`
5. Append entry to Lab Index: `obsidian "The Forge" read path="80-Lab/Lab Index.md"` then edit and overwrite
6. Log to `decisions/log.md`: `[YYYY-MM-DD] RESEARCH: Completed "<topic>" -- N iterations, N sources, XX% complete`

---

## Unattended Loop Mode

For multi-iteration overnight runs:

```bash
# In tmux (survives terminal close)
tmux new-session -d -s research 'cd /path/to/repo && ./tools/research-loop.sh <topic-slug> 15'

# Direct
./tools/research-loop.sh <topic-slug> [max-iterations] [interval-seconds]
```

## Reference Files

Load on demand:
- `references/scoring-rubric.md` -- metric definitions, normalization, ratchet thresholds
- `references/program-template.md` -- template for program.md strategy files
- `references/wiki-conventions.md` -- wiki page structure, markers, citation format

## Notes

- For fast-moving topics (AI, software), prioritize sources from 2024-2026
- The wiki compounds across sessions -- each `iterate` builds on prior state from disk
- `results.md` is the authoritative score history -- never delete rows
- The ratchet ensures git history is clean: `git log --oneline --grep="research("` shows only progress

# Scoring Rubric

Defines the metrics, weights, and ratchet thresholds used by `research-lead` to decide whether to commit each iteration.

---

## Metrics

| Metric | Weight | Measured By |
|--------|--------|-------------|
| Source Count | 15% | Total unique URLs cited across all wiki pages |
| Citation Quality | 25% | % of claims with 3+ independent source citations |
| Completeness | 30% | (wiki pages without `[GAP]` markers) / (expected sub-topics from program.md) |
| Conflict Resolution | 15% | `max(0, 1 - conflict_count / 10)` normalized to 0-1 |
| Synthesis Clarity | 15% | Self-assessed by synthesis-agent on 1-10 scale, normalized |

## Normalization

All metrics normalize to 0-1 before weighting.

```
source_count_norm    = min(1.0, source_count / 30)     # 30+ sources = full score
citation_quality     = verified_claims / total_claims   # already 0-1
completeness         = gap_free_pages / expected_pages  # already 0-1
conflict_resolution  = max(0, 1 - conflict_count / 10) # 10+ conflicts = 0
clarity_norm         = (synthesis_clarity - 1) / 9     # map 1-10 to 0-1
```

## Composite Score Formula

```
composite = (source_count_norm   * 0.15)
          + (citation_quality    * 0.25)
          + (completeness        * 0.30)
          + (conflict_resolution * 0.15)
          + (clarity_norm        * 0.15)
```

Score range: 0.00 to 1.00. Report as percentage (multiply by 100).

## Ratchet Commit Rules

Commit the iteration if ANY of these thresholds are met:

| Threshold | Value |
|-----------|-------|
| Net new verified sources | >= 2 |
| Completeness increase | >= 3 percentage points |
| Net conflicts resolved | >= 1 |
| Composite score increase | >= 0.02 (2 points) |

Do NOT commit if composite score decreased (regression). Log a warning and do not push.

After 3 consecutive no-commit iterations: stop and recommend revising `program.md` search strategy.

## Termination Criteria (Configurable in program.md)

| Criterion | Default |
|-----------|---------|
| Max iterations | 10 |
| Completeness threshold | 85% |
| Min sources per claim | 3 |

When either `completeness >= threshold` OR `iteration_count >= max_iterations`, recommend `synthesize` + `export`.

## Synthesis Clarity Rubric (for synthesis-agent self-assessment)

| Score | Meaning |
|-------|---------|
| 9-10 | Every claim cited, logical flow, no unsupported assertions, consistent terminology |
| 7-8 | Most claims cited, minor flow issues, 1-2 unsupported assertions |
| 5-6 | Significant claims cited but gaps in reasoning, inconsistent terminology |
| 3-4 | Many unsupported claims, disorganized sections |
| 1-2 | Mostly unsupported, incoherent, or contradictory |

Target score before committing synthesis: >= 7. Below 7, synthesis-agent should revise before research-lead scores.

## results.md Format

```markdown
# Research Progress: <Topic>

## Scores

| Iteration | Date | Sources | Citation Quality | Completeness | Conflicts | Clarity | Composite | Committed |
|-----------|------|---------|-----------------|-------------|-----------|---------|-----------|-----------|
| 1 | YYYY-MM-DD | N | XX% | XX% | N | X/10 | XX.X | Yes/No |

## Current Gaps
- [GAP: description]
- [GAP: description]

## Notes
- Iteration N: <reason for no-commit if applicable>
- Iteration N: <strategy adjustment>
```

# Vetting Criteria

Scoring rubric for the `vet` subcommand. Evaluate a project idea across 5 weighted criteria before committing to build it.

---

## Scoring Framework

Score each criterion from 0-10. Compute the weighted total (0-100).

| Criterion | Weight | Core Question |
|-----------|--------|---------------|
| Priority Alignment | 30% | Does this serve a current top-5 priority or Q2 goal? |
| Feasibility | 25% | Can Connor realistically execute this given current W2 load? |
| Tech Stack Fit | 15% | Does it use tools and languages already in the W2 stack? |
| Uniqueness | 15% | Does something similar already exist in the vault or repo? |
| Timeline Clarity | 15% | Is the scope clear enough to estimate when it's done? |

**Weighted Score Formula:**
```
Total = (Priority * 0.30) + (Feasibility * 0.25) + (Tech * 0.15) + (Uniqueness * 0.15) + (Timeline * 0.15)
```

---

## Criterion Scoring Guides

### Priority Alignment (0-10)

| Score | Meaning |
|-------|---------|
| 9-10 | Directly serves a top-2 priority or is explicitly in Q2 goals |
| 7-8 | Serves a top-5 priority or Q2 goal, clear connection |
| 5-6 | Loosely related to a priority, indirect benefit |
| 3-4 | Doesn't appear in priorities but is adjacent to active work |
| 1-2 | Off-priority, could wait for next quarter |
| 0 | No connection to any current priority or goal |

**How to assess:** Read `context/current-priorities.md` and `context/goals.md`. If it's not in the top 5 and not in the Q2 goals table, score no higher than 6.

### Feasibility (0-10)

| Score | Meaning |
|-------|---------|
| 9-10 | Highly doable: small scope, familiar territory, no blockers |
| 7-8 | Doable with focused effort, minor unknowns |
| 5-6 | Doable but requires new learning or has external dependencies |
| 3-4 | Stretched: large scope or competes with high-load W2 period |
| 1-2 | Unlikely to finish given current W2 commitments |
| 0 | Not feasible right now |

**Capacity thresholds (active vault projects):**
- 0-3 active projects: No capacity concern
- 4-5 active projects: Mild concern, flag it
- 6-8 active projects: Strong concern, deduct 2 points
- 9+ active projects: Critical concern, deduct 3-4 points

### Tech Stack Fit (0-10)

| Score | Meaning |
|-------|---------|
| 9-10 | Uses the exact same stack Connor works in daily |
| 7-8 | Familiar language with some new tooling |
| 5-6 | Adjacent stack (similar language, different framework) |
| 3-4 | New language but familiar problem domain |
| 1-2 | New language and new domain |
| 0 | Completely foreign stack with no overlap |

**How to assess:** Read `context/work.md` for current W2 tech stack.

### Uniqueness (0-10)

| Score | Meaning |
|-------|---------|
| 9-10 | Nothing similar exists anywhere in vault or repo |
| 7-8 | Related notes exist but no project or tool built |
| 5-6 | Similar project exists but with meaningfully different scope |
| 3-4 | Very similar project, would overlap significantly |
| 1-2 | Near-duplicate -- building this would create confusion |
| 0 | Exact duplicate -- should update existing instead |

### Timeline Clarity (0-10)

| Score | Meaning |
|-------|---------|
| 9-10 | Clear scope, estimable phases, obvious done state |
| 7-8 | Good scope with 1-2 unknowns, can still estimate |
| 5-6 | Rough scope, needs refinement |
| 3-4 | Vague scope, hard to estimate end state |
| 1-2 | No clear done state, could expand indefinitely |
| 0 | Scope undefined -- just an idea |

---

## Score Labels

| Score | Label | Recommendation |
|-------|-------|----------------|
| 80-100 | Green Light | Proceed to planning |
| 60-79 | Worth Considering | Proceed with caveats noted |
| 40-59 | Needs Refinement | Clarify scope or defer until capacity opens |
| 0-39 | Defer or Pass | Not the right time or not the right idea |

---

## Output Format

```
## Vet Report: <Project Name>

Score: XX/100 (Label)

| Criterion | Weight | Raw Score | Weighted | Notes |
|-----------|--------|-----------|----------|-------|
| Priority Alignment | 30% | X/10 | XX | ... |
| Feasibility | 25% | X/10 | XX | ... |
| Tech Stack Fit | 15% | X/10 | XX | ... |
| Uniqueness | 15% | X/10 | XX | ... |
| Timeline Clarity | 15% | X/10 | XX | ... |
| **Total** | | | **XX/100** | |

**Recommendation:** Green Light / Worth Considering / Needs Refinement / Defer

**Key Strengths:**
- ...

**Key Concerns:**
- ...

**Active project count:** X (capacity: normal / mild concern / critical)
**Closest existing project:** [[<name>]] or "none found"

**Decision needed:** Approve, refine, or defer?
```

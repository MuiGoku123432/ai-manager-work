# Agent Builder Reference

Complete reference for agent definition conventions in this project. Derived from the 12 agents across finances, real-estate, and calendar domains.

---

## Agent Frontmatter Schema

All fields are simple. Unlike skills, agents have a minimal frontmatter schema.

```yaml
---
name: agent-name          # kebab-case, matches filename (without .md)
description: One sentence  # Role label + scope + delegation behavior
tools: "*"                 # Always full tool access in this project
---
```

**Important:** Agents do NOT support a `model` field in their frontmatter. Model selection happens at spawn time -- the orchestrator or skill that launches an agent should pass the recommended model via the Agent tool's `model` parameter. Document the recommended model in the agent's section of the domain `CLAUDE.md` so the orchestrator knows what to use.

Model selection guidance:
- **haiku** -- structured CRUD, arithmetic, benchmark lookups, batch processing, templated execution
- **sonnet** -- conditional orchestration, multi-step analysis, probabilistic interpretation, delegation decisions
- **opus** -- open-ended research synthesis, creative planning, deeply ambiguous trade-offs

| Field | Required | Convention |
|-------|----------|-----------|
| `name` | Yes | Kebab-case. Must match the filename exactly (e.g., file `budget-analyst.md` → `name: budget-analyst`) |
| `description` | Yes | One sentence. Start with a role label ("Lead financial advisor", "Specialist for..."). Include what it does and how it delegates/receives. |
| `tools` | Yes | Always `"*"` -- full tool access. Do not restrict. |

**Description patterns:**

Lead agent:
```
Lead [domain] agent -- [primary function] and delegates to specialist agents for [deeper work].
```

Specialist agent:
```
Specialist for [focused area] -- [what it does] when delegated from [lead agent name].
```

---

## Canonical Agent Template

```markdown
---
name: <agent-name>
description: <Lead/Specialist role> -- <scope and delegation behavior>
tools: "*"
---

You are [role description] with [expertise qualifier]. You have access to [data sources]. Your role is to [primary responsibilities].

## Disclaimer

> **Disclaimer**: [Domain-appropriate disclaimer. Required for finance, real estate, legal, health domains. Omit for pure automation agents like calendar.]

## Communication Style

- Lead with the most impactful finding
- Use specific [dollars/numbers/dates] -- never vague estimates
- Pair every problem with a concrete next step
- Prioritize recommendations by [estimated impact metric] (highest first)
- Use plain language; define jargon when unavoidable

## [Tool Output Note -- if MCP tools return formatted markdown]

[Tool family] tools return pre-formatted markdown. Do NOT write Python or Bash to parse results or perform calculations. All [computation type] must go through [tool family] tools, not manual scripts.

## Assigned Workflows

### Workflow 1: [Name] (`trigger`)

**Phase 1 -- Gather (parallel):**
1. `tool_name` -- description
2. `tool_name` with `param: "value"` -- description

**Phase 2 -- Conditional drill-downs:**
- If [condition]: `tool_name` for [reason]
- If [condition]: `tool_name` for [reason]

**Phase 3 -- Analyze:**
Load `references/<file>.md`. Compute: [metric 1], [metric 2].

[Scoring rubric if applicable:]
| Component | Weight |
|-----------|--------|
| [metric] | XX% |

**Phase 4 -- Report:**
Present: [what to show and in what format]

### Workflow 2: [Name] (`trigger`)

[Same phased structure]

## Delegation Guidance

[Lead agents only. Omit for specialists.]

After completing your analysis, recommend specialist agents:

- **specialist-name**: When [specific measurable condition]
- **specialist-name**: When [specific measurable condition]

## Reference Files

Load on demand -- do NOT load all at startup:
- `references/<file>.md` -- [what it contains]
- `references/<file>.md` -- [what it contains]

## Standard Report Format

1. **Executive Summary** (2-4 sentences) -- most important finding and implication
2. **Key Metrics** -- [4-8 metrics with benchmarks and status indicators]
3. **Detailed Findings** -- by topic area with supporting data
4. **Action Items / Delegation Recommendations** -- ordered by estimated impact
5. **Next Steps** -- when to re-run, missing data, related workflows

## Error Handling

- If a tool call fails, note the failure and continue with available data
- If no data for a period, expand the date range before concluding unavailable
- If [domain-specific failure mode], [graceful fallback behavior]
```

---

## Good vs Bad Patterns

### Workflows

**Bad:** Vague instructions
```
Analyze the financial data and provide insights about the user's budget.
```

**Good:** Explicit phased execution with exact tool calls
```
**Phase 1 -- Gather (parallel):**
1. `cashflow_getCashflowSummary` -- income vs expenses current month
2. `budget_getVarianceSummary` -- budget adherence overview
3. `spending_getByCategoryMonth` with `topN: 10` -- top spending categories

**Phase 2 -- Conditional:**
- If savings rate < 20%: `cashflow_getCashflowByCategory`
- If budget variance > 15%: `budgets_getBudgetVariance`
```

---

### Reference Files

**Bad:** Load everything upfront
```
Load references/financial-ratios-benchmarks.md, references/tax-planning-strategies.md,
references/investment-allocation-frameworks.md before starting.
```

**Good:** Lazy load within the relevant phase
```
**Phase 3 -- Analyze:**
Load `references/financial-ratios-benchmarks.md`. Calculate savings rate, DTI...
```

---

### Delegation

**Bad:** Vague condition
```
If the user needs more analysis, delegate to a specialist.
```

**Good:** Specific measurable condition
```
- **cashflow-manager**: When savings rate < 20% or month-over-month cash flow is negative
- **debt-tax-advisor**: When DTI > 36% or tax-advantaged accounts are underutilized
```

---

### Error Handling

**Bad:** No error handling
```
[No mention of what to do when tools fail]
```

**Good:** Graceful degradation
```
- If an MCP tool call fails, note the failure and continue with available data
- If no data for a period, expand the date range before concluding unavailable
- If only core tools available, adapt workflows using available data
```

---

## Existing Agents Reference

| Agent | Domain | Type | File |
|-------|--------|------|------|
| financial-reviewer | finances | Lead | `finances/.claude/agents/financial-reviewer.md` |
| budget-analyst | finances | Specialist | `finances/.claude/agents/budget-analyst.md` |
| wealth-strategist | finances | Specialist | `finances/.claude/agents/wealth-strategist.md` |
| cashflow-manager | finances | Specialist | `finances/.claude/agents/cashflow-manager.md` |
| debt-tax-advisor | finances | Specialist | `finances/.claude/agents/debt-tax-advisor.md` |
| property-scout | real-estate | Lead | `real-estate/.claude/agents/property-scout.md` |
| market-analyst | real-estate | Specialist | `real-estate/.claude/agents/market-analyst.md` |
| investment-analyst | real-estate | Specialist | `real-estate/.claude/agents/investment-analyst.md` |
| lending-advisor | real-estate | Specialist | `real-estate/.claude/agents/lending-advisor.md` |
| risk-assessor | real-estate | Specialist | `real-estate/.claude/agents/risk-assessor.md` |
| schedule-manager | calendar | Lead | `calendar/.claude/agents/schedule-manager.md` |
| reminder-assistant | calendar | Specialist | `calendar/.claude/agents/reminder-assistant.md` |

Always read 1-2 existing agents from the same domain before building a new one. Use them as style references.

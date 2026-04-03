# Team Builder Reference

Hub-and-spoke team design patterns derived from the finance, real-estate, and calendar domains.

---

## The Hub-and-Spoke Pattern

Every domain team follows this structure:

```
User Request
      |
      v
 Lead Agent          <-- entry point, routes to specialists
  /   |   \
 S1   S2   S3        <-- specialists, each owns a workflow cluster
```

**Lead agent responsibilities:**
- Handles broad, entry-point workflows (health checks, overviews, search)
- Has full context across the domain
- Recommends (does not automatically spawn) specialist agents
- Has a "Delegation Guidance" section mapping specialists to trigger conditions

**Specialist agent responsibilities:**
- Owns a specific workflow cluster (e.g., debt & tax, risk & Monte Carlo)
- Goes deep in one area -- does not try to cover the whole domain
- No "Delegation Guidance" section
- May reference other agents as suggestions, not as delegation

---

## Team Sizing Guidelines

| Domain Complexity | Recommended Size |
|-------------------|-----------------|
| < 4 workflows | 1 agent (no team needed) |
| 4-8 workflows | 1 lead + 2 specialists |
| 8-14 workflows | 1 lead + 3-4 specialists |
| 14+ workflows | 1 lead + 4-5 specialists (max) |

Don't create specialists for the sake of it. A specialist that owns 1 workflow is probably better merged into another specialist.

---

## Workflow Assignment Rules

1. **No overlap** -- each workflow belongs to exactly one agent
2. **Lead gets overview workflows** -- broad assessments, entry-point queries, search/discovery
3. **Specialists get depth workflows** -- detailed analysis, specialized calculations, deep research
4. **Group by expertise, not volume** -- don't split one topic across two agents just to balance workload
5. **High-frequency workflows go to the lead** -- if users will hit it daily, the lead should own it

---

## Existing Team Reference

### Finance Team (5 agents)

| Agent | Type | Workflows |
|-------|------|-----------|
| financial-reviewer | Lead | health, review, goals |
| budget-analyst | Specialist | budget, spending, subscriptions |
| wealth-strategist | Specialist | networth, portfolio, retirement |
| cashflow-manager | Specialist | cashflow, emergency, savings |
| debt-tax-advisor | Specialist | debt, tax |

**Delegation triggers:**
- budget-analyst: poor budget adherence, spending pattern investigation
- wealth-strategist: net worth growth stalling, investment allocation review
- cashflow-manager: negative cash flow, inadequate emergency fund, declining savings rate
- debt-tax-advisor: DTI elevated, tax-advantaged accounts underutilized

### Real Estate Team (5 agents)

| Agent | Type | Workflows |
|-------|------|-----------|
| property-scout | Lead | search, analyze (overview), compare |
| market-analyst | Specialist | market, search (market context) |
| investment-analyst | Specialist | analyze (deep), househack, brrrr, flip, rental, portfolio |
| lending-advisor | Specialist | afford, analyze (financing section) |
| risk-assessor | Specialist | risk, tax |

**Delegation triggers:**
- market-analyst: needs market research before choosing property
- investment-analyst: property passed screening, needs financial modeling
- lending-advisor: financing guidance, affordability analysis, loan comparison
- risk-assessor: promising deal with uncertainty, Monte Carlo, tax implications

### Calendar Team (2 agents)

| Agent | Type | Workflows |
|-------|------|-----------|
| schedule-manager | Lead | today, week, upcoming, free, add event, add reminder, move, done |
| reminder-assistant | Specialist | bulk create, audit, list management, cross-domain sync |

**Delegation trigger:**
- reminder-assistant: bulk operations, reminder audits, syncing tasks from other domains

---

## Cross-Domain Integration Patterns

Teams frequently need to connect across domains. Document these connections in the relevant agent files.

**Common cross-domain patterns:**

| Source Domain | Target Domain | Pattern |
|--------------|--------------|---------|
| Any domain | calendar | "Suggest creating a reminder for this action item" |
| Any domain | brain (Obsidian) | "Suggest adding this to the relevant project note" |
| real-estate | finances | "Check financial health before analyzing affordability" |
| trip-planner | calendar | "Add trip dates and prep deadlines as calendar events" |
| trip-planner | brain | "Save trip plan as a project note in the vault" |

Cross-domain connections are always **suggestions**, never hard dependencies. An agent should be fully functional even if cross-domain tools are unavailable.

---

## Domain CLAUDE.md Agent Table Format

Every domain CLAUDE.md should have an Agent Team section formatted as:

```markdown
## Agent Team

Specialized agents for parallel delegation:

| Agent | Focus | Workflows |
|-------|-------|-----------|
| **lead-agent-name** | Lead agent -- [description]. Delegates to specialists for deeper analysis. | search, analyze, compare |
| **specialist-a** | [Focus area] specialist | workflow1, workflow2 |
| **specialist-b** | [Focus area] specialist | workflow3, workflow4 |

## Usage Guidance

- **For [common use case]**: Spawn `lead-agent-name` as the entry point
- **For [specialized use case]**: Spawn `specialist-a` directly
- **For parallel analysis**: Spawn `specialist-a` and `specialist-b` simultaneously
```

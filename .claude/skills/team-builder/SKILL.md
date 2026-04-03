---
name: team-builder
description: Use when creating a full agent team for a domain, designing a lead plus specialist agent structure, building out a new domain's agent layer, or auditing an existing team for coverage gaps or delegation issues.
---

## What This Skill Does

Guides creation of a coordinated agent team -- one lead agent and two to five specialists -- following the hub-and-spoke pattern used across this project's domains. Produces all agent files and updates the domain CLAUDE.md.

If you only need a single agent, use `/agent-builder` instead.

For team design patterns and hub-and-spoke conventions, see [reference.md](reference.md).

---

## Mode 1: Build a New Team

Run the **Discovery Interview** before writing any files.

### Discovery Interview

One round at a time. Wait for answers before proceeding.

**Round 1: Domain & Mission**
- What domain is this team for? (existing domain or new one)
- What is the team's core mission in one sentence?
- What tools, MCP servers, or APIs are available to this team?
- Does this domain already have a skill (e.g., `/financial-advisor`)? If yes, what does it cover?

**Round 2: Workflow Inventory**
- List every workflow the team needs to handle. Be exhaustive -- include edge cases.
- For each workflow: is it high-level overview or deep specialized analysis?
- Which workflows get triggered most often (day-to-day vs occasional)?
- Are there workflows that require expensive API calls or long execution?

**Round 3: Team Design**

Based on the workflow inventory, propose a team structure:

1. Group workflows by expertise area (not by volume)
2. Assign the broadest, most-entry-point workflow to the lead
3. Assign remaining workflow clusters to specialists (aim for 2-4 specialists)
4. Present the proposed assignment table:

| Agent | Role | Workflows |
|-------|------|-----------|
| `lead-agent` | Lead -- overview, entry point, delegates | #1, #2, #8 |
| `specialist-a` | Specialist -- [focus area] | #3, #4, #5 |
| `specialist-b` | Specialist -- [focus area] | #6, #7 |

Ask: "Does this breakdown make sense? Any workflows misassigned? Anything missing?"

**Round 4: Cross-Domain Integration**
- How does this team connect to other domains? (Does it need Obsidian notes? Financial data? Calendar tasks?)
- Should it recommend cross-domain agents when specific conditions arise?
- Are there any outputs from this team that should flow into another domain?

**Confirmation round:** Summarize the full team design and confirm before building.

---

### Build Phase

Execute in order -- do not parallelize file creation (each agent references the previous).

**Step 1: Create the domain structure** (if new domain)

```
mkdir -p <domain>/.claude/agents
mkdir -p <domain>/.claude/skills
touch <domain>/CLAUDE.md
touch <domain>/.mcp.json
touch <domain>/.claude/settings.json
```

**Step 2: Build the lead agent**

Using the agent-builder conventions ([reference](../agent-builder/reference.md)):
- Role: holistic scope, all entry-point workflows
- Include "Delegation Guidance" section mapping each specialist to trigger conditions
- Report format: includes "Delegation Recommendations" as a named section

**Step 3: Build each specialist agent**

For each specialist:
- Role: narrow expert scope, assigned workflow cluster
- No "Delegation Guidance" section
- May reference other agents inline (as suggestions, not as delegation)
- Include cross-domain integration notes where relevant

**Step 4: Wire up delegation**

Verify:
- Every specialist is referenced in the lead's "Delegation Guidance" section
- Every delegation condition is specific and measurable (not vague)
- No workflow is assigned to two agents

**Step 5: Update domain CLAUDE.md**

Add or update the Agent Team section:

```markdown
## Agent Team

| Agent | Focus | Workflows |
|-------|-------|-----------|
| **lead-agent** | Lead -- [description] | [list] |
| **specialist-a** | [focus] | [list] |
| **specialist-b** | [focus] | [list] |
```

**Step 6: Verify completeness**

Check against the workflow inventory from Round 2:
- Every workflow is assigned to exactly one agent
- No workflow is orphaned (unassigned)
- The lead can route any user request to the correct specialist

---

## Mode 2: Audit an Existing Team

Read all agent files in the domain first, then run through this checklist.

### Coverage Audit
- [ ] Every workflow in the domain skill is assigned to an agent
- [ ] No workflow is assigned to two agents
- [ ] No agent has an overloaded workflow count (more than 5-6 workflows per agent is a sign to split)

### Lead Agent Audit
- [ ] Lead has a "Delegation Guidance" section
- [ ] Every specialist is referenced in the lead's delegation section
- [ ] Every delegation condition is specific, not vague
- [ ] Lead's workflows are the entry-point / overview workflows

### Specialist Agent Audit
- [ ] Each specialist has a clearly defined focus area
- [ ] Specialists do not have a "Delegation Guidance" section
- [ ] Specialists reference cross-domain agents inline only (as suggestions)

### Cross-Domain Audit
- [ ] Relevant cross-domain connections are noted in affected agents
- [ ] No hard dependencies on other domains that could cause circular delegation

### Consistency Audit
- [ ] All agents follow the same frontmatter schema
- [ ] Communication style sections are consistent across agents
- [ ] Disclaimer sections are consistent across agents
- [ ] Report format structure is consistent across agents

---

## Important Notes

- Aim for 1 lead + 2-4 specialists. Fewer is better -- don't over-specialize.
- If a domain has fewer than 4 workflows total, a single agent (no team) may be sufficient.
- Always read the parent skill file before building the team -- the skill is the user-facing entry point, the team is the execution layer.
- For individual agent creation, use `/agent-builder`.
- For the full team design pattern reference and examples, see [reference.md](reference.md).

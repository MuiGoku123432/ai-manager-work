---
name: agent-builder
description: Use when creating a new agent, designing an agent definition, adding an agent to a domain, or auditing an existing agent file. Guides agent development following project conventions.
---

## What This Skill Does

Guides creation and auditing of agent definition files (`.claude/agents/<name>.md`) following the conventions established across this project's finance, real-estate, and calendar domains.

For the full agent schema, canonical template, and good/bad pattern examples, see [reference.md](reference.md).

---

## Mode 1: Build a New Agent

Run the **Discovery Interview** first. Do NOT write any files until all rounds are complete.

### Discovery Interview

Ask one round at a time using AskUserQuestion. Wait for answers before proceeding.

**Round 1: Role & Name**
- What does this agent do? Describe its primary responsibility in one sentence.
- What domain does it belong to? (finances, real-estate, calendar, brain, or a new domain)
- Is this a **lead agent** (entry point, holistic view, delegates to specialists) or a **specialist agent** (deep focus, owned workflows, receives delegation)?
- What should we call it? (Suggest kebab-case name based on the role)

**Round 2: Data Sources & Tools**
- What tools does it need? (MCP servers with specific tool names, CLI tools like osascript, Python scripts, web search)
- Does it have domain reference files to load? (List them -- these are loaded on demand, not at startup)
- What external APIs or data sources does it interact with?

**Round 3: Workflows**
- List every workflow this agent needs to handle. For each:
  - Workflow name and trigger keyword
  - Phase 1: what data does it gather? (Run in parallel where possible)
  - Phase 2: conditional drill-downs based on Phase 1 results
  - Phase 3: what does it analyze or compute?
  - Phase 4: what does it output/report?
- Are any workflows time-sensitive or expensive (paid API calls)?

**Round 4: Delegation & Boundaries**
- If lead: which specialist agents will this agent delegate to, and under what conditions?
- If specialist: which lead agent will delegate to this one? Any other agents it references?
- What should this agent explicitly NOT do? (Hard boundaries, anti-patterns to call out)
- What should it do when tools fail or data is unavailable?

**Confirmation round:** Summarize back:

```
## Agent Summary: [name]

**Role:** [lead or specialist] in [domain]
**Description:** [one sentence]

**Workflows:**
1. [name] (`trigger`) -- [what it does]
2. ...

**Data Sources:** [tools, MCP servers, APIs]
**Delegates to:** [agents, or "N/A"]
**Receives from:** [agents, or "N/A"]
**Hard boundaries:** [what it won't do]
```

Ask: "Does this capture it? Anything to add or change?" Only proceed once confirmed.

**Skipping rounds:** If the user provides enough context upfront, skip rounds already answered.

---

### Build Phase

**Step 1: Generate frontmatter**

```yaml
---
name: <kebab-case -- matches filename>
description: <Lead/Specialist role label> -- <one sentence describing scope and delegation behavior>
tools: "*"
---
```

Description pattern: `"<Role label> -- <primary function>. <delegation behavior if lead, or who delegates to this if specialist>."`

**Step 2: Write the agent body**

Follow this section order exactly:

1. **Role preamble** (1 paragraph) -- "You are [role] with [expertise qualifier]. You have access to [data sources]. Your role is to [primary responsibilities]."

2. **Disclaimer** (if domain involves financial, legal, or health decisions) -- blockquote, appears exactly once per report

3. **Communication style** -- 4-6 bullet points. Standard starting points:
   - Lead with the most impactful finding
   - Use specific numbers (dollars, percentages, dates)
   - Pair every problem with a concrete next step
   - Prioritize by estimated impact (highest first)
   - Use plain language; define jargon when unavoidable

4. **Tool output note** (if MCP tools return pre-formatted markdown) -- "Do NOT write Python or Bash to parse results. All computations go through [tool family], not manual scripts."

5. **Assigned workflows** -- one H3 section per workflow, named `### Workflow N: [Name] (\`trigger\`)`. Structure each as:
   - **Phase 1 -- Gather (parallel):** list parallel tool calls with exact function names and parameters
   - **Phase 2 -- Conditional drill-downs:** "If X: call Y", "If Z: call W"
   - **Phase 3 -- Analyze:** what to compute, which reference file to load
   - **Phase 4 -- Report:** output format specification

6. **Delegation guidance** (lead agents only) -- bullet list mapping specialist agents to trigger conditions:
   - `**specialist-name**`: When [specific condition that warrants deeper analysis]

7. **Reference files** -- list with lazy-load instruction: "Load on demand -- do NOT load all at startup"

8. **Standard report format** -- numbered sections: Executive Summary, Key Metrics/Data, Detailed Findings, Action Items / Delegation Recommendations, Next Steps

9. **Error handling** -- 3-5 bullets covering: tool call failures, missing data, graceful degradation

**Step 3: Create the file**

Write to `<domain>/.claude/agents/<name>.md`. If the domain doesn't exist, create the directory first.

**Step 4: Update domain CLAUDE.md**

Add the agent to the Agent Team table in the domain's CLAUDE.md:

```markdown
| **agent-name** | Role description | workflows it owns |
```

---

## Mode 2: Audit an Existing Agent

Read the agent file first, then run through this checklist:

### Frontmatter Audit
- [ ] `name` matches the filename (without `.md`)
- [ ] `description` starts with a role label
- [ ] `description` is one sentence and mentions delegation behavior
- [ ] `tools: "*"` is set

### Content Audit
- [ ] Role preamble establishes persona, data access, and primary responsibilities
- [ ] Workflows use phased execution (gather, conditional, analyze, report)
- [ ] Phase 1 calls are explicitly marked as parallel
- [ ] Tool calls use exact function names and parameters
- [ ] Conditional drill-downs have specific trigger conditions
- [ ] Reference files are listed with "Load on demand" instruction
- [ ] No reference files are loaded unconditionally at startup
- [ ] Report format is numbered and specific
- [ ] Error handling covers tool failures and missing data

### Delegation Audit
- [ ] Lead agents have a "Delegation Guidance" section
- [ ] Each delegation condition is specific (metric threshold, not vague)
- [ ] Specialist agents do not have a delegation section (they reference others inline only)
- [ ] No workflow overlap with sibling agents in the same domain

### Quality Audit
- [ ] Anti-patterns are called out explicitly where needed
- [ ] Instructions are actionable, not abstract
- [ ] A new agent of this type could follow these instructions without prior context

---

## Important Notes

- Always read an existing agent before auditing or extending it
- Check if a similar agent already exists before creating a new one
- For the full field reference, canonical template, and pattern examples, see [reference.md](reference.md)
- If building a full team (lead + multiple specialists), use `/team-builder` instead

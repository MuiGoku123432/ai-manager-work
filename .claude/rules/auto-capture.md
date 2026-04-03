# Auto-Capture to Obsidian

Whenever you encounter something worth preserving during a conversation, spawn a **background Agent (model: haiku)** to capture it to Connor's Obsidian vault ("The Mind"). This runs in the background -- do not block the main conversation.

## When to Capture

Spawn a capture subagent when you encounter any of these:

- A design decision with reasoning (why X was chosen over Y)
- A new fact about Connor's preferences, goals, or priorities
- Research findings or insights worth keeping
- A project milestone or status change
- A debugging breakthrough or lesson learned
- An action item that should be tracked in the vault

## When NOT to Capture

- Trivial code edits or formatting-only changes
- Information already saved to Claude Code memory this session
- Content clearly already in the vault (check before creating)
- Temporary debugging output with no lasting value
- Conversational back-and-forth with no net insight

**Frequency:** 1-3 notes per substantial conversation is typical. Zero is fine if nothing noteworthy happened. Don't over-capture.

## How to Capture

Spawn a background Agent with this exact task pattern:

```
Capture a note to Obsidian. Do the following:

1. Run: obsidian search query="<title keywords>"
   If a very similar note exists, skip creation and report "already exists: <path>".

2. If no duplicate, run:
   obsidian create path="00-Inbox/<Descriptive Title>.md" content="---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - fleeting
---

## Summary
<2-4 sentence summary of what was learned or decided>

## Context
<brief context: what project, conversation, or situation this came from>

## Related
<[[wikilink]] to relevant project or area note if applicable, otherwise omit>
"

3. Report: "Captured: 00-Inbox/<Title>.md" or "Skipped: already exists"
```

Replace `YYYY-MM-DD` with today's date. Title should be descriptive and use Title Case.

## Examples of Good Capture Titles

- `Decision - Agent Model Assignment Strategy 2026-04-03`
- `Insight - WAT Framework Applied to Multi-Domain Orchestration`
- `Action Item - Add Obsidian Bash Permission to Root Settings`
- `Pattern - Hub and Spoke Agent Team Design`

# ai-projects

Umbrella repository for AI-assisted life management across multiple domains. Each domain (finances, real estate, health, etc.) lives in its own top-level directory with scoped configuration, skills, agents, and MCP servers.

## Directory Structure

```
ai-projects/
├── CLAUDE.md              # This file — project-wide instructions
├── finances/
│   ├── CLAUDE.md          # Domain-specific context and instructions
│   └── .claude/           # Scoped MCP servers, skills, agents
├── real-estate/
│   ├── CLAUDE.md
│   └── .claude/
├── <new-domain>/
│   ├── CLAUDE.md
│   └── .claude/
└── ...
```

Each domain is a self-contained directory. Domain-level `CLAUDE.md` files provide context, goals, and instructions specific to that area. Claude Code automatically picks up the nearest `CLAUDE.md` when working within a subdirectory.

## Scoped Configuration

MCP servers, skills, and agents are configured per-domain inside each category's `.claude/` directory. This keeps tools relevant to their domain and avoids polluting other domains with unrelated configuration.

- **MCP servers** — declared in each domain's `.claude/settings.json` so they only activate when working in that domain
- **Skills** — domain-specific slash commands live in each domain's `.claude/skills/` directory
- **Agents** — custom agents scoped to a domain live in `.claude/agents/`

## Adding a New Domain

1. Create the top-level directory: `mkdir <domain-name>/`
2. Add a `CLAUDE.md` inside it describing the domain's purpose, key goals, and any conventions
3. Create `.claude/` if the domain needs scoped MCP servers, skills, or agents
4. Configure MCP servers in `.claude/settings.json` as needed
5. Add any domain-specific skills to `.claude/skills/`

## General Principles

- **Keep domains independent** — avoid cross-domain dependencies; each domain should be self-contained
- **Prefer composition over coupling** — share patterns, not code, between domains
- **Never commit secrets or credentials** — API keys, tokens, and passwords belong in environment variables or secure vaults, not in this repo
- **Domain-local CLAUDE.md is authoritative** — for domain-specific instructions, the local CLAUDE.md takes precedence over this root file

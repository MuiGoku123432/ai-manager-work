# Real Estate

Real estate investment analysis domain powered by RentCast and REICalc MCP servers.

## Prerequisites

### RentCast MCP Server
1. Clone `robcerda/rentcast-mcp-server` to your MCP directory
2. Export the API key in `~/.zshenv`:

```bash
export RENTCAST_API_KEY="<your-api-key>"
```

3. Update the path in `.mcp.json` if your clone location differs from the default

### REICalc MCP Server
- Runs via `uv run --directory /path/to/REICalc-MCP reicalc-mcp` — no API key required
- Requires Python and uv installed

Both MCP servers are configured in `.mcp.json` and activate automatically when working in this directory.

## Available Skill

### `/property-advisor`

Interactive real estate investment advisor with 12 subcommands:

| Command | Purpose |
|---------|---------|
| `search <zip/city>` | Find properties matching criteria in an area |
| `analyze <address>` | Full investment analysis of a specific property |
| `househack <address>` | House hacking strategy assessment |
| `brrrr <address>` | BRRRR strategy evaluation |
| `flip <address>` | Fix-and-flip profitability analysis |
| `rental <address>` | Rental income deep dive |
| `market <zip>` | Market overview and trends |
| `compare` | Compare up to 5 properties side-by-side |
| `afford` | Affordability and qualification check |
| `risk <address>` | Risk simulation and sensitivity analysis |
| `tax <address>` | Tax benefits and 1031 exchange analysis |
| `portfolio` | Portfolio growth projection |

Use without a subcommand for automatic routing based on your question.

## Agent Team

Specialized agents for parallel delegation on deeper analysis:

| Agent | Focus | Workflows |
|-------|-------|-----------|
| **property-scout** | Lead agent — search, screen, delegate to specialists | search, analyze (overview), compare |
| **market-analyst** | Area and market expert — stats, comps, trends | market, search (market context) |
| **investment-analyst** | Deal number cruncher — IRR, CoC, BRRRR, flip, house hack | analyze (deep), househack, brrrr, flip, rental, portfolio |
| **lending-advisor** | Financing specialist — mortgages, DTI, loan comparison | afford, analyze (financing section) |
| **risk-assessor** | Risk and tax specialist — Monte Carlo, sensitivity, 1031 | risk, tax |

## Usage Guidance

- **Interactive use**: Run `/property-advisor` or `/property-advisor <subcommand>` for guided analysis
- **Parallel delegation**: Use agents when you need multiple analyses simultaneously (e.g., spawn market-analyst and investment-analyst in parallel for a comprehensive property assessment)
- **Lead agent**: Start with `property-scout` for search and screening; it will recommend which specialist agents to consult for deeper analysis
- **Primary strategy**: House hacking is the primary investment strategy, but all strategies (buy & hold, BRRRR, fix & flip, etc.) are fully supported

## Deal Score (0-100)

Every analyzed property receives a composite Deal Score:

| Component | Weight | Criteria |
|-----------|--------|----------|
| Cash Flow | 25% | Monthly cash flow after all expenses |
| Cash-on-Cash Return | 20% | Annual CoC vs 8% benchmark |
| Market Strength | 15% | Rent growth, appreciation, vacancy rate |
| House Hack Offset | 15% | % of mortgage covered by rental income |
| Risk Profile | 15% | Monte Carlo downside, sensitivity |
| Financing Feasibility | 10% | DTI impact, qualification ease |

Score labels: 80-100 Strong Buy, 60-79 Worth Pursuing, 40-59 Marginal, 0-39 Pass

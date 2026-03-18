# Finances

Personal financial management domain powered by Monarch Money.

## Prerequisites

The Monarch Money MCP server requires credentials via environment variables. Export these in `~/.zshenv`:

```bash
export MONARCH_EMAIL="<your-email>"
export MONARCH_PASSWORD="<your-password>"
export MONARCH_MFA_SECRET="<your-mfa-secret>"
```

The MCP server is configured in `.claude/settings.json` and activates automatically when working in this directory.

## Available Skill

### `/financial-advisor`

Interactive financial advisor with 14 subcommands:

| Command | Purpose |
|---------|---------|
| `health` | Full financial health check with composite score |
| `review [monthly\|quarterly]` | Periodic review with period comparison |
| `budget` | Budget optimization with 50/30/20 analysis |
| `spending` | Spending pattern analysis and anomaly detection |
| `networth` | Net worth tracking and milestone projections |
| `cashflow` | Cash flow optimization and forecasting |
| `debt` | Debt payoff strategy (avalanche vs snowball) |
| `emergency` | Emergency fund adequacy assessment |
| `portfolio` | Investment portfolio review and rebalancing |
| `retirement` | Retirement readiness assessment |
| `tax` | Tax optimization suggestions |
| `subscriptions` | Subscription audit for recurring charges |
| `savings` | Savings rate analysis with 12-month trend |
| `goals [description]` | Financial goal tracking and projection |

Use without a subcommand for automatic routing based on your question.

## Agent Team

Specialized agents for parallel delegation on deeper analysis:

| Agent | Focus | Workflows |
|-------|-------|-----------|
| **financial-reviewer** | Lead advisor — holistic checks, periodic reviews, goal tracking | health, review, goals |
| **budget-analyst** | Budget optimization, spending patterns, subscription waste | budget, spending, subscriptions |
| **wealth-strategist** | Net worth, investment allocation, retirement projections | networth, portfolio, retirement |
| **cashflow-manager** | Cash flow health, emergency fund, savings momentum | cashflow, emergency, savings |
| **debt-tax-advisor** | Debt elimination strategy, tax efficiency | debt, tax |

## Usage Guidance

- **Interactive use**: Run `/financial-advisor` or `/financial-advisor <subcommand>` for a guided analysis
- **Parallel delegation**: Use agents when you need multiple analyses simultaneously (e.g., spawn budget-analyst and cashflow-manager in parallel for a comprehensive spending review)
- **Lead advisor**: Start with `financial-reviewer` for a holistic view; it will recommend which specialist agents to consult for deeper analysis

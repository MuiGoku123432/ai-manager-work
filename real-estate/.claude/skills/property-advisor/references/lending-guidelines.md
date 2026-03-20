# Lending Guidelines

## Loan Types Comparison

### FHA (Federal Housing Administration)
| Parameter | Requirement |
|-----------|------------|
| Down Payment | 3.5% (580+ score), 10% (500-579) |
| Credit Score | 500 minimum, 580 for 3.5% down |
| DTI Limit | 43% back-end (up to 50% with compensating factors) |
| Property Types | 1-4 units, owner-occupied |
| MIP (Mortgage Insurance) | 1.75% upfront + 0.55% annual (for >95% LTV) |
| MIP Duration | Life of loan (for <10% down), 11 years (for 10%+ down) |
| Loan Limits (2025) | $524,225 (1-unit) to $1,006,025 (4-unit), higher in HCOL |
| Self-Sufficiency | Required for 3-4 unit: 75% of rental income must cover mortgage |
| Best For | House hacking with minimal down payment |

### Conventional
| Parameter | Requirement |
|-----------|------------|
| Down Payment | 3-5% (primary), 15-20% (investment) |
| Credit Score | 620 minimum, 740+ for best rates |
| DTI Limit | 43-45% (up to 50% with strong compensating factors) |
| Property Types | 1-4 units |
| PMI | Required if <20% down, removable at 80% LTV |
| PMI Duration | Until 80% LTV (automatic removal at 78%) |
| Loan Limits (2025) | $806,500 (1-unit) conforming, higher for high-balance |
| Rental Income | 75% of market rent can be counted (with documentation) |
| Best For | Primary residence or investment with 20%+ down |

### VA (Veterans Affairs)
| Parameter | Requirement |
|-----------|------------|
| Down Payment | 0% |
| Credit Score | No VA minimum (lenders typically require 620+) |
| DTI Limit | 41% (higher with residual income) |
| Property Types | 1-4 units, owner-occupied |
| Funding Fee | 1.25-3.3% (waived for disability) |
| PMI | None |
| Loan Limits | No limit with full entitlement |
| Rental Income | Can count rental income from other units |
| Best For | Veterans house hacking — zero down, no PMI |

### DSCR (Debt Service Coverage Ratio) Loan
| Parameter | Requirement |
|-----------|------------|
| Down Payment | 20-25% |
| Credit Score | 660+ typically |
| DTI Limit | Not applicable — qualification based on property cash flow |
| DSCR Minimum | 1.15-1.25 |
| Property Types | 1-4 units, investment only (no owner-occupied) |
| Rates | 1-2% above conventional |
| Income Verification | None — property income based |
| Best For | Scaling portfolio without W-2 income constraints |

---

## DTI Calculation

### Front-End DTI (Housing Ratio)
```
Front-End DTI = Monthly Housing Costs / Gross Monthly Income x 100
```
Housing costs: PITI (principal, interest, taxes, insurance) + HOA + MIP/PMI

### Back-End DTI (Total Debt Ratio)
```
Back-End DTI = All Monthly Debt Payments / Gross Monthly Income x 100
```
All debts: housing costs + car payments + student loans + credit card minimums + personal loans + child support/alimony

### DTI Thresholds
| DTI | Assessment | Loan Eligibility |
|-----|-----------|-----------------|
| < 28% front / 36% back | Conservative | All loan types, best rates |
| < 31% front / 43% back | Standard | FHA, conventional with good credit |
| < 33% front / 50% back | Stretched | FHA with compensating factors only |
| > 50% back | Over-leveraged | Unlikely to qualify for any standard loan |

### Compensating Factors (Allow Higher DTI)
- Large cash reserves (6+ months PITI)
- Minimal payment shock (new payment within 20% of current)
- High credit score (740+)
- Significant residual income
- Long employment history (2+ years same employer)

---

## PITI Calculation

### Monthly Principal & Interest
```
P&I = Loan Amount × [r × (1 + r)^n] / [(1 + r)^n - 1]

where:
  r = annual rate / 12 (monthly rate)
  n = loan term in months (typically 360)
  Loan Amount = Purchase Price × (1 - Down Payment %)
```

### Full Monthly PITI
```
PITI = P&I + Property Tax/12 + Insurance/12 + MIP or PMI/12
```

### Component Estimates (when actuals unavailable)
| Component | How to estimate |
|-----------|----------------|
| Property Tax | Use county rate × assessed value / 12. Common rates: TX ~2.2%, NJ ~2.5%, CA ~1.1%, FL ~0.9%, national avg ~1.1% |
| Insurance | ~$1,200-$2,400/yr for SFH ($100-$200/mo), scale with property value |
| FHA MIP | 0.55% of loan balance / 12 (for >95% LTV, 30yr term) |
| PMI | 0.3-1.0% of loan balance / 12 (varies by LTV and credit score) |

### Quick PITI Reference (6.75% rate, 30yr, 3.5% FHA down, 2.2% tax, $1,800 ins)
| Purchase Price | P&I | Tax | Ins | MIP | Total PITI |
|---------------|-----|-----|-----|-----|------------|
| $250,000 | $1,564 | $458 | $150 | $111 | $2,283 |
| $300,000 | $1,877 | $550 | $150 | $133 | $2,710 |
| $350,000 | $2,190 | $642 | $150 | $155 | $3,137 |
| $400,000 | $2,503 | $733 | $150 | $177 | $3,563 |

---

## Reserve Requirements

| Property Type | Minimum Reserves |
|---------------|-----------------|
| Primary (1 unit) | 0-2 months PITI |
| Primary (2-4 units) | 2-6 months PITI |
| Investment (1-4 units) | 6 months PITI |
| Multiple investment properties | 6 months PITI per property (may be reduced) |

Reserves = liquid assets after closing (checking, savings, stocks, retirement at 60% value)

---

## Interest Rate Assumptions

When exact rates are unknown, use these for modeling:

| Loan Type | Assumption | Notes |
|-----------|-----------|-------|
| 30-year conventional (primary) | Current market rate | Check Freddie Mac PMMS |
| 30-year conventional (investment) | Market + 0.5-0.75% | Investment property premium |
| 30-year FHA | Market - 0.25% | Typically slightly below conventional |
| 15-year conventional | Market - 0.5-0.75% | Lower rate, higher payment |
| DSCR loan | Market + 1.0-2.0% | Premium for no-doc |
| Hard money | 10-14% | Short-term bridge financing |
| Seller financing | Negotiable | Often 6-9% |

Always model with rate +1% sensitivity to test downside.

---

## Creative Financing Strategies

### Seller Financing
- Seller acts as lender, buyer makes payments directly
- No bank qualification required
- Typically higher interest rate (6-9%)
- Often balloon payment in 3-5 years
- Use REICalc `analyze_seller_financing` for modeling

### Subject-To
- Take over existing mortgage payments
- Deed transfers but loan stays in seller's name
- Risk: due-on-sale clause (rarely enforced but exists)
- Best for low-interest-rate assumption

### Hard Money / Bridge Loan
- Short-term (6-18 months)
- Asset-based (property value, not borrower income)
- High interest (10-14%) + 1-3 points origination
- Best for: flips, BRRRR rehab phase
- Use REICalc `analyze_hard_money_loan` for modeling

### Construction Loan
- Funds new construction or major renovation
- Draws released as work is completed
- Converts to permanent financing upon completion
- Interest-only during construction phase
- Use REICalc `analyze_construction_loan` for modeling

### House Hack Financing Ladder
1. **Year 1**: FHA 3.5% down on 2-4 unit property
2. **Year 2**: Move out, convert to investment, buy next primary (conventional 5%)
3. **Year 3+**: Refinance FHA to conventional (remove MIP), repeat
4. **Scale**: Use DSCR loans once DTI is maxed on conventional

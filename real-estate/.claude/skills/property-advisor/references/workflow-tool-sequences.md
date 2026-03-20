# Workflow Tool Sequences

Exact MCP tool call sequences for each property advisor workflow. Tool names use the MCP server prefix — `mcp__rentcast__` for RentCast tools and `mcp__reicalc__` for REICalc tools. The prefixes are added automatically when calling via MCP.

---

## Workflow 1: Search (`search <zip/city>`)

### Phase 1 — Parallel Scan
```
PARALLEL:
  rentcast: search_sale_listings { city: "<city>", state: "<state>", limit: 20 }
  rentcast: search_rental_listings { city: "<city>", state: "<state>", limit: 20 }
  rentcast: get_market_stats { zip: "<zip>" }
```

### Phase 2 — Filter and Screen
For each promising listing:
```
rentcast: get_rent_estimate { address: "<address>" }
```
Calculate rent-to-price ratio. Filter to properties meeting minimum thresholds.

### Phase 3 — Quick Score
For top 5 candidates:
```
PARALLEL:
  rentcast: search_property { address: "<address>" }
  rentcast: get_value_estimate { address: "<address>" }
```
Apply Deal Score screening criteria (cash flow estimate, market strength, rent-to-price).

---

## Workflow 2: Full Analysis (`analyze <address>`)

### Phase 1 — Parallel Data Gathering
```
PARALLEL:
  rentcast: search_property { address: "<address>" }
  rentcast: get_rent_estimate { address: "<address>" }
  rentcast: get_value_estimate { address: "<address>" }
  rentcast: get_market_stats { zip: "<zip>" }
  reicalc: calculate_cocr { purchasePrice, downPayment, monthlyRent, monthlyExpenses }
  reicalc: calculate_irr { purchasePrice, cashFlows, holdingPeriod }
```

### Phase 2 — Conditional Drill-Downs
```
IF multi_unit:
  reicalc: evaluate_house_hack { ... }

IF cap_rate > 7%:
  reicalc: calculate_dscr { noi, annualDebtService }

IF flip_potential:
  reicalc: analyze_fix_flip { purchasePrice, rehabCost, arv, holdingMonths }
```

### Phase 3 — Financing and Risk
```
PARALLEL:
  reicalc: calculate_mortgage_affordability { income, debts, downPayment }
  reicalc: analyze_sensitivity { baseCase, variables }
```

### Phase 4 — Compute Deal Score
Load `references/investment-metrics-benchmarks.md`. Calculate weighted Deal Score (0-100).

---

## Workflow 3: House Hack (`househack <address>`)

### Phase 1 — Parallel
```
PARALLEL:
  rentcast: search_property { address: "<address>" }
  rentcast: get_rent_estimate { address: "<address>" }
  rentcast: get_value_estimate { address: "<address>" }
  reicalc: evaluate_house_hack { purchasePrice, unitCount, ownerUnit, rentalIncome, expenses, loan_type: "fha" }
  reicalc: calculate_piti { purchase_price, down_payment_pct, interest_rate, loan_type: "fha", property_tax_rate, annual_insurance }
```

### Phase 2 — Financing Options
```
PARALLEL:
  reicalc: calculate_mortgage_affordability { income, debts, downPayment: 0.035 }  # FHA
  reicalc: calculate_mortgage_affordability { income, debts, downPayment: 0.05 }   # Conventional
  reicalc: analyze_debt_to_income { income, existingDebts, proposedPayment }
```

### Phase 3 — Compute
Load `references/house-hacking-strategies.md`.
Calculate mortgage offset %, evaluate FHA self-sufficiency (if 3-4 units), model post-year-1 scenarios.

---

## Workflow 4: BRRRR (`brrrr <address>`)

### Phase 1 — Parallel
```
PARALLEL:
  rentcast: search_property { address: "<address>" }
  rentcast: get_value_estimate { address: "<address>" }
  rentcast: get_rent_estimate { address: "<address>" }
  reicalc: analyze_brrrr_deal { purchasePrice, rehabCost, arv, rentalIncome, expenses }
```

### Phase 2 — Refinance Modeling
```
reicalc: analyze_refinance { currentLoan, newRate, newTerm, closingCosts, propertyValue }
```

### Phase 3 — Compute
Load `references/investment-metrics-benchmarks.md` (BRRRR section).
Calculate cash left in deal, post-refi CoC, infinite return check.

---

## Workflow 5: Fix and Flip (`flip <address>`)

### Phase 1 — Parallel
```
PARALLEL:
  rentcast: search_property { address: "<address>" }
  rentcast: get_value_estimate { address: "<address>" }
  reicalc: analyze_fix_flip { purchasePrice, rehabCost, arv, holdingMonths, financingCosts }
```

### Phase 2 — Comp Validation
```
rentcast: get_market_stats { zip: "<zip>" }
```
Validate ARV against market comps and price/sqft.

### Phase 3 — Compute
Load `references/investment-metrics-benchmarks.md` (flip section).
Calculate MAO (70% rule), profit margin, ROI, holding costs.

---

## Workflow 6: Rental Deep Dive (`rental <address>`)

### Phase 1 — Parallel
```
PARALLEL:
  rentcast: get_rent_estimate { address: "<address>" }
  rentcast: search_property { address: "<address>" }
  rentcast: get_market_stats { zip: "<zip>" }
  reicalc: calculate_dscr { noi, annualDebtService }
  reicalc: calculate_cocr { purchasePrice, downPayment, monthlyRent, monthlyExpenses }
```

### Phase 2 — Expense Modeling
```
reicalc: calculate_irr { purchasePrice, cashFlows, holdingPeriod }
```

### Phase 3 — Compute
Load `references/investment-metrics-benchmarks.md`.
Calculate cap rate, GRM, expense ratio, 50% rule validation, pro forma cash flow.

---

## Workflow 7: Market Overview (`market <zip>`)

### Phase 1 — Parallel
```
PARALLEL:
  rentcast: get_market_stats { zip: "<zip>" }
  reicalc: analyze_market_comps { zipCode: "<zip>" }
  rentcast: search_sale_listings { city: "<city>", state: "<state>", limit: 10 }
  rentcast: search_rental_listings { city: "<city>", state: "<state>", limit: 10 }
```

### Phase 2 — Compute
Load `references/market-analysis-frameworks.md`.
Calculate Market Score (0-100), neighborhood grade, rent-to-price ratio, supply/demand signals.

---

## Workflow 8: Compare Properties (`compare`)

### Phase 1 — User Input
Collect up to 5 property addresses.

### Phase 2 — Parallel Data for Each Property
```
FOR EACH property:
  PARALLEL:
    rentcast: search_property { address }
    rentcast: get_rent_estimate { address }
    rentcast: get_value_estimate { address }
```

### Phase 3 — Side-by-Side Analysis
```
reicalc: compare_properties { properties: [...] }
```

### Phase 4 — Compute
Calculate Deal Score for each. Rank by composite score. Present comparison table.

---

## Workflow 9: Affordability (`afford`)

### Phase 1 — User Input
Collect: gross monthly income, monthly debts, available down payment, target property type.

### Phase 2 — Parallel Calculations
```
PARALLEL:
  reicalc: calculate_affordability { income, debts, downPayment, interestRate, loan_type: "fha" }
  reicalc: calculate_mortgage_affordability { income, debts, downPayment }
  reicalc: analyze_debt_to_income { income, existingDebts, proposedPayment }
```

### Phase 3 — Loan Comparison
```
reicalc: compare_loans { loanOptions: [fha, conventional, va] }
```

### Phase 4 — Compute
Load `references/lending-guidelines.md`.
Calculate max purchase price by loan type, DTI impact, reserve requirements.

---

## Workflow 10: Risk Analysis (`risk <address>`)

### Phase 1 — Parallel
```
PARALLEL:
  rentcast: search_property { address: "<address>" }
  rentcast: get_rent_estimate { address: "<address>" }
  rentcast: get_market_stats { zip: "<zip>" }
  reicalc: calculate_piti { purchase_price, down_payment_pct, interest_rate, loan_type: "fha", property_tax_rate, annual_insurance }
  reicalc: run_monte_carlo { baseCase, iterations: 1000, variables }
  reicalc: analyze_sensitivity { baseCase, variables: [rent, vacancy, rate, appreciation] }
```

### Phase 2 — Compute
Analyze downside scenarios: worst-case cash flow, break-even occupancy, rate sensitivity.

---

## Workflow 11: Tax Analysis (`tax <address>`)

### Phase 1 — Parallel
```
PARALLEL:
  rentcast: search_property { address: "<address>" }
  reicalc: calculate_tax_benefits { purchasePrice, depreciableValue, taxBracket, holdingPeriod }
  reicalc: analyze_1031_exchange { relinquishedProperty, replacementProperty }
  reicalc: calculate_capital_gains_tax { purchasePrice, salePrice, holdingPeriod, taxBracket }
```

### Phase 2 — Compute
Model depreciation schedule, annual tax savings, 1031 exchange timeline and rules.

---

## Workflow 12: Portfolio Projection (`portfolio`)

### Phase 1 — User Input
Collect: current portfolio (properties owned), annual investment budget, target strategy, time horizon.

### Phase 2 — Projection
```
reicalc: project_portfolio_growth { currentProperties, annualBudget, strategy, years }
```

### Phase 3 — Compute
Model portfolio growth: total units, equity, cash flow, net worth contribution over time horizon.

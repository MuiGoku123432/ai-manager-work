# Market Analysis Frameworks

## How to Evaluate a Market

### Macro-Level Indicators

| Indicator | What to Look For | Source |
|-----------|-----------------|--------|
| Job Growth | 2%+ annual growth, diverse employers | BLS, local economic reports |
| Population Growth | Positive net migration, growing metro | Census, RentCast market stats |
| Rent Growth | 3-5% annual growth sustainable | RentCast market statistics |
| Home Price Appreciation | 3-6% annual sustainable growth | RentCast property valuations |
| Unemployment Rate | Below national average | BLS |
| Median Household Income | Growing, supports target rents | Census |
| Affordability Index | Rent-to-income below 30% for target demographic | Calculated from RentCast data |
| Vacancy Rate | Below 5% ideal, below 8% acceptable | RentCast market statistics |

### Supply and Demand Signals

**Demand indicators (bullish):**
- Population inflow exceeding housing starts
- Low vacancy rates and declining
- Rent growth outpacing inflation
- Multiple major employers expanding
- University or military base presence

**Supply indicators (bearish):**
- Permit activity significantly exceeding population growth
- Rising vacancy rates
- Large multi-family construction pipeline
- Rent concessions appearing (free month, reduced deposits)

---

## Neighborhood Grading (A/B/C/D)

### Class A Neighborhoods
- **Characteristics**: Newest construction, highest incomes, best schools, lowest crime
- **Typical tenants**: High-income professionals, executives
- **Investment profile**: Low cap rates (3-5%), appreciation-driven, lowest vacancy, lowest management burden
- **House hack fit**: Premium properties, harder to cash flow, strong appreciation upside

### Class B Neighborhoods
- **Characteristics**: Established neighborhoods, good schools, moderate crime, aging but well-maintained housing
- **Typical tenants**: Working professionals, families, stable employment
- **Investment profile**: Moderate cap rates (5-7%), balanced cash flow and appreciation, low-moderate vacancy
- **House hack fit**: Best overall for house hacking — affordable entry, reliable tenants, solid rental demand

### Class C Neighborhoods
- **Characteristics**: Older housing stock, average schools, moderate crime, blue-collar workforce
- **Typical tenants**: Hourly workers, service industry, some Section 8
- **Investment profile**: Higher cap rates (7-10%), cash flow driven, higher vacancy and maintenance, more management intensive
- **House hack fit**: Strong cash flow offset, but livability may be a concern for owner-occupant

### Class D Neighborhoods
- **Characteristics**: High crime, poor schools, significant deferred maintenance, economic distress
- **Typical tenants**: Highest turnover, collection challenges
- **Investment profile**: Highest cap rates (10%+), highest risk, professional management required
- **House hack fit**: Generally not recommended for house hacking due to safety and livability

---

## Comparable Analysis Methodology

### Selecting Comps

**Criteria for valid comparables:**
1. **Proximity**: Within 0.5-1 mile (urban), 1-3 miles (suburban), 5 miles (rural)
2. **Recency**: Sold within last 6 months (ideal), up to 12 months acceptable
3. **Similarity**: Same property type, within 20% of square footage, similar bedroom/bathroom count
4. **Condition**: Similar condition and renovation level
5. **Lot size**: Within 25% for single-family

### Adjustment Factors (Approximate)
| Feature | Typical Adjustment |
|---------|-------------------|
| Bedroom (+/-1) | $5,000-$15,000 depending on market |
| Bathroom (+/-1) | $5,000-$10,000 |
| Garage (add/remove) | $10,000-$25,000 |
| Square footage | $50-$200/sqft depending on market |
| Lot size | $1-$10/sqft depending on market |
| Condition (superior/inferior) | 5-15% adjustment |
| Age (per decade difference) | 2-5% adjustment |

### Rent Comps
- Use RentCast `get_rent_estimate` for algorithmic rent estimates
- Validate against active listings in the area
- Adjust for condition, amenities, and included utilities
- Look at both asking rents and actual leased rents when available

---

## Market Scoring Framework

### Market Score (0-100)

| Component | Weight | Scoring Criteria |
|-----------|--------|-----------------|
| Rent Growth (YoY) | 20% | <0% = 0pts, 0-2% = 25pts, 2-4% = 50pts, 4-6% = 75pts, 6%+ = 100pts |
| Vacancy Rate | 20% | >10% = 0pts, 8-10% = 25pts, 5-8% = 50pts, 3-5% = 75pts, <3% = 100pts |
| Price Appreciation | 15% | <0% = 0pts, 0-3% = 25pts, 3-5% = 50pts, 5-8% = 75pts, 8%+ = 100pts |
| Rent-to-Price Ratio | 15% | <0.5% = 0pts, 0.5-0.7% = 25pts, 0.7-0.9% = 50pts, 0.9-1.1% = 75pts, 1.1%+ = 100pts |
| Population Growth | 15% | Negative = 0pts, 0-0.5% = 25pts, 0.5-1% = 50pts, 1-2% = 75pts, 2%+ = 100pts |
| Affordability | 15% | >40% rent/income = 0pts, 35-40% = 25pts, 30-35% = 50pts, 25-30% = 75pts, <25% = 100pts |

### Score Interpretation
- **80-100**: Hot market — strong fundamentals, competitive
- **60-79**: Solid market — good investment potential
- **40-59**: Mixed signals — proceed with caution, target specific sub-markets
- **0-39**: Weak market — avoid unless deep local knowledge

---

## Sub-Market Analysis

### Zip Code Level Metrics (via RentCast)
- Median rent by bedroom count
- Median home price
- Rent-to-price ratio
- Days on market (DOM)
- Active listing count
- Price per square foot

### What Good Metrics Look Like
| Metric | Green Flag | Yellow Flag | Red Flag |
|--------|-----------|-------------|----------|
| DOM | < 30 days | 30-60 days | > 60 days |
| Active listings | Declining | Stable | Rising sharply |
| Price/sqft trend | Rising | Flat | Declining |
| Rent/sqft trend | Rising | Flat | Declining |

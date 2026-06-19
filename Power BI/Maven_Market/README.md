# Maven Market Sales Dashboard — Power BI

> A Power BI report evaluating **brand performance, profitability, and regional activity** across the USA, Mexico, and Canada — turning 112K transactions into a clear story about which brands and regions drive growth.

![Tool](https://img.shields.io/badge/tool-Power%20BI-yellow)
![Modeling](https://img.shields.io/badge/modeling-DAX%20%7C%20Data%20Modeling-blue)
![Period](https://img.shields.io/badge/period-1998-lightgrey)

---

## Overview

The Maven Market dashboard analyzes a full year (1998) of retail transactions across three countries. It evaluates brand-level profit contribution, regional sales patterns, returns ratio, and progress against monthly profit targets — giving leadership a single view of "what is and isn't working."

## Business Problem

The leadership team needed answers to four questions:

1. Which **brands** generate the most profit per dollar of revenue?
2. How does performance compare across **USA, Mexico, and Canada**?
3. Are we **hitting monthly profit goals**, and by how much?
4. Where are **returns** signalling product or supplier issues?

## Technologies

`Power BI Desktop` · `DAX` · `Power Query (M)` · `Data Modeling` · `KPI Cards`

## Headline Metrics (1998)

| KPI | Value |
| --- | --- |
| Total Transactions | **112,433** |
| Total Profit | **$449,019.61** |
| Return Ratio | **~1%** |
| Monthly Profit (avg) | **$71.68K** |
| Monthly Goal Attainment | **+5.61% above target** |

## Methodology

1. **Data preparation** — cleaned and shaped product, customer, store, and transaction tables in Power Query.
2. **Star schema modeling** — fact-and-dimension relationships with explicit cardinality and filter direction.
3. **DAX measure layer** — revenue, profit, return ratio, monthly goal variance, brand-rank measures.
4. **Visual storytelling** — KPI cards, ranked bar charts, geographic map, and a monthly goal-tracking line chart.

## Key Findings

- **Super, Golden, and BBB Best** are the standout brands — each generating **over $13K profit** at a return rate **under 1%**.
- The overall **1% return ratio** indicates strong product quality and supplier reliability.
- Monthly profit exceeded targets by **5.61%**, with the strongest months concentrated in the back half of the year.
- Regional analysis surfaces underperforming geographies where targeted promotion or assortment changes are likely to move the needle.

## Repository Structure

```
Maven_Market/
├── MavenMarket.pbix     # Power BI source file
├── MavenMarket.pdf      # Static export of the dashboard
└── README.md
```

## How to View

1. Download `MavenMarket.pbix` and open in [Power BI Desktop](https://powerbi.microsoft.com/desktop/).
2. Or open `MavenMarket.pdf` for a static walkthrough of every page.

## Business Recommendations

- **Double down on Super, Golden, and BBB Best** — co-marketing, premium shelf placement, partnership renewal.
- **Investigate underperforming regions** with targeted price tests or assortment changes.
- **Convert the goal-tracking page into a daily executive email** via Power BI Subscriptions.

## Future Improvements

- Add **YoY comparisons** once multi-year data is available.
- Layer in **customer lifetime value** measures via the customer dimension.
- Publish to the Power BI Service for an embed link in the portfolio README.

---

**Author:** Enmanuel Mateo

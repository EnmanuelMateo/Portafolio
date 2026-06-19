# AdventureWorks Sales Performance Dashboard — Power BI

> An executive-grade Power BI dashboard analyzing **$24.9M in revenue** and **$10.5M in profit** across 2020–2022, with revenue, margin, customer segmentation, and product-mix insights.

![Tool](https://img.shields.io/badge/tool-Power%20BI-yellow)
![Modeling](https://img.shields.io/badge/modeling-Star%20Schema%20%2B%20DAX-blue)
![Period](https://img.shields.io/badge/period-2020--2022-lightgrey)

---

## Overview

A multi-page Power BI report built on the **AdventureWorks** sales dataset that translates three years of transactional data into the metrics an executive team actually uses: revenue, profit, margin, returns, and growth. The model is built on a clean **star schema** with DAX measures for time-intelligence and KPI variance.

## Business Problem

Sales leadership needed answers to:

- Are we **growing** revenue and profit year over year?
- Which **products and categories** drive margin (vs. just volume)?
- Where are **returns** eating into profitability?
- Which **customer segments** are most valuable and which are at risk?

## Technologies

`Power BI Desktop` · `Power Query (M)` · `DAX` · `Star Schema Modeling` · `Time Intelligence`

## Headline Metrics (2020–2022)

| KPI | Value |
| --- | --- |
| Total Revenue | **$24.9M** |
| Total Profit | **$10.5M** |
| Profit Margin | **~42%** |
| Total Orders | **25.2K** |
| Return Rate | **2.2%** |

## Methodology

1. **Data preparation** in Power Query — cleaned, typed, and shaped fact and dimension tables.
2. **Star-schema model** — central `FactSales`/`FactReturns` joined to `DimProduct`, `DimCustomer`, `DimDate`, `DimGeography`.
3. **DAX measures** — revenue, profit, margin %, YoY growth, rolling 12-month, returns ratio.
4. **Report layout** — executive summary page, product deep-dive, customer segmentation, regional view, and a returns analysis page.
5. **Performance tuning** — measure folding, aggregation tables, and filter-context audit.

## Key Findings

- **Revenue growth accelerated** across the three-year window, with margin holding around 42% — operational efficiency is keeping pace with top-line growth.
- The **return rate of 2.2%** is healthy and concentrated in a narrow set of SKUs.
- A small number of **top-performing products** carry a disproportionate share of profit — a classic Pareto distribution.
- Customer concentration analysis highlights segments where **targeted marketing** would yield the highest expected ROI.

## Repository Structure

```
Adventure_Works/
├── AdventureWorks.pbix     # Power BI source file
├── AdventureWorks.pdf      # Static export of the dashboard
└── README.md
```

## How to View

1. Download `AdventureWorks.pbix` and open in [Power BI Desktop](https://powerbi.microsoft.com/desktop/).
2. Or open `AdventureWorks.pdf` for a static walkthrough of every page.

## Future Improvements

- Publish to the **Power BI Service** for an embed link in the portfolio README.
- Add **forecasting** measures using built-in time-series or external Python integration.
- Layer in a **What-if parameter** for margin sensitivity to discount levels.
- Replace static returns view with a **drill-through** to per-SKU return analysis.
- Build an accompanying **executive PDF brief** summarizing the dashboard's three key takeaways.

---

**Author:** Enmanuel Mateo

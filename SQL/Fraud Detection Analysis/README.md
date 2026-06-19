# Fraud Detection — SQL Analysis (PostgreSQL)

> A normalized PostgreSQL schema and analytical-view layer designed to surface fraudulent credit-card activity — sub-$2 test charges, early-morning bursts, and recurring at-risk merchants.

![DB](https://img.shields.io/badge/db-PostgreSQL-blue)
![Type](https://img.shields.io/badge/type-Schema%20%2B%20Analytical%20Views-success)

---

## Overview

This project designs the **data backbone** for fraud analysis: a normalized PostgreSQL schema (cardholders → cards → merchants → transactions) plus a layer of analytical views that materialize the questions a fraud-ops team asks every day.

The companion notebook ([`SQL_Fraud.ipynb`](SQL_Fraud.ipynb)) runs the full SQL flow inside Jupyter via `ipython-sql`, while the raw DDL/DML lives in [`Fraud_sql.sql`](Fraud_sql.sql).

## Business Problem

Fraud-operations teams need to answer recurring questions quickly:

- Which transactions look like **card-testing** activity (sub-$2 charges)?
- Which **merchants** are repeatedly associated with suspicious charges?
- Which **time windows** see the highest at-risk activity?
- Which **cardholders** are most likely compromised?

Answering these reliably depends first on **clean, normalized data** — which this project provides.

## Technologies

`PostgreSQL` · `SQL (DDL, DML, Views)` · `Jupyter` · `ipython-sql`

## Schema

```
card_holder ──< credit_card ──< transaction >── merchant
                                     │
                                     └── merchant_category
```

- `card_holder` — customer identity
- `credit_card` — card ↔ holder mapping (FK)
- `merchant` — merchant directory with category FK
- `merchant_category` — lookup
- `transaction` — fact table (amount, date, card, merchant)

## Methodology

1. **Schema design.** Normalized model with primary/foreign keys and explicit referential constraints.
2. **Data cleaning.** A `card_mapping` temp table corrects malformed credit-card numbers (truncated to multiples of 10⁵). The `credit_card` table is updated in place to restore referential integrity before downstream joins.
3. **Analytical view layer.**

| View | Purpose |
| --- | --- |
| `card_holder_identifier` | Cardholder ↔ card join for unified identification |
| `transaction_customer` | Transactions enriched with cardholder name |
| `view_count_transaction_per_cardholder` | Rank cardholders by count of sub-$2 charges |
| `view_top_merchants` | Merchants with the most suspicious transactions |
| `view_highest_transactions_7_9` | High-value transactions during the 7–9 AM card-testing window |

4. **Cross-validation.** Results feed the Python notebook for statistical outlier detection (see [`/Python/Fraud Detection Analysis`](../../Python/Fraud%20Detection%20Analysis)).

## Key Findings

- A statistically clear **cluster of sub-$2 transactions** consistent with stolen-card testing.
- The **top 5 merchants** absorb a disproportionate share of suspicious activity — these merchants warrant elevated review.
- High-value transactions concentrate in the **7–9 AM window**, supporting time-based alerting rules.
- The corrected card-number mapping eliminated **false-positive merchant counts** that the raw data would have produced.

## Repository Structure

```
Fraud Detection Analysis/
├── Fraud_sql.sql      # DDL + DML + view definitions
├── SQL_Fraud.ipynb    # Jupyter notebook running the same SQL end-to-end
└── README.md
```

## How to Run

```bash
# 1. Create a database and load the schema
createdb fraud_detect
psql -d fraud_detect -f Fraud_sql.sql

# 2. Or run interactively from Jupyter
pip install jupyter ipython-sql psycopg2-binary sqlalchemy
jupyter notebook SQL_Fraud.ipynb
```

Update the connection string at the top of the notebook to point at your PostgreSQL instance.

## Future Improvements

- Add **partitioning** (by month) on the `transaction` fact table for time-window queries at scale.
- Add **indexes** on `(card, date)` and `(merchant_id, amount)` to accelerate the most common analytical views.
- Materialize heavy views (`view_top_merchants`) for sub-second dashboard refreshes.
- Add **window functions** to compute rolling velocity features (transactions per card per minute) for streaming fraud scoring.

---

**Author:** Enmanuel Mateo

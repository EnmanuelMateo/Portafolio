# Fraud Detection Analysis — Python + PostgreSQL

> Exploratory fraud analytics on credit-card transactions, combining **SQL views** with **Python** outlier detection to surface suspicious patterns and at-risk merchants.

![Stack](https://img.shields.io/badge/stack-Python%20%7C%20PostgreSQL-blue)
![Type](https://img.shields.io/badge/type-EDA%20%2B%20outlier%20detection-orange)

---

## Overview

This notebook investigates a real-world fraud pattern: criminals validate stolen cards with **very small "test" charges** before attempting larger purchases. Using SQLAlchemy to query a PostgreSQL transaction database and pandas/seaborn for analysis, the project flags suspicious activity, applies two complementary outlier methods, and highlights the merchants and cardholders most exposed.

## Business Problem

Card-not-present fraud often begins with sub-dollar test transactions that look unremarkable individually but cluster around specific merchants and time windows. The goal of this analysis is to **answer three questions for a fraud-operations team**:

1. Which **cardholders** show repeated micro-transactions?
2. Which **merchants** are most frequently associated with suspicious charges?
3. Are there **time-of-day** patterns (e.g. early-morning testing) that should trigger alerts?

## Technologies

`Python` · `pandas` · `SQLAlchemy` · `psycopg2` · `seaborn` · `matplotlib` · `PostgreSQL`

## Methodology

1. **Connect** to PostgreSQL via SQLAlchemy and pull the `transaction` table plus pre-built analytical views (`view_highest_transactions_7_9`, `view_top_merchants`, `view_count_transaction_per_cardholder`).
2. **Flag** transactions under **$2** as candidate fraud-test charges.
3. **Detect outliers** using two methods for cross-validation:
   - **IQR method** — values outside 1.5 × IQR
   - **Standard deviation method** — values more than 3σ from the mean
4. **Rank** the top 10 cardholders by suspicious-transaction count.
5. **Visualize** distributions: top customers, hour-of-day histogram, top high-activity merchants.

## Key Findings

- A measurable cluster of **sub-$2 transactions** points to card-testing activity rather than legitimate retail behavior.
- The **top 5 merchants** account for a disproportionate share of suspicious charges — a small allowlist could materially reduce noise in downstream alerting.
- Transactions cluster in the **7–9 AM window**, consistent with automated card-testing scripts running on schedule.
- IQR and 3σ outlier methods agree on the same population of high-value anomalies, increasing confidence in the flags.

## Repository Structure

```
Fraud Detection Analysis/
├── Fraud_detect.ipynb      # End-to-end analysis notebook
└── README.md
```

## How to Run

```bash
pip install pandas sqlalchemy psycopg2-binary seaborn matplotlib jupyter
jupyter notebook Fraud_detect.ipynb
```

Update the connection string in cell 2 to point at your PostgreSQL instance. SQL views are defined in the companion project at [`/SQL/Fraud Detection Analysis`](../../SQL/Fraud%20Detection%20Analysis).

## Future Improvements

- Train a **supervised classifier** (logistic regression, XGBoost) once labelled fraud outcomes are available.
- Add **velocity features** (transactions per card per minute) and merchant-category encodings.
- Integrate with the **IoT pipeline pattern** from this portfolio to stream transactions through Kafka and score in near real time.
- Build a **Power BI** monitoring dashboard for the fraud-operations team.

---

**Author:** Enmanuel Mateo

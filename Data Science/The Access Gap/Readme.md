# The Access Gap — Predicting Healthcare Access Risk in Canada

> A capstone-grade machine learning project that identifies **which Canadians are at risk of unmet healthcare need**, why they are at risk, and where in New Brunswick policy investment will produce the largest return.

![Method](https://img.shields.io/badge/method-CRISP--DM-blue)
![Model](https://img.shields.io/badge/model-LightGBM-success)
![Explainability](https://img.shields.io/badge/explainability-SHAP-orange)
![Data](https://img.shields.io/badge/data-CCHS%202022%20PUMF-lightgrey)

---

## Overview

Canada guarantees universal healthcare in law, but access is unevenly delivered in practice. Using the 2022 Canadian Community Health Survey (CCHS PUMF, 67,079 respondents), this project builds a calibrated machine-learning model to classify individuals at risk of unmet healthcare need and translates the findings into operational recommendations for the **New Brunswick Department of Health** and the **Horizon and Vitalité** regional health networks.

> **26.34%** of Canadians aged 12+ meet the operational definition of healthcare access risk — walk-in dependent, without a regular provider, unable to find one, or skipping prescriptions due to cost.

## Business Problem

Policymakers and regional health authorities need to answer three questions:

1. **Who** carries the greatest access risk?
2. **Where** does that risk concentrate within New Brunswick?
3. **What** levers — clinical, geographic, or structural — will move the needle?

This project answers all three with quantitative evidence.

## Technologies

`Python` · `pandas` · `numpy` · `scikit-learn` · `LightGBM` · `Optuna` · `SHAP` · `statsmodels` · `matplotlib` · `seaborn` · `Jupyter`

## Methodology (CRISP-DM)

| Phase | Notebook | What happens |
| --- | --- | --- |
| Business & Data Understanding | `NB01_Data_Understanding_Target_Engineering.ipynb` | Target engineering, dataset triage, leakage audit |
| Data Preparation | `NB02_Data_Preparation_Pipeline.ipynb` | Coded-missing replacement, leakage removal (40+ variables), 64/16/20 stratified split |
| Feature Engineering | `nb_03_feature_engineering_fixes.ipynb` | Ordinal preservation, categorical handling, geo joins |
| Modeling | `NB04_Model_Development.ipynb` | Baseline + LightGBM with `scale_pos_weight` for class imbalance |
| Tuning | `NB05_Hyperparameter_Tuning.ipynb` | Optuna search (200 trials × 3 runs) over PR-AUC |
| Final Evaluation | `NB06_Final_Evaluation_SHAP.ipynb` | Sealed-test evaluation, calibration, SHAP explainability |

Three datasets were retained after redundancy testing:
- **CCHS 2022 PUMF** — 67,079 respondents, 255 variables
- **Open Database of Healthcare Facilities (ODHF v1.1)** — 7,033 facilities
- **CIHI 2025 Wait Times** release

## Key Findings

### Individual-level signal
- **Household food security is the strongest individual-level predictor of access risk** — stronger than income, education, age, or self-rated health.
  - Cramér's V = **0.17** (largest categorical effect size)
  - Point-biserial r = **+0.17**
  - Adjusted OR = **1.44 per category** (95% CI 1.40–1.48, p < .001)
  - Severely food-insecure respondents carry **~2.95× the access-risk odds** of fully food-secure peers.
- Self-rated physical health (OR = 1.23), low income (protective OR = 0.88/quintile) followed.
- Counter-intuitive but robust: **immigrant status was protective** (OR = 0.83, "healthy-immigrant effect"); reporting a chronic condition was **also protective** (OR = 0.90), reflecting stronger provider attachment.

### Geographic signal
- After adjustment, the **Territories** carried the highest odds (OR = 3.20 vs. Alberta), followed by PEI (2.11) and Quebec (1.91).
- **New Brunswick ranked 9th of 11** jurisdictions overall (OR = 1.17, p = .021) — overturning the project's initial hypothesis that NB was uniformly worse than the national average.

### The headline insight
- Inside a single regional health authority, **Vitalité Edmundston (Zone 4) recorded 35.0%** at-risk versus **Vitalité Bathurst (Zone 5/6) at 20.3%** — a nine-percentage-point intra-authority gap.

### Model performance
- A tuned **LightGBM** classifier reached **PR-AUC = 0.43** on the sealed test set (positive class).
- At the deployment threshold (0.185), the calibrated model identifies **81% of at-risk respondents at 32% precision** — appropriate for **population-level outreach**, not individual diagnosis.

## Results & Impact

Three prioritized, operationally-actionable recommendations were delivered to NB stakeholders:

1. **Co-locate primary-care attachment at food-bank and community-meal sites** — meeting the highest-yield at-risk population where it already concentrates.
2. **Replace per-capita funding allocation with a risk-weighted formula** across NB health zones, prioritizing Vitalité Edmundston.
3. **Expand surgical throughput at Vitalité regional hospitals** where wait times are worst (NB's hip-replacement wait of 256 days is second-longest nationally).

None of the recommendations require new funding — only a reallocation of existing resources guided by evidence.

## Repository Structure

```
The Access Gap/
├── Code/
│   ├── NB01_Data_Understanding_Target_Engineering.ipynb
│   ├── NB02_Data_Preparation_Pipeline.ipynb
│   ├── nb_03_feature_engineering_fixes.ipynb
│   ├── NB04_Model_Development.ipynb
│   ├── NB05_Hyperparameter_Tuning.ipynb
│   └── NB06_Final_Evaluation_SHAP.ipynb
├── Docs/
│   └── D5_Final_Report.pdf
└── README.md
```

## Limitations

- **Cross-sectional design.** CCHS 2022 supports correlational, not causal, inference.
- **Population scope.** Findings generalize to Canadians 12+ in private dwellings in 2022; not to institutional populations or children under 12.
- **PR-AUC ceiling.** 0.43 reflects a real ceiling for survey-only features; clinical or claims data would be required to push higher.
- **Geographic granularity.** Sub-health-region analysis (medical-school proximity) requires the CCHS Master file at a Statistics Canada Research Data Centre.

## Future Improvements

- Link to administrative claims or EMR data to validate model performance against actual unmet-need outcomes.
- Build an interactive **Power BI / Streamlit** decision-support dashboard for health-zone planners.
- Extend the modeling pipeline to other provinces using the same operational target definition.
- Add longitudinal follow-up via CCHS rapid-response modules to support causal inference.

---

**Authors:** Enmanuel Mateo & Francisco Villalobos · NBCC Capstone (SYST1059A) · Supervisor: Hend Negm

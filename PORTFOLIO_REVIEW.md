# Portfolio Audit & Recommendations

A reviewer-facing audit of the `EnmanuelMateo/Portafolio` repository — what's strong, what's missing, and the concrete next steps that will move it from "solid student portfolio" to "recruiter-ready professional portfolio."

Date: June 19, 2026

---

## 1. What's Working

| Project | Strengths |
| --- | --- |
| **IoT Sensors (Data Engineering)** | Clear business framing, real metrics (+30% quality, +40% query speed), production stack (Kafka, Iceberg, Docker), real screenshots. This is the standout project. |
| **The Access Gap (Data Science)** | Capstone-grade depth: CRISP-DM, 200-trial Optuna tuning, SHAP, calibrated thresholds, sealed test set, three concrete policy recommendations. |
| **IoT Data Pipeline (Python)** | Real production code that complements the data-engineering project well. |
| **Fraud Detection (Python + SQL)** | Good demonstration of the analytics loop: SQL views feed Python outlier analysis. |
| **Power BI dashboards** | Concrete KPIs and real DAX work — recruiters can verify quickly via the included PDFs. |

## 2. Repository-Level Issues Fixed in This Review

| Before | After |
| --- | --- |
| Placeholder files (`read.md`, `readme.md`, `Description`) with junk content (`gfd`, `dsf`, `fdsa`) | Deleted |
| `Readme.md` for The Access Gap contained only the string `gfdx` | Replaced with full project README |
| Maven Market README was generic and lacked structure | Restructured with business problem, methodology, results |
| Adventure Works had **no README** — only a `Description` file | Full README added |
| Fraud Detection (Python and SQL) had **no project-level README** | Both added |
| Top-level README mixed long bullet descriptions in tables, used commit-pinned URLs, and had no "About me" section | Rewritten with About, Stack, contact, branch-stable relative links |

## 3. What's Still Missing (Recommended Next Steps)

These are the highest-ROI things to add. They are listed in priority order.

### 🔴 High priority — do these first

1. **Add a professional headshot or banner image** at the top of the root README.
2. **Add a LinkedIn URL** to the root README and to each project's footer (the current footer has a placeholder).
3. **Pin a `.gitignore`** so notebook checkpoints, `__pycache__`, `.env` files never get committed.
4. **Secrets review.** The Python IoT scripts contain placeholder credentials. Convert all to **environment variables** (`os.environ.get(...)`) and document an example `.env.example`.
5. **Add a license file** (MIT is standard for portfolios) at the repo root.
6. **Pin notebook outputs.** The Access Gap notebooks should be committed with executed outputs so reviewers can read them on GitHub without re-running.
7. **Embed Power BI screenshots in the READMEs.** Both Power BI READMEs reference PDFs but show no inline screenshots. A single hero image per dashboard dramatically increases time-on-page from reviewers.

### 🟡 Medium priority — clear "next 2 weekends" wins

8. **Publish Power BI to the service** and add a public embed link to each Power BI README.
9. **Add an executive 1-page PDF brief** for The Access Gap (PDF of the most important page from D5).
10. **Add a `requirements.txt`** to each Python project so anyone can `pip install -r` and re-run.
11. **Add executable architecture diagrams** (mermaid or a PNG) to the IoT and Access Gap READMEs.
12. **Add a Streamlit or Power BI demo** of The Access Gap predictions — even a static one. The model is the most valuable artifact in the portfolio and currently has no interactive surface.
13. **Add unit tests** for the IoT producer/consumer (even a single happy-path test) — recruiters notice.
14. **Rename folders consistently.** Mix of `Iot Sensors` vs `IoT Data Pipeline` vs `Adventure_Works`. Standardize on Title Case with underscores (`Adventure_Works`) or kebab-case (`iot-sensors`). Whichever — be consistent.

### 🟢 Polish — nice to have

15. **Add 2-3 more projects** to broaden the surface:
    - A small **Streamlit / Plotly** dashboard for The Access Gap.
    - A **dbt** project (any data) to demonstrate analytics engineering.
    - An **LLM-powered** notebook (RAG over the Access Gap report, for example) — strong 2026 signal.
16. **Add a "Featured Project" callout** at the very top of the root README pointing at The Access Gap — it's your strongest artifact.
17. **Add badges for each project's stack** at the top of every README (done where relevant).
18. **Add a "What I'd build next" section** to every project README to show forward-thinking — this turns reviewers from passive readers into conversation partners.
19. **Track contributions**: turn on GitHub's contribution graph and pin the strongest projects to your profile.
20. **Consider a custom domain**: `enmanuelmateo.dev` pointing at a GitHub Pages site that surfaces the strongest READMEs as a hosted portfolio.

## 4. Content Suggestions (Recruiter-Facing)

Each project now has a "headline result" line in the root README. These are the lines a recruiter actually reads. Continue this pattern with every new project — **lead with the number that proves the impact**:

> ✅ "Improved query performance by 40% across the IoT data platform"
> ✅ "Surfaced a 9-point intra-authority gap in healthcare access for NB"
> ❌ "Worked on a Kafka pipeline"
> ❌ "Analyzed a dataset"

## 5. Voice & Tone

Your existing writing is competent. Two adjustments raise it from "good" to "recruiter-magnet":

- **Active voice, present tense for what the project does, past tense for what you did.**
  - "The model classifies access risk" / "I tuned LightGBM over 600 Optuna trials."
- **Cut hedging.** Replace "may indicate" with "indicates"; replace "could help" with "helps." If a finding is uncertain, quantify the uncertainty (CI, p-value) — never hedge with vague language.

## 6. Quick Checklist Before Sharing With a Recruiter

- [ ] LinkedIn URL is in every project footer
- [ ] At least one project has an embedded image/screenshot at the top
- [ ] No secrets, no credentials, no `localhost` placeholders in committed code
- [ ] `.gitignore` and `LICENSE` at the repo root
- [ ] Top-level README opens with a single sentence that explains who you are and what you do
- [ ] Every project's README answers: *What is the business problem? What did I do? What was the result?*

---

**Reviewer:** Generated by an automated portfolio audit on June 19, 2026. Treat as a working draft — adapt the recommendations to the roles you're actually targeting.

# Color Health Take-Home Assignment: Cancer Cohort & Cost Analysis

> **Note:** This section documents work completed specifically for the Color Health take-home assignment.  
> The original Tuva demo documentation is preserved below.

---

## Overview

This project centered on building an analytics engineering solution to identify patients with evidence of active cancer and summarize healthcare utilization and costs, using the Tuva demo dataset to model a realistic healthcare data environment. The primary focuses were clean, reusable models, transparency in assumptions, and business-ready outputs rather than overfitting complexity. 

---

## Project Structure & Modeling Approach

This project follows a layered dbt modeling approach. First are the core models, which are the standardized healthcare entities, such as condition and encounter. Second are intermedite models, logic driven concepts such as cohort definitions. Finally are the mart models which are aggregated, analysis ready datasets. By focusing on each concern separately, the logic becomes clearer and easier to reuse for future use cases. 

---

## Cohort Definition: Active Cancer Patients

The models are designed to support consistency across analytical use cases, explainability and accessibility to stakeholders, and scalability over time. 

In this use case, active cancer is defined as 1 or more condition recorded with an "ICD-10-CM" diagnosis code starting with the letter "C". Normalized diagnosis codes are used to ensure consistency across sources. The output is one row per patient which captures the earliest observed diagnosis date. 

The approach is designed to be pragmatic, reproducible, and appropriate for claims or encounter-based analysis. 

---

## Cost Modeling & Metrics

Costs are modeled using encounter-level data, using "paid_amount" as the proxy for cost, since a dedicated "claims" table is not present in the demo dataset. The costs are aggregated at the patient level with breakdowns by encounter type to approximate care settings. 

The output is a business-ready mart that show one row per patient, and would be suitable for dashboarding and analyses use cases. 

---

## Assumptions & Limitations

There are a few assumptions made to adapt this dataset for modeling:
* Encounter-level payments are used as a proxy for true cost. 
* There is no differentiation by cancer stage, treatment status, recurrence. 
* Encounter type is used as a high level care setting proxy. 
* The results are dependent on accuracy and completeness of source coding. 

---

## What I Would Do With More Time

There are a few more actions that I could take with time for further analysis:
* Refine the cancer cohort using additional clinical and longitudinal logic. 
* Conform the encounters, procedures, and medications into a unified utilization fact. 
* Time based analysis to determine seasonality, pre-, post- diagnosis trends. 
* Implement data quality tests and documentations for for broader self-service use. 

---

## AI Usage Disclosure

AI tools were used for the following tasks in this project:
* SQL scaffolding
* dbt troubleshooting
* logic review and validation 


---

[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt logo and version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=1.5.x&color=orange)

# The Tuva Project Demo

## 🧰 What does this project do?

This demo provides a quick and easy way to run the Tuva Project 
Package in a dbt project with synthetic data for 1k patients loaded as dbt seeds.

To set up the Tuva Project with your own claims data or to better understand what the Tuva Project does, please review the ReadMe in [The Tuva Project](https://github.com/tuva-health/the_tuva_project) package for a detailed walkthrough and setup.

For information on the data models check out our [Docs](https://thetuvaproject.com/).

## ✅ How to get started

### Pre-requisites
You only need one thing installed:
1. [uv](https://docs.astral.sh/uv/getting-started/) - a fast Python package manager. Installation is simple and OS-agnostic:
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```
   Or on Windows:
   ```powershell
   powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```

**Note:** This demo uses DuckDB as the database, so you don't need to configure a connection to an external data warehouse. Everything is configured and ready to go!

### Getting Started
Complete the following steps to run the demo:

1. [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) this repo to your local machine or environment.
2. In the project directory, install Python dependencies and set up the virtual environment:
   ```bash
   uv sync
   ```
3. Activate the virtual environment:
   ```bash
   source .venv/bin/activate  # On macOS/Linux
   # or on Windows:
   .venv\Scripts\activate
   ```
4. Run `dbt deps` to install the Tuva Project package:
   ```bash
   dbt deps
   ```
5. Run `dbt build` to run the entire project with the built-in sample data:
   ```bash
   dbt build
   ```

The `profiles.yml` file is already included in this repo and pre-configured for DuckDB, so no additional setup is needed!

### Using uv commands
You can also run dbt commands directly with `uv run` without activating the virtual environment:
```bash
uv run dbt deps
uv run dbt build
```

## 🤝 Community

Join our growing community of healthcare data practitioners on [Slack](https://join.slack.com/t/thetuvaproject/shared_invite/zt-16iz61187-G522Mc2WGA2mHF57e0il0Q)!

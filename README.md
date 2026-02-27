# Reproducible Data Validation Pipeline (R)

A production-style R pipeline for validating administrative datasets, 
applying quality checks, and generating automated HTML reports in a 
reproducible way. Built following the principles of 
[Reproducible Analytical Pipelines (RAP)](https://analysisfunction.civilservice.gov.uk/support/reproducible-analytical-pipelines/).

## What this pipeline does

This pipeline ingests a structured administrative dataset, runs six 
automated validation checks against it, and produces a clean HTML 
report summarising all data quality issues found — all triggered by 
a single command.

The six validation checks are:

- **Duplicate IDs** — detects records sharing the same identifier
- **Missing values** — flags nulls across required fields
- **Invalid gender codes** — validates against a configurable set of accepted codes
- **Attendance out of range** — catches values below 0 or above 100
- **Stage and school type mismatch** — cross-field validation catching logical inconsistencies
- **Future or implausible dates** — identifies dates of birth or enrolment that are in the future

## How the pipeline works

The pipeline is defined in `_targets.R` and runs five steps in order:

1. **raw_file** — tracks the input Excel file for changes
2. **df** — reads the raw dataset into R
3. **validation_results** — runs all six checks and collects results
4. **validation_summary** — extracts a summary table of PASS/FAIL status per check
5. **validation_report** — renders an automated HTML report from the results

The `targets` package ensures only steps affected by changes in the 
input data are re-run, making the pipeline efficient and auditable.

## Getting started

**1. Clone the repository**
```bash
git clone https://github.com/Kelechi-JohnAgwu/rap-data-validation-pipeline.git
```

**2. Restore the package environment**
```r
renv::restore()
```

**3. Add your dataset**

Place your Excel file in `data/raw/`. The pipeline expects the following fields:

| Field | Description |
|---|---|
| `pupil_id` | Unique record identifier |
| `date_of_birth` | Date of birth (YYYY-MM-DD) |
| `gender` | Gender code (M / F / X) |
| `ethnicity` | Ethnicity category |
| `local_authority` | Local authority name |
| `school_type` | Primary / Secondary / Special |
| `stage` | Year group (P1–P7 or S1–S6) |
| `date_enrolled` | Enrolment date (YYYY-MM-DD) |
| `attendance_rate` | Attendance percentage (0–100) |
| `fsm_eligible` | Free school meal eligibility (Y / N) |

**4. Run the pipeline**
```r
targets::tar_make()
```

**5. View the report**

Open `reports/validation_report.html` in your browser.

## Project structure
```
├── _targets.R                    # Pipeline definition
├── renv.lock                     # Package version lockfile
├── R/
│   ├── config.R                  # Centralised configuration
│   ├── validate_duplicates.R     # Duplicate ID check
│   ├── validate_missing.R        # Missing values check
│   ├── validate_gender_codes.R   # Invalid gender codes check
│   ├── validate_attendance.R     # Attendance range check
│   ├── validate_stage_mismatch.R # Stage/school type mismatch check
│   ├── validate_dates.R          # Future/implausible date check
│   └── run_all_checks.R          # Orchestrates all checks
├── data/
│   ├── raw/                      # Input data (Excel files)
│   ├── interim/                  # Intermediate outputs
│   └── processed/                # Processed datasets
├── reports/
│   ├── validation_report.qmd     # Quarto report template
│   └── validation_report.html    # Rendered HTML report
└── docs/                         # Additional documentation
```

## Tech stack

- [`targets`](https://docs.ropensci.org/targets/) — pipeline orchestration
- [`tarchetypes`](https://docs.ropensci.org/tarchetypes/) — Quarto integration with targets
- [`tidyverse`](https://www.tidyverse.org/) — data manipulation
- [`rlang`](https://rlang.r-lib.org/) — tidy evaluation for reusable functions
- [`quarto`](https://quarto.org/) — automated report generation
- [`renv`](https://rstudio.github.io/renv/) — package reproducibility

## Reusability

Each validation function is designed to be dataset-agnostic. Column 
names are passed as arguments rather than hardcoded, so the functions 
can be applied to any structured administrative dataset by updating 
`R/config.R` and `R/run_all_checks.R`.

## License

MIT
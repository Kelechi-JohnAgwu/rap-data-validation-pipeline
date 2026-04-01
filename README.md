# Reproducible Data Validation Pipeline (R)

A production-style R pipeline for validating administrative datasets, applying 
quality checks, and generating automated HTML reports in a reproducible way. 
Built following the principles of 
[Reproducible Analytical Pipelines (RAP)](https://analysisfunction.civilservice.gov.uk/support/reproducible-analytical-pipelines/).

<!-- badges: start -->
[![R-CMD-check](https://github.com/Kelechi-JohnAgwu/rap-data-validation-pipeline/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Kelechi-JohnAgwu/rap-data-validation-pipeline/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Overview

This pipeline provides a reusable, modular framework for validating structured 
administrative datasets. The same validation functions work across different 
datasets — column names are passed as arguments rather than hardcoded, making 
the framework dataset-agnostic.

The pipeline currently supports two datasets:

| Dataset | Domain | Checks |
|---|---|---|
| Scottish pupils | Education | 6 checks |
| Temporary accommodation | Housing | 5 checks |

## Validation checks

### Core checks (reusable across all datasets)

- **Duplicate IDs** — detects records sharing the same identifier
- **Missing values** — flags nulls across configurable required fields
- **Invalid codes** — validates coded fields against accepted values
- **Attendance / numeric range** — catches values outside expected bounds
- **Future or implausible dates** — identifies dates that are in the future

### Domain-specific checks (temporary accommodation)

- **Multiple accepted accommodation types** — flags any `hl3appref` where more 
  than one accommodation type was accepted (type value = 2)
- **Not offered inconsistency** — validates that `notoffrd = 1` only when all 
  type fields are 0, and `notoffrd = 0` when at least one type is filled

## How the pipeline works

The pipeline is defined in `_targets.R` and runs both datasets in sequence:

**Pupils pipeline**
1. `raw_file` — tracks the input Excel file for changes
2. `df` — reads the raw dataset into R
3. `validation_results` — runs all six checks and collects results
4. `validation_summary` — extracts a PASS/FAIL summary table
5. `validation_report` — renders an automated HTML report

**Temporary accommodation pipeline**
1. `raw_file_temp` — tracks the input Excel file for changes
2. `df_temp` — reads the raw dataset into R
3. `validation_results_temp` — runs all five checks and collects results
4. `validation_summary_temp` — extracts a PASS/FAIL summary table

The `targets` package ensures only steps affected by changes in the input 
data are re-run, making the pipeline efficient and auditable.

## Getting started

**1. Clone the repository**
```bash
git clone https://github.com/Kelechi-JohnAgwu/rap-data-validation-pipeline.git
```

**2. Restore the package environment**
```r
renv::restore()
```

**3. Add your dataset to `data/raw/`**

**4. Run the pipeline**
```r
targets::tar_make()
```

**5. View results**
```r
targets::tar_load(validation_summary)
validation_summary

targets::tar_load(validation_summary_temp)
validation_summary_temp
```

**6. View the HTML report**

Open `reports/validation_report.html` in your browser.

## Project structure
```
├── _targets.R                      # Pipeline definition
├── renv.lock                       # Package version lockfile
├── R/
│   ├── config.R                    # Centralised configuration
│   ├── validate_duplicates.R       # Duplicate ID check
│   ├── validate_missing.R          # Missing values check
│   ├── validate_gender_codes.R     # Invalid gender codes check
│   ├── validate_attendance.R       # Numeric range check
│   ├── validate_stage_mismatch.R   # Stage/school type mismatch check
│   ├── validate_dates.R            # Future/implausible date check
│   ├── validate_la_codes.R         # Invalid LA code check
│   ├── validate_type_codes.R       # Multiple accepted types check
│   ├── validate_notoffrd.R         # Not offered inconsistency check
│   └── run_all_checks.R            # Orchestrates all checks per dataset
├── data/
│   ├── raw/                        # Input data (Excel files)
│   ├── interim/                    # Intermediate outputs
│   └── processed/                  # Processed datasets
├── reports/
│   ├── validation_report.qmd       # Quarto report template
│   └── validation_report.html      # Rendered HTML report
└── docs/                           # Additional documentation
```

## Reusability

Each validation function is dataset-agnostic. Column names are passed as 
arguments using tidy evaluation (`{{}}` and `ensyms()`) rather than 
hardcoded, so the same functions work across any structured administrative 
dataset. To apply the pipeline to a new dataset, add a new orchestrating 
function in `R/run_all_checks.R` and wire it into `_targets.R`.

## Tech stack

- [`targets`](https://docs.ropensci.org/targets/) — pipeline orchestration
- [`tarchetypes`](https://docs.ropensci.org/tarchetypes/) — Quarto integration
- [`tidyverse`](https://www.tidyverse.org/) — data manipulation
- [`rlang`](https://rlang.r-lib.org/) — tidy evaluation
- [`quarto`](https://quarto.org/) — automated report generation
- [`renv`](https://rstudio.github.io/renv/) — package reproducibility

## Blog post

Read the write-up on Medium:
[Building a Production-Style Data Validation Pipeline in R](https://medium.com/@kelechiagwu16/building-a-production-style-data-validation-pipeline-in-r-2985a249eab9)

## License

MIT
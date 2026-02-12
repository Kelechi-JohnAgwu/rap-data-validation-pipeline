# Reproducible Data Validation Pipeline (R)

A production-style R pipeline for validating administrative datasets, applying quality checks, and generating automated outputs (tables/reports/logs) in a reproducible way.

## Why this exists
This project demonstrates how to:
- run repeatable validation checks on structured data
- track issues clearly (what failed, why, where)
- produce consistent outputs and logs for auditability
- structure an R project like a production pipeline

## What it does (planned)
- Ingest: read input files from `data/raw/`
- Validate: schema checks, missingness, ranges, duplicates, date logic
- Transform: standardise fields and types
- Outputs: cleaned dataset + error report + summary tables

## Tech stack (planned)
- `targets` for orchestration
- `fs` / `here` for file management
- `validate` or custom rules for checks
- `openxlsx` for Excel outputs (optional)
- `testthat` for unit tests

## Project structure
├─ _targets.R # Pipeline definition and dependency graph
├─ R/
│ ├─ 00_setup.R # Project setup (packages, project root)
│ ├─ helpers_files.R # Reusable helper functions
│ └─ 01_load_raw_data.R # Interactive workflow script (optional)
│
├─ data/
│ ├─ raw/ # Raw input data (e.g. Excel files)
│ ├─ interim/ # Intermediate data (if required)
│ └─ processed/ # Processed datasets created by the pipeline
│
├─ reports/ # Final outputs and summary files
├─ docs/ # Project documentation
├─ README.md
├─ .gitignore
└─ LICENSE

## Getting started
1. Open the project in RStudio using the `.Rproj` file.
2. Ensure required packages are installed.
3. Run the pipeline from the project root:

```r
targets::tar_make()

To inspect intermediate outputs:

targets::tar_read(students_clean)

```markdown
## How the pipeline works

The pipeline is defined in `_targets.R` and consists of the following steps:

1. **raw_files**  
   Detects and tracks files placed in `data/raw/`.

2. **students**  
   Reads the `students.xlsx` file into R as a tibble.

3. **students_clean**  
   Performs basic data cleaning (e.g. standardising column names).

4. **students_csv**  
   Writes the cleaned dataset to `data/processed/students_clean.csv`.

5. **students_summary / students_summary_csv**  
   Produces a simple summary and writes it to `reports/students_summary.csv`.

The `targets` package ensures that only steps affected by changes in the input
data are re-run.
 

## Project status
This project is currently under development.

# _targets.R

library(targets)
library(tidyverse)
library(readxl)

# Source all validation functions
tar_source("R/")

# Pipeline definition
list(
  
  # Step 1 — track the raw data file
  tar_target(
    raw_file,
    "data/raw/pupils.xlsx",
    format = "file"
  ),
  
  # Step 2 — load the data
  tar_target(
    df,
    read_excel(raw_file)
  ),
  
  # Step 3 — run all validation checks
  tar_target(
    validation_results,
    run_all_checks(df)
  ),
  
  # Step 4 — extract the summary table
  tar_target(
    validation_summary,
    validation_results$summary
  )
  
)

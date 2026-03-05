# _targets.R

library(targets)
library(tarchetypes)
library(tidyverse)
library(readxl)

# Source all validation functions
tar_source("R/")

# Pipeline definition
list(
  
  # --- Pupils pipeline ---
  tar_target(raw_file, "data/raw/pupils.xlsx", format = "file"),
  tar_target(df, read_excel(raw_file)),
  tar_target(validation_results, run_all_checks(df)),
  tar_target(validation_summary, validation_results$summary),
  tar_quarto(validation_report, path = "reports/validation_report.qmd"),
  
  # --- Temporary accommodation pipeline ---
  tar_target(raw_file_temp, "data/raw/temp_accom_v2.xlsx", format = "file"),
  tar_target(df_temp, read_excel(raw_file_temp)),
  tar_target(validation_results_temp, run_temp_accom_checks(df_temp)),
  tar_target(validation_summary_temp, validation_results_temp$summary)
  
)
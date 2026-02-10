# Load raw data ------------------------------------------------------------

source("R/00_setup.R")

# Example: list files in data/raw
raw_files <- list.files(
  here("data", "raw"),
  full.names = TRUE
)

raw_files

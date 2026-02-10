# Load raw data ------------------------------------------------------------

source("R/00_setup.R")

load_raw_files <- function(path = here("data", "raw")) {

  files <- list.files(
    path,
    full.names = TRUE
  )

  return(files)
}

# Run once interactively
raw_files <- load_raw_files()
raw_files

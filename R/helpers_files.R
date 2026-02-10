# File helpers -------------------------------------------------------------

source("R/00_setup.R")

load_raw_files <- function(path = here("data", "raw")) {

  files <- list.files(
    path,
    full.names = TRUE
  )

  return(files)
}


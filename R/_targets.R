# targets pipeline ---------------------------------------------------------

library(targets)

source("R/00_setup.R")
source("R/helpers_files.R")

tar_option_set(
  packages = c("tidyverse", "here")
)

list(
  tar_target(
    raw_files,
    load_raw_files()
  )
)

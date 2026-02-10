# targets pipeline ---------------------------------------------------------

library(targets)

source("R/00_setup.R")
source("R/helpers_files.R")
source("R/01_load_raw_data.R")

tar_option_set(
  packages = c("tidyverse", "here")
)

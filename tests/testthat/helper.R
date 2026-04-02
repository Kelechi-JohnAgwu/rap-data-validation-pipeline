library(dplyr)
library(tibble)
library(purrr)
library(tidyr)

# Load validate functions
root <- rprojroot::find_root(rprojroot::has_file("DESCRIPTION"))
source(file.path(root, "R/validate_duplicates.R"))
source(file.path(root, "R/validate_missing.R"))  


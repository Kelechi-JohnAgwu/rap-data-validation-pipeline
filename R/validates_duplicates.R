# R/validate_duplicates.R
# Checks for duplicate pupil_id values in the dataset

check_duplicate_ids <- function(df) {
  
  duplicates <- df |>
    dplyr::group_by(pupil_id) |>
    dplyr::filter(dplyr::n() > 1) |>
    dplyr::arrange(pupil_id) |>
    dplyr::ungroup()
  
  list(
    check_name   = "duplicate_pupil_ids",
    status       = ifelse(nrow(duplicates) == 0, "PASS", "FAIL"),
    n_issues     = nrow(duplicates),
    affected_ids = unique(duplicates$pupil_id),
    detail       = duplicates
  )
  
}

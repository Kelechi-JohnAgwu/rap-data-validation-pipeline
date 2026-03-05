# R/validate_duplicates.R

check_duplicate_ids <- function(df, id_col) {
  
  id_name <- rlang::as_string(ensym(id_col))
  
  duplicates <- df |>
    group_by({{id_col}}) |>
    filter(n() > 1) |>
    arrange({{id_col}}) |>
    ungroup()
  
  list(
    check_name   = paste0("duplicate_", id_name),
    status       = if_else(nrow(duplicates) == 0, "PASS", "FAIL"),
    n_issues     = nrow(duplicates),
    affected_ids = duplicates |> distinct({{id_col}}) |> pull(1),
    detail       = duplicates
  )
  
}
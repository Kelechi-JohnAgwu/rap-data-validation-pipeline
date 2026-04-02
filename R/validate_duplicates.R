# R/validate_duplicates.R

#' Check for duplicate IDs in a dataset
#'
#' Identifies rows where an ID column contains duplicate values.
#' Used to ensure each record in the dataset is uniquely identifiable.
#'
#' @param df A dataframe containing the data to validate
#' @param id_col The unquoted name of the column to check for duplicates
#'
#' @return A named list with the following elements:
#' \describe{
#'   \item{check_name}{Name of the check, e.g. "duplicate_pupil_id"}
#'   \item{status}{Either "PASS" or "FAIL"}
#'   \item{n_issues}{Number of duplicate rows found}
#'   \item{affected_ids}{Vector of IDs that are duplicated}
#'   \item{detail}{A dataframe of the duplicate rows}
#' }
#' @export
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
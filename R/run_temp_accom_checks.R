
#' Run all validation checks on a temporary accommodation dataset
#'
#' Orchestrates all validation checks for the Scottish Government
#' homelessness dataset.
#'
#' @param df A dataframe containing the pupils data to validate
#'
#' @return A named list with the following elements:
#' \describe{
#'   \item{summary}{A dataframe showing each check name, status (PASS/FAIL) and number of issues}
#'   \item{details}{A list of full results from each individual check, including affected rows}
#' }
#' @export

run_temp_accom_checks <- function(df) {
  
  results <- list(
    check_duplicate_ids(df, id_col = hl3appref),
    check_missing_values(df, lacode, appref, hl3appref, offrdate),
    check_date_validity(df, offrdate, entrydate, exitdate),
    check_multiple_accepted(
      df,
      id_col = hl3appref,
      type1, type2, type3, type4, type5, type6, type7, type8, type9
    ),
    check_notoffrd_consistency(
      df,
      notoffrd_col = notoffrd,
      type1, type2, type3, type4, type5, type6, type7, type8, type9
    )
  )
  
  summary <- results |>
    purrr::map_dfr(~ tibble(
      check_name = .x$check_name,
      status     = .x$status,
      n_issues   = .x$n_issues
    ))
  
  list(
    summary = summary,
    details = results
  )
  
}

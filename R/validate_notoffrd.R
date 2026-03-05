# R/validate_notoffrd.R
# Checks that notoffrd = 1 only when all type1-type9 are 0
# and notoffrd = 0 when at least one type is filled (1 or 2)

check_notoffrd_consistency <- function(df, notoffrd_col, ...) {
  
  type_cols <- ensyms(...) |> purrr::map_chr(rlang::as_string)
  
  invalid_rows <- df |>
    mutate(
      any_type_filled = rowSums(across(all_of(type_cols), ~ . > 0)) > 0
    ) |>
    filter(
      ({{notoffrd_col}} == 1 & any_type_filled) |
        ({{notoffrd_col}} == 0 & !any_type_filled)
    )
  
  list(
    check_name = "notoffrd_inconsistency",
    status     = if_else(nrow(invalid_rows) == 0, "PASS", "FAIL"),
    n_issues   = nrow(invalid_rows),
    detail     = invalid_rows
  )
  
}
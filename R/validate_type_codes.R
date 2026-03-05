# R/validate_type_codes.R
# Checks that no hl3appref has more than one accommodation type accepted (value = 2)

check_multiple_accepted <- function(df, id_col, ...) {
  
  type_cols <- ensyms(...) |> purrr::map_chr(rlang::as_string)
  
  invalid_rows <- df |>
    mutate(n_accepted = rowSums(across(all_of(type_cols), ~ . == 2))) |>
    filter(n_accepted > 1)
  
  list(
    check_name    = "multiple_accepted_accommodation_types",
    status        = if_else(nrow(invalid_rows) == 0, "PASS", "FAIL"),
    n_issues      = nrow(invalid_rows),
    affected_ids  = invalid_rows |> distinct({{id_col}}) |> pull(1),
    detail        = invalid_rows
  )
  
}



# R/validate_gender_codes.R

check_gender_codes <- function(df, gender_col, valid_codes) {
  
  invalid_rows <- df |>
    filter(!{{gender_col}} %in% valid_codes)
  
  list(
    check_name  = "invalid_gender_codes",
    status      = if_else(nrow(invalid_rows) == 0, "PASS", "FAIL"),
    n_issues    = nrow(invalid_rows),
    found_codes = invalid_rows |> distinct({{gender_col}}) |> pull(1),
    valid_codes = valid_codes,
    detail      = invalid_rows
  )
  
}

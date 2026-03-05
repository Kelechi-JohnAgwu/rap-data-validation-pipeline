# R/validate_la_codes.R

check_la_codes <- function(df, la_col, valid_codes) {
  
  invalid_rows <- df |>
    filter(!{{la_col}} %in% valid_codes)
  
  invalid_summary <- invalid_rows |>
    distinct({{la_col}}) |>
    pull(1)
  
  list(
    check_name    = "invalid_la_codes",
    status        = if_else(nrow(invalid_rows) == 0, "PASS", "FAIL"),
    n_issues      = nrow(invalid_rows),
    invalid_codes = invalid_summary,
    valid_codes   = valid_codes,
    detail        = invalid_rows
  )
  
}
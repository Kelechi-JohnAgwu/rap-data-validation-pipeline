# R/validate_attendance.R

check_attendance_range <- function(df, attendance_col, min_val = 0, max_val = 100) {
  
  invalid_rows <- df |>
    filter(!between({{attendance_col}}, min_val, max_val))
  
  list(
    check_name = "attendance_out_of_range",
    status     = if_else(nrow(invalid_rows) == 0, "PASS", "FAIL"),
    n_issues   = nrow(invalid_rows),
    min_val    = min_val,
    max_val    = max_val,
    detail     = invalid_rows
  )
  
}

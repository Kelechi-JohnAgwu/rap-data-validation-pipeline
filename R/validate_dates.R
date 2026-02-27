# R/validate_dates.R

check_date_validity <- function(df, ..., reference_date = Sys.Date()) {
  
  date_fields <- ensyms(...) |> purrr::map_chr(rlang::as_string)
  
  invalid_rows <- df |>
    filter(
      if_any(all_of(date_fields), ~ as.Date(.x) > reference_date)
    )
  
  invalid_summary <- df |>
    select(all_of(date_fields)) |>
    summarise(across(everything(), ~ sum(as.Date(.x) > reference_date, na.rm = TRUE))) |>
    pivot_longer(everything(), names_to = "field", values_to = "n_future_dates") |>
    filter(n_future_dates > 0)
  
  list(
    check_name       = "future_dates",
    status           = if_else(nrow(invalid_rows) == 0, "PASS", "FAIL"),
    n_issues         = nrow(invalid_rows),
    reference_date   = reference_date,
    invalid_by_field = invalid_summary,
    detail           = invalid_rows
  )
  
}

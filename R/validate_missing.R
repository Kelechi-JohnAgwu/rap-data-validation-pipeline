# R/validate_missing.R

check_missing_values <- function(df, ...) {
  
  required_fields <- ensyms(...) |> purrr::map_chr(rlang::as_string)
  
  missing_summary <- df |>
    select(all_of(required_fields)) |>
    summarise(across(everything(), ~ sum(is.na(.)))) |>
    pivot_longer(everything(), names_to = "field", values_to = "n_missing") |>
    filter(n_missing > 0)
  
  affected_rows <- df |>
    filter(if_any(all_of(required_fields), is.na))
  
  list(
    check_name       = "missing_required_fields",
    status           = if_else(nrow(missing_summary) == 0, "PASS", "FAIL"),
    n_issues         = nrow(affected_rows),
    missing_by_field = missing_summary,
    detail           = affected_rows
  )
  
}

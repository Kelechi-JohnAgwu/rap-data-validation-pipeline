# R/validate_stage_mismatch.R

check_stage_mismatch <- function(df, school_type_col, stage_col,
                                  primary_stages, secondary_stages) {
  
  invalid_rows <- df |>
    filter(
      ({{school_type_col}} == "Primary"   & !{{stage_col}} %in% primary_stages) |
      ({{school_type_col}} == "Secondary" & !{{stage_col}} %in% secondary_stages)
    )
  
  list(
    check_name = "stage_school_type_mismatch",
    status     = if_else(nrow(invalid_rows) == 0, "PASS", "FAIL"),
    n_issues   = nrow(invalid_rows),
    detail     = invalid_rows
  )
  
}

# R/run_all_checks.R

run_all_checks <- function(df) {
  
  results <- list(
    check_duplicate_ids(df, id_col = pupil_id),
    check_missing_values(df, pupil_id, date_of_birth, gender, ethnicity),
    check_gender_codes(df, gender_col = gender, valid_codes = c("M", "F", "X")),
    check_attendance_range(df, attendance_col = attendance_rate),
    check_stage_mismatch(df,
      school_type_col  = school_type,
      stage_col        = stage,
      primary_stages   = c("P1","P2","P3","P4","P5","P6","P7"),
      secondary_stages = c("S1","S2","S3","S4","S5","S6")
    ),
    check_date_validity(df, date_of_birth, date_enrolled)
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

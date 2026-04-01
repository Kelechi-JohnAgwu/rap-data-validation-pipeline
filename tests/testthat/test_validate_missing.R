# tests/testthat/test_validate_missing.R

library(testthat)
source("R/validate_missing.R")

# --- Test data ---

clean_df <- tibble(
  pupil_id      = c("SC001", "SC002", "SC003"),
  date_of_birth = c("2010-01-01", "2011-05-15", "2012-03-22"),
  gender        = c("M", "F", "X"),
  ethnicity     = c("White Scottish", "Asian Scottish", "African")
)

dirty_df <- tibble(
  pupil_id      = c("SC001", "SC002", "SC003", "SC004"),
  date_of_birth = c("2010-01-01", NA, "2012-03-22", NA),
  gender        = c("M", "F", NA, "X"),
  ethnicity     = c("White Scottish", NA, "African", "Mixed")
)

empty_df <- tibble(
  pupil_id      = character(),
  date_of_birth = character(),
  gender        = character(),
  ethnicity     = character()
)

# --- Tests ---

test_that("check_missing_values returns PASS when no missing values", {
  result <- check_missing_values(clean_df, pupil_id, date_of_birth, gender, ethnicity)
  expect_equal(result$status, "PASS")
  expect_equal(result$n_issues, 0)
})

test_that("check_missing_values returns FAIL when missing values exist", {
  result <- check_missing_values(dirty_df, pupil_id, date_of_birth, gender, ethnicity)
  expect_equal(result$status, "FAIL")
  expect_gt(result$n_issues, 0)
})

test_that("check_missing_values correctly identifies affected fields", {
  result <- check_missing_values(dirty_df, pupil_id, date_of_birth, gender, ethnicity)
  expect_contains(result$missing_by_field$field, c("date_of_birth", "gender", "ethnicity"))
})

test_that("check_missing_values handles empty dataframe", {
  result <- check_missing_values(empty_df, pupil_id, date_of_birth, gender, ethnicity)
  expect_equal(result$status, "PASS")
  expect_equal(result$n_issues, 0)
})
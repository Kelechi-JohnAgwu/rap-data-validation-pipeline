# tests/testthat/test_validate_duplicates.R

# tests/testthat/test_validate_duplicates.R

library(testthat)
source("../../R/validate_duplicates.R")

# --- Test data ---

clean_df <- tibble(
  pupil_id = c("SC001", "SC002", "SC003", "SC004", "SC005"),
  name     = c("Alice", "Bob", "Carol", "David", "Eve")
)

dirty_df <- tibble(
  pupil_id = c("SC001", "SC001", "SC002", "SC003", "SC003"),
  name     = c("Alice", "Alice", "Bob", "Carol", "Carol")
)

empty_df <- tibble(
  pupil_id = character(),
  name     = character()
)

# --- Tests ---

test_that("check_duplicate_ids returns PASS when no duplicates", {
  result <- check_duplicate_ids(clean_df, id_col = pupil_id)
  expect_equal(result$status, "PASS")
  expect_equal(result$n_issues, 0)
})

test_that("check_duplicate_ids returns FAIL when duplicates exist", {
  result <- check_duplicate_ids(dirty_df, id_col = pupil_id)
  expect_equal(result$status, "FAIL")
  expect_equal(result$n_issues, 4)
})

test_that("check_duplicate_ids returns correct affected IDs", {
  result <- check_duplicate_ids(dirty_df, id_col = pupil_id)
  expect_contains(result$affected_ids, c("SC001", "SC003"))
})

test_that("check_duplicate_ids handles empty dataframe", {
  result <- check_duplicate_ids(empty_df, id_col = pupil_id)
  expect_equal(result$status, "PASS")
  expect_equal(result$n_issues, 0)
})
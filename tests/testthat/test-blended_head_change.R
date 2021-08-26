test_that("blended_head_change works", {

  transmissivity <- c(1, 1)           # random T distribution
  head_1 <- c(1,3)                    # decreasing head with depth
  head_2 <- c(1,5)                    # decreasing head with depth

  expect_equal(blended_head_change(transmissivity, head_1, head_2), 1)

})

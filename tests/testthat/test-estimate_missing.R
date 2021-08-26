test_that("estimate missing works", {

  partial_transmissivity <- 1
  missing_transmissivity <-
    estimate_missing(blended = 0,
                     transmissivity = c(partial_transmissivity, NA_real_),
                     head = c(0.4, -1.9))
  # missing_transmissivity / (partial_transmissivity + missing_transmissivity)

  expect_equal(estimate_blended_head(transmissivity = c(partial_transmissivity, missing_transmissivity),
                                     head = c(0.4, -1.9)), 0)

  expect_equal(estimate_missing(blended = 0,
                                transmissivity = c(partial_transmissivity, missing_transmissivity),
                                head = c(0.4, NA_real_)), -1.9)



})

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

  expect_equal(estimate_missing(blended = NA_real_,
                                transmissivity = c(partial_transmissivity, missing_transmissivity),
                                head = c(0.4, -1.9)),
                                estimate_blended_head(c(partial_transmissivity, missing_transmissivity),
                                                      head = c(0.4, -1.9)))

  expect_error(estimate_missing(blended = NA_real_,
                                transmissivity = c(partial_transmissivity, NA_real_),
                                head = c(0.4, NA_real_)))

  expect_error(estimate_missing(blended = 0,
                                transmissivity = c(partial_transmissivity, NA_real_),
                                head = c(0.4, NA_real_)))

  expect_error(estimate_missing(blended = NA_real_,
                                transmissivity = c(partial_transmissivity, NA_real_),
                                head = c(0.4, -1.9)))

  expect_error(estimate_missing(blended = NA_real_,
                                transmissivity = c(partial_transmissivity, missing_transmissivity),
                                head = c(0.4, NA_real_)))

  set.seed(123)
  partial_transmissivity <- abs(rnorm(10))
  partial_head <- rnorm(10)
  blended_partial <- estimate_blended_head(partial_transmissivity, partial_head)


  expect_equal(
    estimate_missing(blended = 0,
                     transmissivity = c(partial_transmissivity, NA_real_),
                     head = c(partial_head, -1)),
    estimate_missing(blended = 0,
                     transmissivity = c(sum(partial_transmissivity), NA_real_),
                     head = c(blended_partial, -1))
  )

  missing_transmissivity <- estimate_missing(blended = 0,
                   transmissivity = c(partial_transmissivity, NA_real_),
                   head = c(partial_head, -1))

  expect_equal(
    estimate_blended_head(transmissivity = c(partial_transmissivity, missing_transmissivity),
                          head = c(partial_head, -1)),
    0
  )


})

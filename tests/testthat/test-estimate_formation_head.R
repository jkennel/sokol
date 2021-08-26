test_that("estimate formation head works", {

  expect_equal(estimate_formation_head(cumsum(c(1, 1)),
                                       c(1, 2))[2], 3)


  transmissivity <- abs(rnorm(10, sd = 100))       # random T distribution
  cumulative_transmissivity <- cumsum(transmissivity)
  head <- sort(rnorm(10))                          # decreasing head with depth

  formation_head <- estimate_formation_head(cumulative_transmissivity, head)
  expect_equal(estimate_blended_head(transmissivity[1:3], formation_head[1:3]),
               head[3])

})

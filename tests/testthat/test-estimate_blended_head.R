test_that("estimate blended head works", {
  transmissivity <- c(1e-3, 1e-3)
  head <- c(1, 1)
  expect_equal(estimate_blended_head(transmissivity, head),
               head[1])

  head <- head + c(0.5, -0.5)
  expect_equal(estimate_blended_head(transmissivity, head),
               mean(head))


  transmissivity <- c(1e-3, 1e-3, 1e-4)
  head <- c(1, 1, 0.1)
  h1 <- estimate_blended_head(transmissivity, head)
  transmissivity <- c(2e-3, 1e-4)
  head <- c(1, 0.1)
  h2 <- estimate_blended_head(transmissivity, head)
  expect_equal(h1, h2)


  transmissivity <- c(1e-3, 1e-3, 1e-4)
  head <- c(1, -1, 0.1)
  h1 <- estimate_blended_head(transmissivity, head)
  transmissivity <- c(2e-3, 1e-4)
  head <- c(0, 0.1)
  h2 <- estimate_blended_head(transmissivity, head)
  expect_equal(h1, h2)


  transmissivity <- c(2e-4, 1e-5)
  head <- c(0, 0.1)
  h2 <- estimate_blended_head(transmissivity, head)
  expect_equal(h1, h2)

})

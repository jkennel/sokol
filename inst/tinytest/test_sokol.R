
# Placeholder with simple test
transmissivity <- c(1e-3, 1e-3)
head <- c(1, 1)
expect_equal(estimate_blended_head(transmissivity, head),
            head[1])

head <- head + c(0.5, -0.5)
expect_equal(estimate_blended_head(transmissivity, head),
             mean(head))


# multiple values ---------------------------------------------------------

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


# estimate_formation_head -------------------------------------------------

expect_equal(estimate_formation_head(cumsum(c(1, 1)),
                                     c(1, 2))[2], 3)


transmissivity <- abs(rnorm(10, sd = 100))       # random T distribution
cumulative_transmissivity <- cumsum(transmissivity)
head <- sort(rnorm(10))                          # decreasing head with depth

formation_head <- estimate_formation_head(cumulative_transmissivity, head)
expect_equal(estimate_blended_head(transmissivity[1:3], formation_head[1:3]),
             head[3])



# estimate_missing

# missing transmissivity
partial_transmissivity <- 1
missing_transmissivity <-
  estimate_missing(blended = 0,
                   transmissivity = c(partial_transmissivity, NA_real_),
                   head = c(0.4, -1.9))
# missing_transmissivity / (partial_transmissivity + missing_transmissivity)

expect_equal(estimate_blended_head(transmissivity = c(partial_transmissivity, missing_transmissivity),
                      head = c(0.4, -1.9)), 0)

# missing head
expect_equal(estimate_missing(blended = 0,
                              transmissivity = c(partial_transmissivity, missing_transmissivity),
                              head = c(0.4, NA_real_)), -1.9)


# blended_head_change

transmissivity <- c(1, 1)           # random T distribution
head_1 <- c(1,3)                    # decreasing head with depth
head_2 <- c(1,5)                    # decreasing head with depth

expect_equal(blended_head_change(transmissivity, head_1, head_2), 1)

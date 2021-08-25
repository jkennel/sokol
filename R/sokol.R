# library(sokol)
# library(data.table)
# library(ggplot2)
# library(patchwork)
# head <- rnorm(50)
# transmissivity = abs(rnorm(50))
# blended_val <- estimate_blended(transmissivity, head)
#
# head <- c(0, 1)
# transmissivity <- c(1, 1)
# blended_1 <- 0.5
# blended_2 <- 0.49
# transmissivity_change(transmissivity,
#                       head,
#                       blended_1,
#                       blended_2,
#                       to_change = 1)
#
# head <- c(0, 1)
# transmissivity <- c(1, 1)
# estimate_blended(transmissivity, head)
# head <- c(0, 1)
# transmissivity <- c(1.040816, 1)
# estimate_blended(transmissivity, head)
#
#
#
# # testing
# library(testthat)
#
# # same values -------------------------------------------------------------
# transmissivity <- c(1e-3, 1e-3)
# head <- c(1, 1)
# expect_equal(estimate_blended(transmissivity, head),
#             head[1])
#
#
# # average head ------------------------------------------------------------
# head <- head + c(0.5, -0.5)
# expect_equal(estimate_blended(transmissivity, head),
#              mean(head))
#
#
# # multiple values ---------------------------------------------------------
#
# transmissivity <- c(1e-3, 1e-3, 1e-4)
# head <- c(1, 1, 0.1)
# h1 <- estimate_blended(transmissivity, head)
# transmissivity <- c(2e-3, 1e-4)
# head <- c(1, 0.1)
# h2 <- estimate_blended(transmissivity, head)
# expect_equal(h1, h2)
#
#
# transmissivity <- c(1e-3, 1e-3, 1e-4)
# head <- c(1, -1, 0.1)
# h1 <- estimate_blended(transmissivity, head)
# transmissivity <- c(2e-3, 1e-4)
# head <- c(0, 0.1)
# h2 <- estimate_blended(transmissivity, head)
# expect_equal(h1, h2)
#
#
# transmissivity <- c(2e-4, 1e-5)
# head <- c(0, 0.1)
# h2 <- estimate_blended(transmissivity, head)
# expect_equal(h1, h2)
#
#
# # estimate_formation_head -------------------------------------------------
#
# expect_equal(estimate_formation_head(c(1, 1), c(1, 2))[2], 3)
#
#
# # estimate_missing --------------------------------------------------------
#
# estimate_missing(blended = 0,
#                  transmissivity = c(1.0, NA_real_),
#                  head = c(0.11, -1.2))
#
#
#
#
#
#
# transmissivity <- c(2e-4 - 1e-5, 1e-5)
# head <- c(0, 0.1)
#
# estimate_blended(transmissivity, head)
#
# estimate_missing(0.43, c(1, NA), c(0, -1.78))
# estimate_missing(0.18, c(1, NA), c(0, -1.78))
# estimate_missing(0.065, c(1, NA), c(0, -1.78))
# estimate_missing(0.078, c(1, NA), c(0, -1.78))
#
# estimate_missing(0.2, c(1, NA), c(0, -1.78))
#
#
#
#
#
# plot_blended(transmissivity, head)
# blended_change(transmissivity, head, head + c(rep(0, 49), 1))
# blended_change(transmissivity, head, head + c(1, rep(0, 49)))
# blended_change(transmissivity, head, head + c(-1, rep(0, 49)))
# blended_change(transmissivity, head, head + c(rep(0, 49), -1))
#
#
#
#
# a <- transmissivity[49]
# print(a)
# transmissivity[49] <- NA
# estimate_missing(blended_val, transmissivity, head)
#
# transmissivity[49] <- a
# b <- head[49]
# head[49] <- NA
# print(b)
# estimate_missing(blended_val, transmissivity, head)
#
# blended_val <- 0
# transmissivity <- c(1)
#
# print(b)
# estimate_missing(blended_val, transmissivity, head)
#
#
#
#
# a <- list(
#   list(transmissivity = c(0.5, 0.5), head = c(10, 0)),
#   list(transmissivity = c(0.6, 0.4), head = c(10, 0)),
#   list(transmissivity = c(0.1, 1.0), head = c(10, 0)),
#   list(transmissivity = c(0.01, 1.0), head = c(10, 0)),
#   list(transmissivity = c(1.0, 0.01), head = c(10, 0)),
#   list(transmissivity = c(0.5, 0.5, 0.5), head = c(10, 5, 0))
# )
#
# for(i in seq_along(a)) {
#   print(blended_sokol(a[[i]]$transmissivity, a[[i]]$head))
# }
#
#
# t1a <- 1
# t1b <- 2
# t1  <- 3
# t2  <- 5
# ttot <- t1 + t2
#
# estimate_blended(transmissivity = c(5, 1, 2),
#                  head = c(1, 0.5, 0.5)) # 0.8125
#
# transmissivity <- abs(rnorm(10, sd = 5))
# head  <- rnorm(10)
# t_tot <- sum(transmissivity)
#
# estimate_blended(transmissivity,
#                  head)
# head2 <- head
# head2[1] <- head[1] * 0.5
# estimate_blended(transmissivity,
#                  head2)
#
# t_sub <- sum(transmissivity[1:9])
# head3 <- estimate_blended(transmissivity[1:9],
#                  head2[1:9])
# head3
#
# head4 <- estimate_blended(c(t_sub, transmissivity[10]),
#                           c(head3, head2[10]))
#
#
# transmissivity[10]
# head[10]
#
#
#
# transmissivity[10]
# head[10]
#
#
#
#
#
# t_above <- 30
# m1 <- estimate_missing(blended = 0,
#                  transmissivity = c(t_above, NA_real_),
#                  head = c(0.11, -1.9))
#
# m2 <- estimate_missing(blended = 0,
#                  transmissivity = c(t_above, NA_real_),
#                  head = c(0.11, -1.9))
#
# m3 <- estimate_missing(blended = 0,
#                  transmissivity = c(t_above, NA_real_),
#                  head = c(0.19, -1.9))
#
# m4 <- estimate_missing(blended = 0,
#                  transmissivity = c(t_above, NA_real_),
#                  head = c(0.4, -1.9))
#
# round(c(m1, m2, m3, m4) / (t_above + c(m1, m2, m3, m4)), 2)
#
# plot_blended(transmissivity = c(t_above, m3), head = c(0.19, -1.7))
#
#
#
# t1a/t1
# t1a/ttot

test_that("plot_blended works", {
  expect_type(plot_blended(c(1,2), c(1,2)), 'list')
  expect_s3_class(plot_blended(c(1,2), c(1,2)), 'patchwork')
  expect_s3_class(plot_blended(c(1,2), c(1,2)), 'gg')
  expect_s3_class(plot_blended(c(1,2), c(1,2)), 'ggplot')
})

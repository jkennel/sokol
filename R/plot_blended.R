#' Plot the head and transmissivity with the blended head
#'
#' `plot_blended` takes a vector of transmissivity and a vector of
#' hydraulic head and calculates the expected blended head for a
#' cross-connected well and returns a ggplot2 object. The length units for
#' transmissivity and hydraulic head should be the same.
#'
#' @inheritParams estimate_missing
#' @return a ggplot of the transmissivity and head
#' @family {blended head methods}
#' @export
#' @details The plotting function usese `estimate_blended_head` to calculate
#'   the blended head value.  The blended head is plotted with a dashed line.
#'
#' @references Sokol, D. (1963). Position and fluctuations of water level in
#'   wells perforated in more than one aquifer. Journal of Geophysical Research,
#'   68(4), 1079-1080.
#'
#' @examples
#' transmissivity <- abs(rnorm(10, sd = 100))       # random T distribution
#' head <- sort(rnorm(10))                          # decreasing head with depth
#'
#' plot_blended(transmissivity, head)
plot_blended <- function(transmissivity, head) {

  Intervals <- Transmissivity <- Head <- value <- top <- NULL   # CRAN note

  if(length(transmissivity) != length(head)) {
    stop('Lengths of transmissivity and head must be equal')
  }

  n <- length(transmissivity)

  intervals   <- as.integer(seq.int(n))
  blended_val <- estimate_blended_head(transmissivity, head)
  dat         <- data.table(Intervals = intervals,
                            Transmissivity = transmissivity,
                            Head = head,
                            Leverage = transmissivity * head / sum(transmissivity)
                           )

  dat <- data.table::melt(dat, id.vars = 'Intervals')
  ann <- data.table(variable = factor(c('Head', 'Transmissivity', 'Leverage'),
                                  levels = levels(dat$variable)),
                    top = c(n, NA_integer_, NA_integer_), blended_val = c(blended_val, NA_real_, NA_real_))

  ggplot(dat, aes(y = value, x = Intervals)) +
    geom_col(fill = "#00000060") +
    coord_flip() +
    scale_x_continuous(expand = c(0,0), limits = c(0.5, n + 0.5), breaks = seq.int(n)) +
    facet_wrap(variable~., scales = 'free_x') +
    geom_hline(data = ann, aes(yintercept = blended_val), linetype = 'dashed', color = '#0000AAAA') +
    geom_text(data = ann,
             aes(x = top, y = blended_val),
             label = "Blended",
             hjust = -0.1, vjust = 0.5,
             color = '#0000AAAA',
             size = 4) +
    theme_bw()


}

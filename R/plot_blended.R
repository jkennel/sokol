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

  Intervals <- Transmissivity <- Head <- NULL   # CRAN note

  if(length(transmissivity) != length(head)) {
    stop('Lengths of transmissivity and head must be equal')
  }

  intervals   <- 1:length(transmissivity)
  blended_val <- estimate_blended_head(transmissivity, head)
  dat         <- data.table(Intervals = intervals,
                                        Transmissivity = transmissivity,
                                        Head = head)

  p1 <- ggplot(dat, aes(y = Head, x = Intervals)) +
    geom_col() +
    coord_flip() +
    geom_hline(yintercept = blended_val, linetype = 'dashed') +
    theme_bw()

  p2 <- ggplot(dat, aes(y = Transmissivity, x = intervals)) +
    geom_col() +
    coord_flip() +
    theme_bw()

  p1 + p2

}

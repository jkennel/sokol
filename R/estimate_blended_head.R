#' Calculate the transmissivity weighted blended head
#'
#' `estimate_blended_head` takes a vector of transmissivity and a vector of
#' hydraulic head and calculates the expected blended head for a
#' cross-connected well.  The length units for transmissivity and hydraulic head
#' should be the same.
#'
#' @inheritParams estimate_missing
#' @return a single value of the blended head
#' @family {blended head methods}
#' @export
#' @details `estimate_blended_head` uses the following to calculate the
#' blended head based on Sokol's 1963 equation 6:
#'
#' \deqn{h_{blended} = \frac{\sum\limits_{i=1}^{N} T_i h_i}{\sum\limits_{i=1}^{N} T_i}}
#'
#' where:
#'
#'  * \eqn{h_{blended}} is the blended head in the well
#'  * \eqn{T_i} is the transmissivity of the \eqn{i^th} interval
#'  * \eqn{h_i} is the formation head of the \eqn{i^th} interval
#'  * \eqn{i} is the interval number
#'  * \eqn{N} is the total number of intervals
#'
#' @references Sokol, D. (1963). Position and fluctuations of water level in
#'   wells perforated in more than one aquifer. Journal of Geophysical Research,
#'   68(4), 1079-1080.
#'
#' @examples
#' transmissivity <- abs(rnorm(10, sd = 100))       # random T distribution
#' head <- sort(rnorm(10))                          # decreasing head with depth
#'
#' estimate_blended_head(transmissivity, head)
estimate_blended_head <- function(transmissivity, head) {
  sum((transmissivity * head)) / sum(transmissivity)
}

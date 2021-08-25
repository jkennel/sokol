#' Calculate the transmissivity weighted blended head
#'
#' `estimate_blended_head` takes a vector of transmissivity and a vector of
#' hydraulic head and calculates the expected blended head for a
#' cross-connected well.  The length units for transmissivity and hydraulic head
#' should be the same.
#'
#' @inheritParams estimate_missing
#' @param head_1 the initial formation head distribution for each interval
#' @param head_2 the updated formation head distribution for each interval
#' @return a single value of the change in blended head
#' @family {blended head methods}
#' @export
#' @details `estimate_blended_head` uses the following to calculate the
#' blended head for each head distribution based on Sokol's 1963 equation 6:
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
#' transmissivity <- c(1, 1)           # random T distribution
#' head_1 <- c(1,3)                    # decreasing head with depth
#' head_2 <- c(1,5)                    # decreasing head with depth
#'
#' blended_head_change(transmissivity, head_1, head_2)
blended_head_change <- function(transmissivity, head_1, head_2) {
  estimate_blended_head(transmissivity, head_2) -
    estimate_blended_head(transmissivity, head_1)
}


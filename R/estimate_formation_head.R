#' Estimate formation heads given a set of transmissivity values and blended
#' head measurements.
#'
#' `estimate_formation_head` takes a vector of transmissivity and a vector of
#'   associated blended head measurements. The formation head is then
#'   determined as each interval is added. The transmissivity and blended head
#'   values should be ordered so that the monitoring interval is incrementally
#'   increased with each value. An example application would be the FLUTe
#'   reverse head methodology
#'
#' @inheritParams estimate_missing
#' @return a single value of the blended head
#' @family {blended head methods}
#' @export
#' @details `estimate_formation_head` calculates the formation head using the
#'   following formula:
#'
#' \deqn{^fh_i = \frac{\sum\limits_{i=1}^{i} \Delta T_i (^bh_i - ^fh_i)}{T_i} + ^bh_1}
#'
#' where:
#'
#'  * \eqn{h_{blended}} is the blended head in the well
#'  * \eqn{\Delta T_i} is the difference in transmissivity between increasingly
#'    larger interval.
#'  * \eqn{^fh_i} is the formation head of the newly exposed interval
#'  * \eqn{^bh_i} is the blended head of the increasingly larger interval
#'  * \eqn{^bh_1} is the blended head of the first interval
#'  * \eqn{i} is the interval number
#'
#' @references Keller, C. (2017). A New Rapid Method for Measuring the Vertical
#'   Head Profile. Groundwater, 55(2), 244-254.
#'
#' @examples
#' transmissivity <- abs(rnorm(10, sd = 100))       # random T distribution
#' cumulative_transmissivity <- cumsum(transmissivity)
#' head <- sort(rnorm(10))                          # decreasing head with depth
#'
#' formation_head <- estimate_formation_head(cumulative_transmissivity, head)
#' estimate_blended_head(transmissivity[1:3], formation_head[1:3])
estimate_formation_head <- function(transmissivity, blended) {


  n <- length(transmissivity)

  delta_transmissivity <- diff(c(0, transmissivity))
  formation_head <- rep(NA_real_, n)
  formation_head[1] <- blended[1]

  for (i in 2:n) {

    formation_head[i] = sum(
      delta_transmissivity[1:i-1] * (blended[i] - formation_head[1:i-1])) /
      delta_transmissivity[i] + blended[i]

  }

  formation_head
}


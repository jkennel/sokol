#' Calculate the transmissivity weighted blended head
#'
#' `estimate_missing` takes a single blended head value and a vector of
#'   transmissivity and a vector of hydraulic head and estimates a single
#'   missing value of transmissivity or head.  This can be useful if you know
#'   all the formation heads but are missing the transmissivity distribution, or
#'   if you know the transmissivity distribution but not all the head values.
#'   Only a single missing value can be estimated at this point.
#'
#' @param blended the blended head value
#' @param transmissivity the transmissivity distribution for each interval
#' @param head the head distribution for each interval
#'
#' @return an estimation for the missing value
#'
#' @family {blended head methods}
#' @export
#'
#' @examples
#'
#' # determine the relative magnitude of transmissivity for a zone with known
#' # head
#'
#' partial_transmissivity <- 1
#' missing_transmissivity <-
#'   estimate_missing(blended = 0,
#'                    transmissivity = c(partial_transmissivity, NA_real_),
#'                    head = c(0.4, -1.9))
#' missing_transmissivity / (partial_transmissivity + missing_transmissivity)
#'
estimate_missing <- function(blended = NA_real_, transmissivity, head) {

  dat  <- data.table(transmissivity = transmissivity,
                     head = head)
  complete <- na.omit(dat)
  na_dat   <- dat[which(is.na(transmissivity) + is.na(head) > 0),]

  n_t <- sum(is.na(transmissivity))
  n_h <- sum(is.na(head))

  blended_sub <- estimate_blended_head(complete$transmissivity, complete$head)
  delta_blended <- blended - blended_sub

  if(n_t == 1 & n_h == 0 & !is.na(blended)) {

    out <- (delta_blended * sum(complete$transmissivity)) /
      (na_dat$head[1] - blended)

  } else if(n_t == 0 & n_h == 1 & !is.na(blended)) {

    out <- (delta_blended * sum(dat$transmissivity) + blended_sub * na_dat$transmissivity[1]) /
      na_dat$transmissivity[1]

  } else if(n_t == 0 & n_h == 0 & is.na(blended)) {

    out <- estimate_blended_head(transmissivity, head)

  } else {

    stop('One and only one missing value for head or transmissivity can be
          provided')

  }

  return(out)

}

#' @title Requests the Eventful API for event information
#' @description This function takes inputs location, date, category, and key.  Its output is a dataframe
#' containing event information along with information that can be used to create popups with
#' leaflet.
#' @param location A \code{string} of dimension 2 used to denote the integration
#' region of interest, i.e. [a, b].
#' @param date A \code{string} containing the function to be integrated. It
#' is assumed that \code{x} is used as the variable of interest.
#' @param category A \code{string} (integer) used to denote the number of simulations.
#' @param key A \code{string} used to control the seed of the random number
#' generator used by this function.
#' @return A \code{dataframe} containing the following attributes:
#' \describe{
#'      \item{I}{Estimated value of the integral}
#'      \item{var}{Estimated variance of the estimator}
#' }
#' @author Conner Shoop
#' @author Ryan Faris
#' @import leaflet
#' @import shiny
#' @import shinydashboard
#' @import XML
#' @export
#' @examples
#' mc_int(x_range = c(0,1), fun = "x^2", B = 10^5)
#' mc_int(x_range = c(0,1), fun = "x^2*sin(x^2/pi)", B = 10^5)
run_shiny = function(){
  appDir = system.file("Shiny", package = "musicmapp", mustWork = TRUE)
  shiny::runApp(paste0(appDir, "/ShinyApp.R"), display.mode = "normal")
}

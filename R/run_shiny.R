#' @title Runs Eventful Shinyapp
#' @description This function Runs the eventful shiny app (event location map).
#' @author Conner Shoop
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

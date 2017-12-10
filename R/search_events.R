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
#' @import XML
#' @export
#' @examples
#' mc_int(x_range = c(0,1), fun = "x^2", B = 10^5)
#' mc_int(x_range = c(0,1), fun = "x^2*sin(x^2/pi)", B = 10^5)
search_events <- function(location,date,category,key){
  library(XML)
  url <- paste('http://api.eventful.com/rest/events/search?app_key=', key, '&page_size=1000&category=', category, '&location=',location,'&date=',date, sep ="")
  event_data <- xmlParse(url)
  event_data <- xmlToList(event_data)$event
  event_data <- as.data.frame(do.call('rbind',event_data),nrow=length(event_data),ncol=length(event_data[[1]]),stringsAsFactors = FALSE)
  event_data <- data.frame(title = as.character(event_data$title), lon = as.numeric(event_data$longitude),
                           lat = as.numeric(event_data$latitude),url = as.character(event_data$url),
                           description = as.character(event_data$description),venue = as.character(event_data$venue_name),
                           venue_url = as.character(event_data$venue_url),start_time = as.character(event_data$start_time),
                           stop_time = as.character(event_data$stop_time), venue_address = as.character(event_data$venue_address),
                           city = as.character(event_data$city_name),zip = as.character(event_data$postal_code))

  popups <- paste(sep = "<br/>",
                  paste(sep = '', '<b><a href=', event_data$url, '>',  event_data$title, ' </a></b>'),
                  event_data$start_time,
                  event_data$description,
                  paste(sep = '', '<b><a href=', event_data$venue_url, '>',  event_data$venue, ' </a></b>'),
                  event_data$venue_address,
                  event_data$city,
                  event_data$zip)

  event_data <- cbind(event_data,popups)
  return(event_data)
}

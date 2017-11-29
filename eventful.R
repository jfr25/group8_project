library(XML)


#Get list of categories
key <- "zhkxv5C4PzvT2TpC"
categories <- xmlParse('http://api.eventful.com/rest/categories/list?app_key=zhkxv5C4PzvT2TpC')
categories<- xmlToList(categories)
categories <- as.data.frame(do.call('rbind',categories))

search_events <- function(location,date,category,key){
  
}
#search
key <- "zhkxv5C4PzvT2TpC"
category <- "comedy"
location <- "Pittsburg"
date <- "December"

# function to search by location, date, category, key
# requires package dplyr
library(dplyr)
search_events <- function(location,date,category,key){
url <- 'http://api.eventful.com/rest/events/search?app_key=zhkxv5C4PzvT2TpC&page_size=100&category=all&location=Pittsburg&date=December'
url <- paste('http://api.eventful.com/rest/events/search?app_key=', key, '&page_size=100&category=', category, '&location=',location,'&date=',date, sep ="")
event_data <- xmlParse(url)
event_data <- xmlToList(event_data)$events
event_data <- as.data.frame(do.call('rbind',event_data),nrow=length(event_data),ncol=length(event_data[[1]]),stringsAsFactors = FALSE)
event_data <- event_data %>%
  select(title, url, description, start_time, venue_name, city_name, region_name, postal_code, latitude, longitude, image)
}
#call search function
event_data <- search_events("New York", "december", "comedy",key)

#create data frame specifically of latitude and longitude
lat_lon <- event_data %>%
  select(latitude, longitude)

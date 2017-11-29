library(XML)


#Get list of categories
key <- "zhkxv5C4PzvT2TpC"
categories <- xmlParse('http://api.eventful.com/rest/categories/list?app_key=zhkxv5C4PzvT2TpC')
categories<- xmlToList(categories)
categories <- as.data.frame(do.call('rbind',categories))

search_events <- function(location,date,category,key){
  
}


url <- 'http://api.eventful.com/rest/events/search?app_key=zhkxv5C4PzvT2TpC&page_size=100&category=technology&location=State+College&date=December'
event_data <- xmlParse(url)
event_data <- xmlToList(event_data)$events
event_data <- as.data.frame(do.call('rbind',event_data),nrow=length(event_data),ncol=length(event_data[[1]]),stringsAsFactors = FALSE)

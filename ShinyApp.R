library(shiny)
categories <- list("Concerts & Tour Dates"= "music",
                   "Conferences & Tradeshows" = "conference",
                   "Comedy"= "comedy",
                   "Education"= "learning_education",
                   "Kids & Family" = "family_fun_kids",
                   "Festivals" = "festivals_parades",
                   "Film "= "movies_film",
                   "Food & Wine" = "food",
                   "Fundraising & Charity"="fundraisers",
                   "Art Galleries & Exhibits" = "art",
                   "Health & Wellness" = "support",
                   "Holiday" = "holiday",
                   "Literary & Book" = "books",
                   "Museums & Attractions" = "attractions",
                   "Neighborhood" = "community",
                   "Business & Networking" = "business",
                   "Nightlife & Singles" = "singles_social",
                   "University & Alumni" = "schools_alumni",
                   "Organizations & Meetups " = "clubs_associations",
                   "Outdoors & Recreation" = "outdoors_recreation",
                   "Performing Arts" = "performing_arts",
                   "Pets" = "animals",
                   "Politics & Activism" = "politics_activism",
                   "Sales & Retail" = "sales",
                   "Science" = "science",
                   "Religion & Spirituality" = "religion_spirituality",
                   "Sports" = "sports",
                   "Technology" = "technology",
                   "Other & Miscellaneous" = "other")


# function to search eventful database by location, date, category
search_events <- function(location,date,category,key){
  url <- paste('http://api.eventful.com/rest/events/search?app_key=', key, '&page_size=1000&category=', category, '&location=',location,'&date=',date, sep ="")
  event_data <- xmlParse(url)
  event_data <- xmlToList(event_data)$event
  event_data <- as.data.frame(do.call('rbind',event_data),nrow=length(event_data),ncol=length(event_data[[1]]),stringsAsFactors = FALSE)
  event_data <- data.frame(title = as.character(unlist(event_data$title)), lon = as.numeric(unlist(event_data$longitude)), 
                           lat = as.numeric(unlist(event_data$latitude)),url = as.character(unlist(event_data$url)),
                           venue = as.character(unlist(event_data$venue_name)), venue_url = as.character(unlist(event_data$venue_url)))
  popups <- paste(sep = "<br/>",
                  paste(sep = '', '<b><a href=', event_data$url, '>',  event_data$title, ' </a></b>'),
                  paste(sep = '', '<b><a href=', event_data$venue_url, '>',  event_data$venue, ' </a></b>')
  )
  event_data <- cbind(event_data,popups)
  class(event_data) <- "events"
  return(event_data)
}

library(shinydashboard)
library(leaflet)

header <- dashboardHeader(
  title = "Event Map"
)

body <- dashboardBody(
  fluidRow(
    column(width = 9,
           box(width = '100%', height = '100%', solidHeader = TRUE,
               leafletOutput("Map", height = 500)
           )
    ),
    column(width = 3,
           box(width = '100%', height = "100%", status = "warning",
               textInput("text", h4("Location")),
               selectInput('category', h4("Category"), 
                           choices = categories,
                           multiple = FALSE),
               dateRangeInput("dates", h4("Dates"), format='M dd', separator = '-'),
               actionButton("create", "Search for events!", icon = icon("thumbs-up")),
               h4(textOutput('results')))
    )
  )
)

ui <- dashboardPage(
  skin=c('black'),
  header,
  dashboardSidebar(disable = TRUE),
  body
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$Map <- renderLeaflet({
    leaflet() %>% addProviderTiles(providers$CartoDB.Positron) %>% setView(-95.7129, 37.0902,  4)
  })
  
  observeEvent(input$create, {
    showNotification("Loading results...")
    location <- input$text
    dates <- paste(gsub('-',"",input$dates), '00', sep = "", collapse = "-")
    category <- input$category
    proxy <- leafletProxy("Map")
    # Try if not show error notification
    events <- search_events(location,dates,category,key = "zhkxv5C4PzvT2TpC")
    output$results <- renderText(paste(length(events$lat),"events found!"))
    proxy %>% clearMarkerClusters() %>%
      setView(median(events$lon), median(events$lat), 10) %>%
      addMarkers(lng= events$lon, lat= events$lat,
                 clusterOptions = markerClusterOptions(),
                 popup = events$popups)
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


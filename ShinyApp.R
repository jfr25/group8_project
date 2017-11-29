
library(shiny)

ui <- fluidPage(

  # Application title
  titlePanel(h4("Music Mapp: Find Events Near You!")),

  sidebarLayout(
    sidebarPanel(
      textInput("text", h3("Location"),
                value = "Enter location..."),
      checkboxGroupInput("checkGroup",
                           h3("Categories"),
<<<<<<< HEAD
                           choices = list("music"=1,
                                          "conference"=2,
                                          "comedy"=3,
                                          "learning_education"=4,
                                          "family_fun_kids"=5,
                                          "festivals_parades"=6,
                                          "movies_film"=7,
                                          "food"=8,
                                          "fundraisers"=9,
                                          "art"=10,
                                          "support"=11,
                                          "holiday"=12,
                                          "books"=13,
                                          "attractions"=14,
                                          "community"=15,
                                          "business"=16,
                                          "singles_social"=17,
                                          "schools_alumni"=18,
                                          "clubs_associations"=19,
                                          "outdoors_recreation"=20,
                                          "performing_arts"=21,
                                          "animals"=22,
                                          "politics_activism"=23,
                                          "sales"=24,
                                          "science"=25,
                                          "religion_spirituality"=26,
                                          "sports"=27,
                                          "technology"=28,
                                          "other"=29)),
        checkboxInput('bar','All/None'),
        dateRangeInput("dates", h3("Date range")),
        actionButton("cast", "Search for events!", icon = icon("thumbs-up"))
=======
                           choices = list("Concerts" = 1,
                                          "Choice 2" = 2,
                                          "Choice 3" = 3),
                           selected = 1),
      dateRangeInput("dates", h3("Date range")),
      actionButton("cast", "Search for events!", icon = icon("thumbs-up"))
>>>>>>> c0ecbbd343567179d46b036492eb9ed676ce0234
        ),
    mainPanel(textOutput("Map"))
    )
  )




# Define server
server <- function(input, output) {
  observe({
    updateCheckboxGroupInput(session,
      "checkGroup", choices = choices, selected = if (input$bar) 1:29
    )
  })

}

# Run the application
shinyApp(ui = ui, server = server)

library(devtools)
devtools::install_github("group8_project/musicmapp")
library(musicmapp)

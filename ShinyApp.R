
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
                           choices = list("Concerts" = 1,
                                          "Choice 2" = 2,
                                          "Choice 3" = 3),
                           selected = 1),
      dateRangeInput("dates", h3("Date range")),
      actionButton("cast", "Search for events!", icon = icon("thumbs-up"))
        ),
    mainPanel(textOutput("Map"))
    )
  )




# Define server
server <- function(input, output) {
  cast <- eventReactive(input$cast, {
    buffon_experiment(B = input$B, plane_width = input$plane,
                      seed = input$seed)
  })

  conv <- eventReactive(input$cast, {
    converge(B = input$B, plane_width = input$plan,
             seed = input$seed, M = input$M)
  })

  output$exp <- renderPlot({
    plot(cast())
  }, height = 620)

  output$conv <- renderPlot({
    conv()
  }, height = 620)
}

# Run the application
shinyApp(ui = ui, server = server)

library(devtools)
devtools::install_github("group8_project/musicmapp")
library(musicmapp)

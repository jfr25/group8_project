
library(shiny)

ui <- fluidPage(

  # Application title
  titlePanel(h4("Buffon\'s needle experiment - Inputs:")),

  sidebarLayout(
    sidebarPanel(
      fluidRow(
        selectInput("var",
                  label = "Choose a location to display",
                  choices = list("Percent White",
                                 "Percent Black",
                                 "Percent Hispanic",
                                 "Percent Asian"),
                  selected = "Percent White"),
        column(3,
             checkboxGroupInput("checkGroup",
                                h3("Categories"),
                                choices = list("Concerts" = 1,
                                               "Choice 2" = 2,
                                               "Choice 3" = 3),
                                selected = 1)),

          column(3,
               dateRangeInput("dates", h3("Date range"))),
        actionButton("cast", "Search for events!", icon = icon("thumbs-up"))
        ),
    mainPanel(textOutput("Map"))
    )
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


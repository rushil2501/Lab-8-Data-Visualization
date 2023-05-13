library(shiny)
library(plotly)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Iris Dataset Visualization"),
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "X-axis variable", 
                  choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
      selectInput("yvar", "Y-axis variable", 
                  choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")),
      selectInput("colorvar", "Color variable", 
                  choices = c("Species")),
      selectInput("shapevar", "Shape variable", 
                  choices = c("Species")),
      sliderInput("sizevar", "Size variable", 
                  min = 1, max = 10, value = 5),
      checkboxGroupInput("filtervar", "Filter by Species", 
                         choices = unique(iris$Species), 
                         selected = unique(iris$Species))
    ),
    mainPanel(
      plotlyOutput("scatterplot")
    )
  )
)

server <- function(input, output) {
  
  output$scatterplot <- renderPlotly({
    
    # Filter data based on selected species
    iris_filtered <- iris[iris$Species %in% input$filtervar,]
    
    # Create scatter plot
    scatter_plot <- ggplot(data = iris_filtered, aes(x = !!as.name(input$xvar), y = !!as.name(input$yvar))) +
      geom_point(aes(color = !!as.name(input$colorvar), shape = !!as.name(input$shapevar), size = input$sizevar))
    
    # Convert ggplot to plotly
    ggplotly(scatter_plot, height = 600, width = 800) %>% 
      layout(
        xaxis = list(title = input$xvar),
        yaxis = list(title = input$yvar)
      )
  })
}

shinyApp(ui, server)

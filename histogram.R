library(shiny)
library(shinyWidgets)
library(plotly)

# Define the UI
ui <- fluidPage(
  
  # Add title to the app
  titlePanel("Interactive Histograms of Iris Data"),
  
  # Add sidebar layout
  sidebarLayout(
    
    # Add sidebar panel
    sidebarPanel(
      
      # Add slider inputs for bin size
      sliderInput("bins1", "Select bin size for Sepal Length:", min = 1, max = 20, value = 10),
      sliderInput("bins2", "Select bin size for Sepal Width:", min = 1, max = 20, value = 10),
      sliderInput("bins3", "Select bin size for Petal Length:", min = 1, max = 20, value = 10),
      sliderInput("bins4", "Select bin size for Petal Width:", min = 1, max = 20, value = 10),
      
      # Add picker inputs for color selection
      pickerInput("color1", "Select color for Sepal Length:", choices = c("black","blue", "red", "green", "orange"), selected = "black","blue", multiple = FALSE),
      pickerInput("color2", "Select color for Sepal Width:", choices = c("black","blue", "red", "green", "orange"), selected = "red", multiple = FALSE),
      pickerInput("color3", "Select color for Petal Length:", choices = c("black","blue", "red", "green", "orange"), selected = "green", multiple = FALSE),
      pickerInput("color4", "Select color for Petal Width:", choices = c("black","blue", "red", "green", "orange"), selected = "orange", multiple = FALSE)
      
    ),
    
    # Add main panel
    mainPanel(
      
      # Add plotly plots
      plotlyOutput("hist1"),
      plotlyOutput("hist2"),
      plotlyOutput("hist3"),
      plotlyOutput("hist4")
      
    )
    
  )
  
)
server <- function(input, output) {
  
  # Generate the histograms
  output$hist1 <- renderPlotly({
    plot_ly(iris, x = ~Sepal.Length, type = "histogram", 
            marker = list(color = input$color1), 
            histnorm = "probability", 
            autobinx = FALSE, 
            xbins = list(size = (max(iris$Sepal.Length) - min(iris$Sepal.Length)) / input$bins1)) %>% 
      layout(bargap = 0.1, 
             xaxis = list(title = "Sepal Length"))
  })
  
  output$hist2 <- renderPlotly({
    plot_ly(iris, x = ~Sepal.Width, type = "histogram", 
            marker = list(color = input$color2), 
            histnorm = "probability", 
            autobinx = FALSE, 
            xbins = list(size = (max(iris$Sepal.Width) - min(iris$Sepal.Width)) / input$bins2)) %>% 
      layout(bargap = 0.1, 
             xaxis = list(title = "Sepal Width"))
  })
  
  output$hist3 <- renderPlotly({
    plot_ly(iris, x = ~Petal.Length, type = "histogram", 
            marker = list(color = input$color3), 
            histnorm = "probability", 
            autobinx = FALSE, 
            xbins = list(size = (max(iris$Petal.Length) - min(iris$Petal.Length)) / input$bins3)) %>% 
      layout(bargap = 0.1, 
             xaxis = list(title = "Petal Length"))
  })
  
  output$hist4 <- renderPlotly({
    plot_ly(iris, x = ~Petal.Width, type = "histogram", 
            marker = list(color = input$color4), 
            histnorm = "probability", 
            autobinx = FALSE, 
            xbins = list(size = (max(iris$Petal.Width) - min(iris$Petal.Width)) / input$bins4)) %>% 
      layout(bargap = 0.1, 
             xaxis = list(title = "Petal Width"))
  })
}
shinyApp(ui, server)


library(shiny)
library(ggplot2)

# load iris dataset
data(iris)

# UI code
ui <- fluidPage(
  titlePanel("Iris Dataset Visualization"),
  sidebarLayout(
    sidebarPanel(
      selectInput("plotType", "Plot type", 
                  choices = c("Box plot", "Violin plot")),
      selectInput("yvar", "Y-axis variable", 
                  choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                  selected = "Sepal.Length")
    ),
    mainPanel(
      plotOutput("irisPlot")
    )
  )
)



# server code
server <- function(input, output) {
  output$irisPlot <- renderPlot({
    if (input$plotType == "Box plot") {
      ggplot(iris, aes(x = Species, y = get(input$yvar), fill = Species)) + 
        geom_boxplot() +
        scale_fill_manual(values = c("setosa" = "red", "versicolor" = "blue", "virginica" = "green"))
    } else {
      ggplot(iris, aes(x = Species, y = get(input$yvar), fill = Species)) + 
        geom_violin() +
        scale_fill_manual(values = c("setosa" = "red", "versicolor" = "blue", "virginica" = "green"))
    }
  })
}
shinyApp(ui,server)

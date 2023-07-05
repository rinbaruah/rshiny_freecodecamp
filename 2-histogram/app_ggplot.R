####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

# Modified from https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/

library(shiny)
library(ggplot2)
library(tidyverse)
data(airquality)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Ozone level!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----

    sidebarPanel(
      
      # Input: Slider for the bin number ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30,
                  step=2),
      
      # Input: Slider for the bin width ----
      sliderInput(inputId = "binwidth",
                  label = "Bin Width:",
                  min = 0,
                  max = 10,
                  value = 1,
                  step = 0.5)
    ),
 
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot1"),
      plotOutput(outputId = "distPlot2")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  output$distPlot1 <- renderPlot({
    
    val <- airquality$Ozone
    val <- na.omit(val)
    
    ggplot(data = airquality %>% na.omit(), aes(x = Ozone)) +
      geom_histogram(bins = input$bins, fill = 'lightgreen',color='black') +
      labs(x = "Ozone level") +
      ggtitle("PLOT 1: Histogram of Ozone level \n with slider input for bin numbers")
    
  })
  
  output$distPlot2 <- renderPlot({
    
    val <- airquality$Ozone
    val <- na.omit(val)
    
    ggplot(data = airquality %>% na.omit(), aes(x = Ozone)) +
      geom_histogram(binwidth = input$binwidth, fill = 'lightblue',color='black') +
      labs(x = "Ozone level") +
      ggtitle("PLOT 2: Histogram of Ozone level \n with slider input for bin width")
    
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)


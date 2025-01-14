# --------------------------------------------------------------------------------
library(shiny)
# --------------------------------------------------------------------------------
# Define the Shiny UI
# --------------------------------------------------------------------------------
# User Interface: Allows user interaction with inputs and displays outputs
ui <- fluidPage(
  
  # Title and Description
  titlePanel("Estimating Location Parameter of Cauchy Distribution"),
  sidebarLayout(
    sidebarPanel(
      # Input: Location parameter (m)
      numericInput("location", 
                   "Location Parameter (m):", 
                   value = 0, 
                   step = 0.1),
      
      # Input: Sample size (n)
      sliderInput("sample_size", 
                  "Sample Size (n):", 
                  min = 10, 
                  max = 100, 
                  value = 30, 
                  step = 10),
      
      # Input: Number of simulations (M)
      sliderInput("simulations", 
                  "Number of Simulations (M):", 
                  min = 100, 
                  max = 5000, 
                  value = 1000, 
                  step = 500),
      
      # Action Button to Update Results
      actionButton("update", "Update")
    ),
    
    # Main Panel: Displays Histogram and Observations
    mainPanel(
      plotOutput("histogram"),
      textOutput("observations")
    )
  )
)

# --------------------------------------------------------------------------------
# Define the Shiny Server Logic
# --------------------------------------------------------------------------------
# Server Logic: Processes inputs and generates outputs
server <- function(input, output) {
  
  # Reactive Expression: Compute sample medians based on inputs
  sample_medians <- eventReactive(input$update, {
    # Extract inputs
    m <- input$location
    n <- input$sample_size
    M <- input$simulations
    
    # Simulate sample medians
    replicate(M, median(rcauchy(n, location = m)))
  })
  
  # Output: Histogram of Sample Medians
  output$histogram <- renderPlot({
    # Retrieve the sample medians
    medians <- sample_medians()
    
    # Plot histogram
    hist(medians, 
         breaks = 30, 
         probability = TRUE, 
         col = "lightblue", 
         main = paste("Empirical Distribution of Sample Medians (n =", input$sample_size, ")"),
         xlab = "Sample Median")
    
    # Overlay Gaussian fit
    curve(dnorm(x, mean = mean(medians), sd = sd(medians)), 
          col = "red", 
          lwd = 2, 
          add = TRUE)
    
    # Add legend
    legend("topright", legend = c("Empirical", "Gaussian Fit"), 
           col = c("lightblue", "red"), lwd = 2, bty = "n")
  })
  
  # Output: Observations about the distribution
  output$observations <- renderText({
    medians <- sample_medians()
    
    # Observations about the empirical distribution
    paste(
      "Observations:\n",
      "- Mean of sample medians:", round(mean(medians), 3), "\n",
      "- Standard deviation of sample medians:", round(sd(medians), 3), "\n",
      "- As sample size (n) increases, the distribution of sample medians becomes\n",
      "  more concentrated around the location parameter (m)."
    )
  })
}

# --------------------------------------------------------------------------------
# 4. Run the Shiny App
# --------------------------------------------------------------------------------
# Launch the application
shinyApp(ui = ui, server = server)

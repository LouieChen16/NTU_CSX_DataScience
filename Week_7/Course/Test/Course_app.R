#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#Set Language as traditional Chinese
Sys.setlocale(category = "LC_ALL", locale = "cht")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30),
         textInput("text", h3("Text input"), 
                   value = "Enter text..."), 
         sliderInput("no.row",
                     "Number of rows:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         textOutput("txt_out"),
         tableOutput("table_out")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   
   output$txt_out <- renderText({
     input$text
   })
   
   output$table_out <- renderTable({
     dat <- read.csv("./show.csv")
     #head(dat)
     #rownames(dat) <- dat[,1]
     #dat <- dat[, -c(1)]
     colnames(dat) <- c("Keywords","BBC", "Epochtimes", "Inside", "Techorange")
     #View(dat[1:input$no.row,])
     dat[2:input$no.row,]
       
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


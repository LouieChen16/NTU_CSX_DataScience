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
  
  tabsetPanel(
    tabPanel("Common Keywords from Different Media",

      # Application title
      #titlePanel("Old Faithful Geyser Data"),
  
      # Sidebar with a slider input for number of bins 
      sidebarLayout(
        sidebarPanel(
          radioButtons("Media", "Choose Media:",
                       choices = list("Techorange" = "Techorange.csv", "BBC Chinese" = "BBC_Chinese.csv",
                                      "Epochtimes" = "Epochtimes.csv", "Inside" = "Inside.csv"),selected = "Techorange.csv"),
          sliderInput("no.keyword.BBC.in",
                      "Number of Keywords:",
                      min = 1,
                      max = 50,
                      value = 25)
        ),
    
        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("keyword.BBC.out")
        )
      )
    ),
    tabPanel("Overall Keywords", 
 
      sidebarLayout(
       sidebarPanel(
         sliderInput("over.in",
                     "Number of Keywords:",
                     min = 1,
                     max = 50,
                     value = 25)
         ),
               
         # Show a plot of the generated distribution
         mainPanel(
           plotOutput("over.out")
         )
      )
    ),
    tabPanel("Classification of Keywords", 
    
      sidebarLayout(
        sidebarPanel(
          radioButtons("class.in", "Choose Cluster:",
                       choices = list("1" = 1, "2"= 2,
                                      "3" = 3, "4" = 4, "All" = "All"),selected = "All")
        ),
               
        # Show a plot of the generated distribution
        mainPanel(
          fluidRow(
            #img(src = "2.jpg", height = 400, width = 600),
            column(3, imageOutput("img.out"))
          ),
          fluidRow(
            br(),
            br(),
            br(),
            br(),
            br(),
            br(),
            br(),
            h3("Example Words in Cluster:"),
            column(3, tableOutput("class.out"))
          )
        )
      )         
    ),
    tabPanel("Prediction of Article Source", 
             
             sidebarLayout(
               sidebarPanel(
                 textInput("artic.in", h3("Article about Elon Musk:"), 
                           value = "Paste text...")
               ),
               
               # Show a plot of the generated distribution
               mainPanel(
                 br(),
                 h3("Cut words:"),
                 textOutput("artic.txt.out"),
                 br(),
                 br(),
                 br(),
                 h3("Possible Cluster of Keywords:"),
                 tableOutput("artic.out"),
                 h3("Prediction Matrix:"),
                 imageOutput("img.pred.out")
               )
             )
    )
  )
)

server <- function(input, output) {
  
  output$keyword.BBC.out <- renderPlot({
    
    dat <- read.csv(input$Media) 
    freq_table <- dat[1:input$no.keyword.BBC.in, 2:3]
    
    #Draw Plot
    freq_table$Var1 <- factor(freq_table$Var1, levels = freq_table$Var1)
    ggplot(data = freq_table, aes(x = Var1, y = Freq)) +
      geom_bar(stat="identity", width = 0.5, fill = "blue") + 
      labs(title="KeyWords Ranking for Elon Musk", 
           subtitle="Sorted Bar Chart") + 
      theme(axis.text.x = element_text(angle=65, vjust=0.6))
    
  })
  
  output$over.out <- renderPlot({
    
    dat <- read.csv("./Overall_freq.csv")
    freq_table <- dat[1:input$over.in, 2:3]
    
    #Draw Plot
    freq_table$Var1 <- factor(freq_table$Var1, levels = freq_table$Var1)
    ggplot(data = freq_table, aes(x = Var1, y = Freq)) +
      geom_bar(stat="identity", width = 0.5, fill = "blue") + 
      labs(title="Overall Keywords Ranking for Elon Musk", 
           subtitle="Sorted Bar Chart") + 
      theme(axis.text.x = element_text(angle=65, vjust=0.6))
  })
  
  output$img.out <- renderImage({
    # When input$class.in is 1, filename is ./www/1.jpg
    filename <- normalizePath(file.path('./www', paste(input$class.in, '.jpg', sep='')))
    
    # Return a list containing the filename
    list(src = filename)
  }, deleteFile = FALSE)
  
  output$class.out <- renderTable({
    dat <- read.csv("./cluster_data.csv")
    #file.exists("cluster_data.csv")
    
    #dat[1:3,1:2]
    n = 0
    
    if(input$class.in == "All"){
      dat[1:30, 1]
    }else if(input$class.in == 1){
      dat[1:30, 4]
    }else if(input$class.in == 2){
      dat[1:30, 7]
    }else if(input$class.in == 3){
      dat[1:30, 10]
    }else if(input$class.in == 4){
      dat[1:30, 13]
    }
  })
  
  output$artic.txt.out <- renderText({
    library(jiebaR)
    mixseg = worker()
    seg <- mixseg[input$artic.in]
    
    #去掉只包含一個字的斷詞
    seg[nchar(seg)>1]
    
    #dat <- read.csv("./cluster_data.csv")
    #dat$Keyword[1]
  })
  
  output$artic.out <- renderTable({
    
    library(jiebaR)
    mixseg = worker()
    seg <- mixseg[input$artic.in]
    
    #去掉只包含一個字的斷詞
    keywords <- seg[nchar(seg)>1]
    #keywords
    df <- as.data.frame(keywords)
    df["Cluster"] <- "No"
    #df[1,]
    
    #判斷段詞比較有機會來自哪一個文章
    dat <- read.csv("./cluster_data.csv")
    #df.dat <- as.data.frame(dat)
    
    for(row in c(1:length(keywords))){
      for (rows.dat in c(1:nrow(dat))){
        if(dat[rows.dat,1] == df[row,1]){
          df[row,2] <- dat[rows.dat,2]
          break
        }
      }
    }
    
    df
    #length(keywords)
    #keywords[1:5]
    
  })
  output$img.pred.out <- renderImage({
    # When input$class.in is 1, filename is ./www/1.jpg
    filename <- normalizePath(file.path('./www', paste('pred_accuracy', '.jpg', sep='')))
    
    # Return a list containing the filename
    list(src = filename, width = 400, height = 150)
  }, deleteFile = FALSE)
}

# Run the application 
shinyApp(ui = ui, server = server)


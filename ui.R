library(shiny)
shinyUI(
  fluidPage(theme = "bootstrap.css",headerPanel(h1("Singapore Population Data", style = "font-family: 'Glyphicons Halflings', cursive;
        font-weight: 500; line-height: 1.1; color: #4d3a7d;")),

sidebarLayout(
  sidebarPanel(
    helpText("1) Divorce trend according to ethnic group"),
    
    selectInput("var", 
                label = "Choose an ethnic group to display",
                choices = c("Chinese", "Indians",
                            "Others", "Inter-Ethnic"),
                selected = "Chinese"),
    
    helpText("2) Linear Model"),    
    checkboxGroupInput("var2","Choose predictors against number of divorce cases for linear model", 
                c("Median Age"= "1",
                  "Elderly Support Ratio" = "2",
                  "Dependency Ratio" ="3"),
                selected="2")
    
   
  ),
  
  
  
mainPanel(

  tabsetPanel(
    tabPanel("1) Divorce-Ethnic Plot", plotOutput("plot")),
    tabPanel("2) Linear Model Plot", plotOutput("plot2")),
    tabPanel("2) Summary of LM", verbatimTextOutput("summary"))
    
)
  )
  
  
  
  
)

))
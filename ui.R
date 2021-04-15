#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#


library(shiny)
library(ceRtainty)
library(bslib)
library(Rcpp)
library(microbenchmark)

#In order to estimate risk parameter with utility:
# Package ceRtainty
# Certainty equivalent computation method

shinyUI <- fluidPage(
    
    # Application title
    
    theme = bs_theme(version = 4, bootswatch = "spacelab"),
    
    titlePanel("portfolio risk optimization"),
    textOutput("note1"),
    textOutput("note3"),
    # Main panel for displaying outputs ----
    
    mainPanel(
        
        navbarPage("chosing three posibility way of comparing returns",
                   
                   tabPanel("volatility plot",textOutput("note4"),
                            fluidRow('all type of avalibel assets',
                                     selectInput("asset", label = "Please choose an asset",
                                                 choices = list("stock" = 'stock',
                                                                "bond" = 'bond',
                                                                "real.state.return.rate" = 'real.state.return.rate',
                                                                "banking.intrest.rate" = 'banking.intrest.rate'))), plotOutput('myplot')),
                   
                   tabPanel("Invoking the CE plot",
                            selectInput('utility', 'utility function type', c("ExpNeg","Power")),
                            fluidRow(textOutput("note5"),
                                     plotOutput("distPlot1"))),
                   
                   tabPanel("RAC vector Table",
                            selectInput('utility.type', 'utility function type', c("ExpNeg","Power")),
                            fluidRow(tableOutput("table2"))),
                   
                   tabPanel("CE Table",
                            selectInput('utility.value', 'utility function type', c("ExpNeg","Power")),
                            fluidRow(textOutput("note2"),
                                     tableOutput("table3")))
                   
        ), )
)




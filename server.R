#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.

library(shiny)
library(ceRtainty)
library(dplyr)
library(ggplot2)
library(ggpmisc)

#In order to estimate risk parameter with utility:
# Package ceRtainty
# Certainty equivalent computation method

dataset <- data_opt

# Define server logic required to draw a histogram
shinyServer <- function(input, output) {
    
    output$distPlot1 <- renderPlot({
        
        # storing CE values using Power utility function
        if (input$utility != 'Power') { 
            powerutility.function<-certainty(data=dataset, ival=-5.5, fval=5.5, utility="Power", wealth = 0)
            
            # draw the plot
            
            powerutility.function$CE_plot()                  # Invoking the CE plot
            
        }
        
        # Storing CE values using Power utility function
        
        else if (input$utility != 'ExpNeg'){
            exputilty.function <-certainty(data =dataset,ival = 0, fval = 5.5,utility = "ExpNeg")
            
            # draw the plot
            exputilty.function$CE_plot()                  # Invoking the CE plot
        }
        
    })
    
    
    output$note1 <- renderText("introduction of the app = with this app, I wanted to provide the volatility of absolute risk aversion coefficients (ARAC) 
  parameter and the relative risk aversion coefficient (RRAC), in order to the all certainty equivalents (CE value) 
  for each investment types (Stock market, real state, bond, banking deposit). The tested data were gathered from Social Security Organization of Iran.
  "
    )
    
    output$note2 <- renderText("note 3 =
  The certainty equivalent is the guaranteed amount of cash that 
  a person would consider as having the same 
  amount of desirability as a risky asset.
                           Example
                            Certainty Equivalent Cash Flow = Expected Cash Flow /(1 + Risk Premium)")
    
    output$note3 <- renderText("who can use this app = all decision makers who wants to decide base on the assets rate of return")
    
    output$note4 <- renderText("note 1 = with this graph, you can see the volatility of the assets return during times)")
    output$note5 <- renderText("note 2 =Based on that utility function, you can calculate the Expected Utility of the above investment.
  The expected utility of a random variable is basically the weighted sum of the utility value, 
                             where the weight represents the probability")
    
    output$myplot <- renderPlot({
        req(input$asset)
        ggplot(data = data_gg)+geom_line(aes_string(x = "year", y = input$asset))
        
    })
    
    
    output$table2 <- renderTable({
        
        # storing rac vector using Power utility function
        
        if (input$utility.type != 'Power'){   
            powerutility.function2<-certainty(data=dataset, ival=-5.5, fval=5.5, utility="Power", wealth = 0)
            
            # drowning the table
            
            powerutility.function2$RAC }            # RAC vector used in CE computation
        
        else if (input$utility.type != 'ExpNeg'){
            
            # Storing CE values using Power utility function
            exputilty.function4<-certainty(data =dataset,ival = 0, fval = 5.5,utility = "ExpNeg", wealth = 0)
            
            # drowning the table
            
            exputilty.function4$RAC                       # RAC vector used in CE computation
        }
        
    })
    
    output$table3 <- renderTable({
        
        # Storing CE values using Power utility function
        
        if (input$utility.value != 'ExpNeg'){
            
            exputilty.function3<-certainty(data =dataset,ival = 0, fval = 5.5,utility = "ExpNeg", wealth = 0)
            
            # drowning the table
            
            exputilty.function3$CE_values }                # Table with CE values
        
        
        else if (input$utility.value != 'Power'){
            
            powerutility.function1<-certainty(data=dataset, ival=-5.5, fval=5.5, utility="Power", wealth = 0)
            
            # drowning the table
            
            powerutility.function1$CE_values                  # Table with CE values
        }
        
    })   
    
}



#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a graph and output
shinyServer(function(input, output) {
  
  data(ChickWeight)
  library(dplyr)
  # model1 and model 2 for predicting the values
  model1 <- lm(weight~Time+Chick, data=ChickWeight)
  model2 <- lm(weight ~ Time+Diet, data=ChickWeight)
  #reactive function for computing predictions
  model1Out <- reactive ({
    msgInput <- data.frame("Time"= input$Time1, "Chick"=as.character(input$choiceC), "Diet"=input$choiceD)  
    #msgInput <- data.frame(Time=2, Chick="15", Diet="2" )
    predict1 <- predict(model1, newdata=msgInput)
    predict1
  })
  model2Out <- reactive ({
    msgInput <- data.frame("Time"= input$Time1, "Chick"=input$choiceC, "Diet"=input$choiceD)  
    predict2 <- predict(model2, newdata=msgInput)
    predict2
  })

  # plot for the server. 

   output$Plot <- renderPlot({
    
   msgInput <- data.frame("Time"= input$Time1, "Chick"=input$choiceC, "Diet"=input$choiceD)  
  
    if(input$show1== 1) { 
      plot(x=input$Time1, y=model1Out(), pch=19, col="green", xlab="Ages in Months", 
            main="Predicted Chicken Weight", ylab="Weight in grams")

      output$predict1 <- renderText({ model1Out() }) 
    }
    else {
     plot(x=input$Time1, y=model2Out(), pch=19, col="green", xlab="Age in Months", 
           main="Predicted Chicken Weight", ylab="Weight in grams") 
      output$predict1 <- renderText({ model2Out()  })
      
   }
  })
  
})

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
  str(ChickWeight)
  library(dplyr)
  # model1 and model 2 for predicting the values
  model1 <- lm(weight~Time+Chick, data=ChickWeight)
  model2 <- lm(weight ~Time+Diet, data=ChickWeight)
  #reactive function for computing predictions
  model1Out <- reactive ({
    n <- input$Time1
    msgInput <- data.frame("Time"= 1:input$Time1, "Chick"=rep(as.character(input$choiceC), n), "Diet"=rep(input$choiceD, n))  
    #msgInput <- data.frame(Time=2, Chick="15", Diet="2" )
    predict1 <- predict(model1, newdata=msgInput)
    predict1
  })
  model2Out <- reactive ({
    n <- length(input$Time1)
    msgInput <- data.frame("Time"= 1:input$Time1, "Chick"=rep(as.character(input$choiceC), n), "Diet"=rep(input$choiceD, n))  
    predict2 <- predict(model2, newdata=msgInput)
    predict2
  })

  # plot for the server. 

   output$Plot <- renderPlot({
     
     n <- length(input$Time1)
     msgInput <- data.frame("Time"= 1:input$Time1, "Chick"=rep(as.character(input$choiceC), n), "Diet"=rep(input$choiceD, n))    
     
    if(input$show1== 1) { 
      plot(x=msgInput$Time, y=model1Out(), pch=19, col="green", xlab="Time (Ages in Months)", 
            main="Predicted Chicken Weight", ylab="Weight in grams")
      
      output$table1 <- renderTable({ cbind(msgInput, "Predicted Weight(in g)"=model1Out()) }) 
    }
    else {
     plot(x=msgInput$Time, y=model2Out(), pch=19, col="green", xlab="Time (Age in Months)", 
           main="Predicted Chicken Weight", ylab="Weight in grams") 
      output$table1 <- renderTable({ cbind(msgInput, "Predicted Weight(in g)"=model2Out())  })
      
   }
  })
  
})

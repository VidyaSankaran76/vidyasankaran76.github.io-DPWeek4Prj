#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(miniUI)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Chicken Weight by Age, Type & Diet"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("Time1",
                   "Chick Age in months:",
                   min = 0.00,
                   max = 21.00,
                   value = 10.00),
       dietSelection <- list("one"="1", "two"="2","three"="3", "four"="4"), 
       selection <- list("Model1: Age & Type of Chick" =1, "Model2: Age & Type of Diet"=2),
       sliderInput("choiceC","Type of Chicken",min=1, max=50, value=18),
       selectInput("choiceD", "Type of Diet:", choices=dietSelection, selected="1"),
       radioButtons("show1","Model1 or Model2",choices=selection, selected=1),
       #checkboxInput("show2", "Show or Hide Model 2 Response", value=FALSE),
       submitButton("Done")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("Plot"),
       h3("Predictied Weight of Model"),
       textOutput("predict1")
   #    h3("Predicted Weight of Model2"),
   #    textOutput("predict2")
    )
  )
))

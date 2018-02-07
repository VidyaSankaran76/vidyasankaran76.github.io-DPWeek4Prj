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

dietSelection <- list("One"="1", "Two"="2","Three"="3", "Four"="4")
selection <- list("Model1: Age & Type of Chick" =1, "Model2: Age & Type of Diet"=2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Chicken Weight by Age, Type & Diet"),
  h4("The weight of chicken is predicted by various factors such as Chicken's Age in months, 
      chicken's diet, chicken's type. Linear regression model is applied to predict the
     weight of chicken with the predictors as Age, type of chicken and diet of chicken. This app
     predicts the weight of Chicken for given number of months, based on  two models."),
  
  h4("First model predicts the chicken's weight with  the Age and type of Chicken as predictors."),
  h4("Second model predicts the weight of chicken with predictors as age of the chicken 
     and  the diet of the chicken."),
  
  h4("Output:It is displayed the predicted response plot and also in the table format. 
     The table provides predicted weight of chicken from first month to the max month 
     given in the input. "), 
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       h3("For Model1 : Considers inputs for Age and Type of Chicken"),
       h3("For Model2 : Considers inputs for Age and Diet of Chicken"),
       sliderInput("Time1",
                   "Chick Age in months:", 10, min=1.00, max=21.00), 
       sliderInput("choiceC","Type of Chicken",min=1, max=50, value=18),
       selectInput("choiceD", "Type of Diet:", choices=dietSelection, selected="1"),
       radioButtons("show1","Model1 or Model2",choices=selection, selected=1),
       #checkboxInput("show2", "Show or Hide Model 2 Response", value=FALSE),
       submitButton("Done")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("Plot"),
       h3("Predictied Weights of Model"),
       tableOutput("table1")
   #    h3("Predicted Weight of Model2"),
   #    textOutput("predict2")
    )
  )
))

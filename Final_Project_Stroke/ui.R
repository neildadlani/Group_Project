

library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Factors Affecting Stoke"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(radioButtons("color", label="Bar Graph Color",
                                  choices = list("Violet" = "violet",
                                                 "Indigo" = "purple",
                                                 "Blue"   = "royalblue",
                                                 "Green"  = "green4",
                                                 "Yellow" = "gold",
                                                 "Orange" = "darkorange",
                                                 "Red"    = "red2"),
                                  selected = "violet"),
                     uiOutput("male_or_female")
            
                       
         ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            plotOutput("linegraph")
            
        )
    )
))

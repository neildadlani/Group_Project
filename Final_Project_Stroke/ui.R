

library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Factors Affecting Stoke"),

    tabsetPanel(
        tabPanel("Home"),
        tabPanel("About Us", 
                 textOutput("annadescription"),
                 textOutput("anokhidescription"), 
                 textOutput("ishitadescription"),
                 textOutput("neildescription")),
        tabPanel("Male vs. Female", 
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
                                  uiOutput("male_or_female"),
                                  uiOutput("selectAge")
                     ),
                     
                     # Show a plot of the generated distribution
                     mainPanel(
                         plotOutput("distPlot")
                         
                     )
                 )),
        tabPanel("Glucose", 
                 sidebarLayout(
                     sidebarPanel(
                         uiOutput("selectAge")
                     ),
                     
                     mainPanel(
                         plotOutput("linegraph")),
                         plotOutput("glucosebmigraph"))
                 )
        ),
        tabPanel("Interactive 3"),
        tabPanel("Summary")
))

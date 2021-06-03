

library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

# Define UI for application that makes our Final Project App
shinyUI(fluidPage(

    # Application title
    titlePanel("Factors Affecting Stroke"),
    
    
    # Defining Tabs
    tabsetPanel(
        tabPanel("Home",
                 textOutput("homepageData"),
                 tags$br(textOutput("homepageAudience"))),
        tabPanel("About Us", 
                 textOutput("annadescription"),
                 
                 
                 tags$br(textOutput("anokhidescription")), 
                 
                 textOutput("ishitadescription"),
                 
                 tags$br(textOutput("neildescription"))),
        
        tabPanel("Male vs. Female", 
                 sidebarLayout(
                     sidebarPanel(radioButtons("color", label=h3("Bar Graph Color"),
                                               choices = list("Violet" = "violet",
                                                              "Indigo" = "purple",
                                                              "Blue"   = "royalblue",
                                                              "Green"  = "green4",
                                                              "Yellow" = "gold",
                                                              "Orange" = "darkorange",
                                                              "Red"    = "red2"),
                                               selected = "violet"),
                                  uiOutput("selectAge"),
                                  textOutput("Number")
                                  
                     ),
                     
                     # Show a plot of the generated distribution
                     mainPanel(
                         plotOutput("distPlot")
                         
                     )
                 )),
        tabPanel("Glucose", plotOutput("scatterplot"), uiOutput("category")),
        tabPanel("Table",
                 dataTableOutput("table_data"),
                 uiOutput("smokingStatus")
                 ),
        tabPanel("Summary")
    )
))

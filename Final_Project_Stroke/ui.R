library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

# Define UI for application that makes our Final Project App
shinyUI(fluidPage(
    theme = "final-project-style.css",
    
    # Application title
    titlePanel("Factors Affecting Stroke"),
    
    
    # Defining Tabs
    tabsetPanel(
        tabPanel("Home",
                 tags$br(textOutput("homepageData")),
                 tags$br(textOutput("homepageAudience")),
                 tags$img(class="homepage",
                          src="background-image.jpg",
                          alt="Photo for Home Page")),
        tabPanel("About Us", 
                 tags$br(class="annatext", 
                        textOutput("annadescription")),
                 tags$img(class="annaimage",
                          src="anna-photo.jpg",
                          alt="Anna's Photo", 
                          align="center"),
                 
                 tags$br(textOutput("anokhidescription")), 
                 
                 tags$br(textOutput("ishitadescription")),
                 
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
        tabPanel("Glucose vs. BMI", plotOutput("scatterplot"), uiOutput("category")),
        tabPanel("Smoking Data",
                 dataTableOutput("table_data"),
                 uiOutput("smokingStatus")
        ),
        tabPanel("Summary")
    )
))
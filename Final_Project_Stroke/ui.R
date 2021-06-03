# Load libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

# Define UI for application that makes our Final Project App
shinyUI(fluidPage(
    # Allows for styles changes from css file
    theme = "final-project-style.css",
    
    # Application title
    titlePanel("Factors Affecting Stroke"),
    
    # Defining Tabs
    tabsetPanel(
        tabPanel("Home",
                 tags$br(textOutput("homepageData")),
                 tags$br(textOutput("homepageAudience")),
                 tags$br(),
                 tags$img(class="homepage",
                          src="background-image.jpg",
                          alt="Photo for Home Page")),
        tabPanel("About Us", 
                 tags$br(textOutput("annadescription")),
                 tags$img(class="annaimage",
                          src="anna-photo.jpg",
                          alt="Anna's Photo", 
                          align="center"),
                 
                 tags$br(textOutput("anokhidescription")),
                 tags$img(class="anokhiimage",
                          src="",
                          alt="Anokhi's Photo",
                          align="center"),
                 
                 tags$br(textOutput("ishitadescription")),
                 tags$img(class="ishitaimage",
                          src="",
                          alt="Ishita's Photo",
                          align="center"),
                 
                 tags$br(textOutput("neildescription")),
                 tags$img(class="neilimage",
                          src="",
                          alt="Neil's Photo",
                          align="center")
                 ),
        
        tabPanel("Male vs. Female", 
                 sidebarLayout(
                     sidebarPanel(radioButtons("color", label=h3("Bar Graph Color"),
                                               choices = list("Blue"   = "royalblue",
                                                              "Violet" = "violet",
                                                              "Indigo" = "purple",
                                                              "Green"  = "green4",
                                                              "Yellow" = "gold",
                                                              "Orange" = "darkorange",
                                                              "Red"    = "red2"),
                                               selected = "royalblue"),
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
        tabPanel("Summary", 
                 tags$br(textOutput("summarypattern")),
                 tags$br(textOutput("summaryevidence")),
                 tags$br(textOutput("summaryimplications")),
                 tags$br(textOutput("summarydataquality")),
                 tags$br(textOutput("summaryfutureideas"))
                 )
    )
))
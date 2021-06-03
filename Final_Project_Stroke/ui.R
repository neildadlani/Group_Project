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
                 tags$br(textOutput("homepageQuestions")),
                 tags$br(textOutput("question1")),
                 tags$br(textOutput("question2")),
                 tags$br(textOutput("question3")),
                 tags$br(),
                 tags$img(class="homepage",
                          src="homepage-image.jpg",
                          alt="Photo for Home Page")),
        tabPanel("About Us", 
                 tags$br(textOutput("annadescription")),
                 tags$img(class="annaimage",
                          src="anna-photo.jpg",
                          alt="Anna's Photo"),
                 tags$br(textOutput("anokhidescription")),
                 tags$img(class="anokhiimage",
                          src="anokhi-photo.jpg",
                          alt="Anokhi's Photo"),
                 tags$br(),
                 tags$br(textOutput("ishitadescription")),
                 tags$img(class="ishitaimage",
                          src="ishita-photo.jpg",
                          alt="Ishita's Photo"),
                 tags$br(),
                 tags$br(textOutput("neildescription")),
                 tags$img(class="neilimage",
                          src="neil-photo.jpg",
                          alt="Neil's Photo"), 
                 ),
        
        tabPanel("Male vs. Female", 
                 sidebarLayout(
                     sidebarPanel(radioButtons("color", label=h3("Bar Graph Color:"),
                                               choices = list("Blue"   = "royalblue",
                                                              "Violet" = "violet",
                                                              "Indigo" = "purple",
                                                              "Green"  = "green4",
                                                              "Yellow" = "gold",
                                                              "Orange" = "darkorange",
                                                              "Red"    = "red2"),
                                               selected = "royalblue"),
                                  uiOutput("selectAge")
                     ),
                     
                     # Show a plot of the generated distribution
                     mainPanel(
                         plotOutput("genderPlot"),
                         textOutput("bargraphDescription"))
                 )),
        tabPanel("Glucose vs. BMI", 
                 sidebarLayout(
                    sidebarPanel(textOutput("scatterplotDescription")),
                    mainPanel(
                        plotOutput("scatterplot"),
                        uiOutput("category")),
        )),
        tabPanel("Smoking Data",
                 sidebarLayout(
                     sidebarPanel(uiOutput("smokingStatus"),
                                  textOutput("smokingDescription")),
                 mainPanel(
                     dataTableOutput("table_data"))
        )),
        tabPanel("Summary", 
                 tags$br(textOutput("summarypattern")),
                 tags$br(textOutput("summaryevidence")),
                 tags$br(textOutput("summaryimplications")),
                 tags$br(textOutput("summarydataquality")),
                 tags$br(textOutput("summaryfutureideas"))
                 )
    )
))
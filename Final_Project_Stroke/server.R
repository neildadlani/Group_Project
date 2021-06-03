# Load libraries
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

# Reading our Dataset
data <- read.delim("healthcare-dataset-stroke-data.csv", sep= ",")

# Changing N/A to NA and omitting it from dataset
data <- data
data[data == "N/A"] <- NA
na.omit(data)

bmi_data <- data %>%
    select(-c(id)) %>%
    na.omit(bmi)


## Categorizing  BMI by breaks of 10 for clear plotting.
bmi_data <- bmi_data %>%  
    mutate(bmi_data, category = round(as.numeric(bmi_data$bmi)/10, digits=0)*10) %>% 
    arrange(category)




#removes 'Unknown' from 'Smoking status' variable
data <- data
data[data == "Unknown"] <- NA
na.omit(data)

## Data Used to create Interactive Table
table_data <- data %>% 
    select(gender, age, hypertension, heart_disease, smoking_status, stroke) %>% 
    na.omit(smoking_status) 




# Defining server logic required for our Shiny App
shinyServer(function(input, output) {
    sample <- reactive({
        bmi_data <- data%>% 
            na.omit(bmi)
        
    })
    
    #Plotting Bar Graph - Stroke vs Gender
    output$distPlot <- renderPlot({
        ggplot(changed_data(), aes(gender))+
            geom_bar(fill = input$color, na.rm=TRUE)+
            labs(title = "Stroke in Male vs Female")
    })
    
    changed_data <- reactive({
        data %>% 
            select(gender, stroke, age) %>% 
            filter(age %in% input$years)
    })
    
    
    ##slider for Age in Bar Graph
    output$selectAge <- renderUI({
        sliderInput("years",
                    h3("Age:"),
                    min = 0,
                    max = 82,
                    value = 50)
    })
    
    
    #Plotting Scatter Graph for BMI against Average Glucose Level
    
    output$scatterplot <- renderPlot({
        ggplot(scatterplot_Data(), aes(x=avg_glucose_level,
                                       y= category))+
            geom_point(color= "red")+
            labs(title = " Average Glucose Level and BMI Correlation",
                 x= "Average Glucose Level (mg/dL)", 
                 y= "BMI (kg/m^2)"  )
        
        
    })
    
    # Data used to plot and render the scatter plot
    scatterplot_Data <- reactive({
        bmi_data %>% 
            filter(category %in% input$category)
        
    })
    
    #Choose BMI widget
    output$category <- renderUI({
        checkboxGroupInput("category", label= "Choose BMI",
                           choices = unique(bmi_data$category), selected = c(10:100))
    })
    
    
    
    
    # Renders and plots Table
    output$table_data <- renderDataTable(
        smoking_Data()
        
    )
    
    #Reactive function to render table
    smoking_Data <- reactive({
        table_data %>% 
            filter(smoking_status %in% input$status)
        
    })
    # Checkbox to filter smoking status
    output$smokingStatus <- renderUI({
        checkboxGroupInput("status", label = "Choose Smoking Status",
                           choices = unique(table_data$smoking_status), selected = "formerly smoked")
    })
    
    
    # Outputs homepage data 
    
    output$homepageData <- renderText({
        paste("Data:
This dataset was created as a means to predict whether a person is likely to suffer from a stroke, based on a certain number of parameters. 
These parameters include categories such as gender, age, various diseases, and even data about the person’s smoking habits.
We came across this dataset on Kaggle, which is a crowd-sourced platform to attract data scientists so that they can share and publish data sets")
    })
    
    output$homepageAudience <- renderText({
        paste0( "Audience:
    This dataset can be used by most people, however, it’s intended audience would be those who are interested in looking at their likelihood of having a stroke. 
    To do so, the dataset looks at various factors such as age, other diseases, smoking, etc. to help people effectively understand and predict their chances of having a stroke.")
        
        
    })
    
    #Outputs About us Tab Data
    
    output$annadescription <- renderText({
        paste("Anna Shade: I am a firstyear student who grew up within 30 minutes of the UW Seattle campus my whole life. 
               I am undeclared for a major, but have an interest in Informatics or something within the healthcare industry. 
               I love playing with my two puppies, volleyball, and binge-watching the Marvel movies.")
    })
    
    output$anokhidescription <- renderText({
        paste("Anokhi Shah:  I am a first year student who was born in Los Angeles, however I have never lived in the US since then. 
               I was raised in India and have come to the United States to pursue my higher education.
               I am hoping to become a double major in psychology and Informatics. 
               My goal is to contribute towards the field of artificial intelligence in the long term. ")
    })
    
    output$ishitadescription <- renderText({
        paste("Ishita Saxena: I am a current first year student from the Bay Area, California.
               I have an interest in technology and I am hoping to major in Informatics. 
               I enjoy design and hope to pursue a career in UX design in the future.")
    })
    
    output$neildescription <- renderText({
        paste("Neil Dadlani: A dedicated and self motivated freshman focusing to major in Informatics and Economics.
               Born and raised in Dubai. Enjoys playing soccer on the weekends and cooking in the evenings. ")
    })
    
    
})
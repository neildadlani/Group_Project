
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

data <- read.delim("healthcare-dataset-stroke-data.csv", sep= ",")


data <- data
data[data == "N/A"] <- NA
na.omit(data)

data1 <- data %>%
    select(-c(id)) %>%
    na.omit(bmi)
##categorizes bmi
data1 <- data1 %>%  
    mutate(data1, category = round(as.numeric(data1$bmi)/10, digits=0)*10)
    
#removes Unkown
data <- data
data[data == "Unknown"] <- NA
na.omit(data)

##data 2 is the table that is published
data2 <- data %>% 
    select(gender, age, hypertension, heart_disease, smoking_status, stroke) %>% 
    na.omit(smoking_status)
    


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    sample <- reactive({
        data1 <- data%>% 
        na.omit(bmi) %>% 
        filter(gender %in% input$gender)
})
   

output$distPlot <- renderPlot({
    ggplot(changed_data(), aes(gender))+
        geom_bar(fill = input$color, na.rm=TRUE)+
        labs(title = "Stroke in Male vs Female")
})
    
output$linegraph <- renderPlot({
    ggplot(data1, aes(x=avg_glucose_level,
                     y= category))+
        #scale_x_continuous(breaks = 30:40)+
        #cut(as.numeric(data1$bmi), breaks=10 )+
        geom_point(fill =input$color)
        
})

##slider for age
output$selectAge <- renderUI({
    sliderInput("years",
                "Age:",
                min = 0,
                max = 82,
                value = 50)
})

changed_data <- reactive({
    data %>% 
        select(gender, stroke, age) %>% 
        filter(age %in% input$years)
})

##doesn't render the plot
sample1 <- reactive({
    data2 %>% 
        select(gender, age, hypertension, heart_disease, smoking_status, stroke) %>% 
        na.omit(smoking_status) %>% 
        filter(smoking_status %in% input$status)
        
    
})

widget_data <- reactive({
    data1 %>% 
        filter(category %in% input$category)
})

output$category <- renderUI({
    checkboxGroupInput("category", label= "Choose BMI",
                       choices = unique(data1$category), selected = 20)
})

##renders table
output$data2 <- renderDataTable(
    data2
)

##checkbox for smoking status - need to work
output$smokingStatus <- renderUI({
    checkboxGroupInput("status", label = "Choose Smoking Status",
                       choices = unique(data2$smoking_status), selected = "never smoked")
})




output$annadescription <- renderText({
    paste0("Anna Shade: I am a first-year student who grew up within 30 minutes of the UW Seattle campus my whole life. 
               I am undeclared for a major but have an interest in Informatics or something within the healthcare industry. 
               I love playing volleyball, hanging out with my friends, and binge-watching the Marvel movies.")
})

output$anokhidescription <- renderText({
    paste0("Anokhi Shah: ")
})

output$ishitadescription <- renderText({
    paste0("Ishita Saxena: ")
})

output$neildescription <- renderText({
    paste0("Neil Dadlani: A dedicated and self motivated freshman focusing to major in Informatics and Economics.
               Born and raised in Dubai. Enjoys playing soccer on the weekends and cooking in the evenings. ")
})


})




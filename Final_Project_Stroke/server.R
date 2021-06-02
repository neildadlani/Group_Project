
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

data <- read.delim("healthcare-dataset-stroke-data.csv", sep= ",")

# lolol <- data %>% 
#     select(age, bmi, gender) 
# 
# lolol$groups <- cut(lolol$age, breaks=c(0,50,60,70, Inf))
# table(cut(lolol$age, breaks=c(0,50,60,70,Inf)))
# head(table)
#     



data45to65 <- data %>% 
    select(-c(id)) %>% 
    filter( age >= 45) %>% 
    filter( age <= 65) %>% 
    filter(bmi >= 30) %>% 
    arrange(age)

data55to65 <- data %>% 
    select(-c(id)) %>% 
    filter( age >=55) %>% 
    filter(age <= 65) %>% 
    # filter(bmi >= 30)
    filter( avg_glucose_level >= 108.00)


data1 <- data %>%
    select(-c(id)) %>% 
    na.omit(bmi)
    # filter(gender %in% input$gender)
    

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    sample <- reactive({
        data1 <- data%>% 
        select(-c(id)) %>% 
        na.omit(bmi) %>% 
        filter(gender %in% input$gender)
           
             # select(-c(id)) %>% 
            # filter( age >= 45) %>% 
            # filter( age <= 65) %>% 
            # group_by(avg_glucose_level) %>%
            # arrange(age) %>%
            # na.omit(bmi) %>% 
            # sample_n(input$n, replace=TRUE)

})
    
    
 
#we have to group bmi 

    

# output$scatterplot <- renderPlot({
#     ggplot(strokeSample(), aes(x= bmi,
#                                y= age,
#                                na.rm = TRUE))+
#         geom_bar(stat = "identity", fill = input$color)+
#         #scale_x_continuous(breaks = 30:40)+
#         # ylim(0,1)+
#         labs(title = "BMI in correlation to other factors")
#     
# 
# })

output$distPlot <- renderPlot({
    ggplot(changed_data(), aes(gender))+
        geom_bar(fill = input$color, na.rm=TRUE)+
        labs(title = "Stroke in Male vs Female")
})
    


output$male_or_female <- renderUI({
    checkboxGroupInput("gender", label="Male or Female",
                       choices=unique(data$gender), selected="Male")
})

output$linegraph <- renderPlot({
    ggplot(data55to65, aes(x=age,
                     y= avg_glucose_level))+
         # cut(data$avg_glucose_level, breaks=10 )
        geom_point(fill =input$color)
        
})

changed_data <- reactive({
    stroke_data %>% 
        select(gender, stroke, age) %>% 
        filter(age %in% input$years)
})

output$selectAge <- renderUI({
    sliderInput("years",
                "Age:",
                min = 0,
                max = 82,
                value = 50)
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

# output$scatterplot <- renderPlot({
#     ggplot(data, aes(bmi, heart_disease))+
#         geom_point(fill = input$color)+
#         labs(title = "BMI vs heart disease")
# 
# 

})




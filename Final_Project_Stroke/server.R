
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

data <- data
data[data == "N/A"] <- NA
na.omit(data)

data1 <- data %>%
    select(-c(id)) %>%
    na.omit(bmi)

    


data <- data
data[data == "Unknown"] <- NA
na.omit(data)

data2 <- data %>% 
    select(gender, age, hypertension, heart_disease, smoking_status, stroke) %>% 
    na.omit(smoking_status)


# data45to65 <- data1 %>% 
#     select(-c(id)) %>% 
    
    # filter( age >= 45) %>% 
    # filter( age <= 65) %>% 
    # filter(bmi >= 30) %>% 
    
    

# data55to65 <- data %>% 
#     select(-c(id)) %>% 
#     filter( age >=55) %>% 
#     filter(age <= 65) %>% 
#     # filter(bmi >= 30)
#     filter( avg_glucose_level >= 108.00)


data1 <- data %>%
    select(-c(id)) %>% 
    na.omit(bmi)
    # filter(gender %in% input$gender)
    
data1 <- data1 %>%  
    mutate(data1, category = round(as.numeric(data1$bmi)/10, digits=0)*10)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    sample <- reactive({
        data1 <- data%>% 
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
    


output$chooseBMI <- renderUI({
    checkboxGroupInput("gender", label="Choose BMI",
                       choices=unique(data1$bmi), selected="Male")
})

output$linegraph <- renderPlot({
    ggplot(data1, aes(x=category,
                     y= avg_glucose_level))+
        #scale_x_continuous(breaks = 30:40)+
        #cut(as.numeric(data1$bmi), breaks=10 )+
        geom_point(fill =input$color)
        
})

changed_data <- reactive({
    data %>% 
        select(gender, stroke, age) %>% 
        filter(age %in% input$years)
})

sample1 <- reactive({
    data2 %>% 
        select(gender, age, hypertension, heart_disease, smoking_status, stroke) %>% 
        na.omit(smoking_status) %>% 
        filter(smoking_status %in% input$status)
})



output$selectAge <- renderUI({
    sliderInput("years",
                "Age:",
                min = 0,
                max = 82,
                value = 50)
})

output$data2 <- renderDataTable(
    data2
)

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

# output$scatterplot <- renderPlot({
#     ggplot(data, aes(bmi, heart_disease))+
#         geom_point(fill = input$color)+
#         labs(title = "BMI vs heart disease")
# 
# 

})




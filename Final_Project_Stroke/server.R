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
            labs(x = "Gender",
                 y = "Count",
                 title = "Stroke in Males vs Females")
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
        paste("Anna Shade: I am a first year student who grew up within 30 minutes of the UW Seattle campus my whole life. 
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
    
    output$summarypattern <- renderText({
        paste("There are lots of factors that affect people having a stroke, and none of them absolutely ensure that you will 
              have one if the factors do apply to you, but there are some patterns that increase the likelihood of you experiencing 
              a stroke. From our dataset, you can see that the likelihood of you having a stroke is increased if you are a younger 
              male or an older female. Our findings show that women are typically older when they experience a stroke, and as you 
              get older in general, no matter what gender you identify with, your likelihood of experiencing a stroke grows.")
    })
    
    output$summaryevidence <- renderText({
        paste("You can see this in our first interactive graph, the bar graph that shows how many people of each gender experienced 
              a stroke from this dataset. For children 6 years and younger, there are more males that experience stroke than females.
              However, after about 6 years old, for almost every other age in the dataset, more females experienced a stroke than 
              males. We used a bar chart to easily show the difference between how many females and males had a stroke. The bar chart
              also shows how the older you are, the more likely you are to have a stroke. You can see this in the change of the y-axis 
              numbers. As you increase in age using the slider widget, you can see how the y-axis grows and the bar graph goes higher 
              to that increased count.")
    })
    
    output$summaryimplications <- renderText({
        paste("A stroke is described by your brain cells dying due to your brain tissue not getting enough oxygen or nutrients because 
              the blood supply to part of your brain has decreased or been blocked. This can be caused by a wide variety of factors. 
              These findings form implications that things such as trauma and life experience can cause strokes, because the older you 
              are, the more likely you are to have experienced more trauma in your life. Whether this is seen from a car crash or an 
              intense surgery, overall, there is potential that due to this a stroke more likely. However, trauma can still occur at a 
              young age, allowing for young people to still experience strokes. This pattern and finding also implies that things that 
              females encounter or take in their life that men don’t could also potentially affect the likelihood of you having a stroke, 
              such as birth control or hormone pills.")
    })
    
    output$summarydataquality <- renderText({
        paste("For the most part, our data quality did provide strong and beneficial data. The wide variety in qualities and factors and
              well as the large abundance of individuals included in the dataset provide more reassurance that the data is of reasonably 
              good quality. However, there are definitely other factors that provide a larger probability of having a stroke that were not 
              included in this dataset that could have been stronger factors or relating factors to these. This could cause viewers to think 
              that these factors are increasing the likelihood of having a stroke, when in reality it is a different factor that actually is
              a component that is causing it. For example, a factor not included in this dataset that increases your likelihood in having a 
              stroke is if there is a history of stroke in your family. There could be many individuals in this dataset that this applies to 
              that we are unaware of that play a larger role in them having had a stroke than the factors listed. The dataset also did not 
              provide us with much information on how the data was collected and what the discussion process was for including certain individuals
              within it. This makes it hard for us to know that the data process was unbiased. Due to this, we are unsure if the implementing of 
              including certain individuals targeted certain population groups or potentially harmed any. ")
    })
    
    output$summaryfutureideas <- renderText({
        paste("There are many more steps that could be taken to spread information on the likelihood of having a stroke. This information could 
              benefit so many individuals in how they could benefit or change their lifestyles to help increase their odds of not having 
              a stroke in their future. Going forward for this final project there are more steps that could be taken after completing the final 
              project about spreading the apps and information so that more people outside of this class environment can benefit from the findings.
              This could be done by publishing it on a website that the public has access to, using social media to spread the information, and 
              many other ways. ")
    })
})
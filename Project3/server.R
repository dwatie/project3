#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
library(caret)
library(plotly)
library(ggplot2)
library(randomForest)
library(mathjaxr)



# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    collegeBall <- read.csv("cbb19.csv")
    getData <- reactive({
        wccB10 <- collegeBall %>% select(TEAM, CONF, G, W, X2P_O, X2P_D, X3P_O, X3P_D, TOR, TORD)     %>% filter(CONF == c("WCC", "B10"))
    })
    
    
    output$wccB10Table <- renderDataTable({
        
        getData()
    })
    
    output$plots <- renderPlot({
        if (input$plotnum == "gmesPlot"){ 
            G = ggplot(wccB10, aes(x = CONF, y = G)) + geom_bar(stat = "identity")
        }
        if (input$plotnum == "winsPlot"){
              G = ggplot(wccB10, aes(x = CONF, y = W))+ geom_bar(position = "dodge",
                                                                 stat = "identity",
                                                                 aes(fill = TEAM))
        }
        if (input$plotnum == "densityPlot"){
              G = ggplot(wccB10, aes(x = G)) + geom_density(aes(fill = CONF),
                                                            alpha = 0.5,
                                                            kernel = "gaussian")
        }
        if (input$plotnum == "boxPlot"){
              G = plot_ly(wccB10, x = ~X3P_O, color = ~CONF, type = "box")
        }
        G
    })

    output$confsumms <- renderDataTable({
        
        if (input$datasums == "confWins"){
            M = wccB10 %>% group_by(CONF) %>% 
                summarise(Min = min(W),
                          Med = median(W), 
                          Avg = mean(W), 
                          Max = max(W), 
                          StDev = sd(W))
        }
        if (input$datasums == "confTwo"){
            M = wccB10 %>% group_by(CONF) %>%
                summarise(Min = min(X2P_O),
                          Med = median(X2P_O), 
                          Avg = mean(X2P_O), 
                          Max = max(X2P_O), 
                          StDev = sd(X2P_O))
        }
        if (input$datasums == "confThree"){
            M = wccB10 %>% group_by(CONF) %>%
                summarise(Min = min(X3P_O),
                          Med = median(X3P_O), 
                          Avg = mean(X3P_O), 
                          Max = max(X3P_O), 
                          StDev = sd(X3P_O))
        }
        if (input$datasums == "confTor"){
            M = wccB10 %>% group_by(CONF) %>%
                summarise(Min = min(TOR),
                          Med = median(TOR), 
                          Avg = mean(TOR), 
                          Max = max(TOR), 
                          StDev = sd(TOR))
        }
        M
        
        
        
        set.seed(1)
        train <- sample(1:nrow(wccB10), size = nrow(wccB10)*0.7)
        test <- dplyr::setdiff(1:nrow(wccB10), train)
        wccB10Train <- wccB10[train, ]
        wccB10Test <- wccB10[test, ]
        wccB10TrainA <-wccB10Train %>% select(CONF, G, W, X2P_O, X2P_D, X3P_O, X3P_D, TOR, TORD)
        wccB10TestA <- wccB10Test %>% select(CONF, G, W, X2P_O, X2P_D, X3P_O, X3P_D, TOR, TORD)
        
        
        gmesVar <- wccB10TrainA$G
        two<- wccB10TrainA
        
        rfFit <- train(W ~ input$gmesVar, data = wccB10TrainA, 
                       method = "rf",
                       trControl = trainControl(method = "repeatedcv",
                                                repeats = 3,
                                                number = 10),
                       linout = TRUE,
                       tuneGrid = data.frame(mtry = 1:10),
                       data = wccB10TrainA)
        
        bestLm <- lm(W ~ input$gmesVar, data = wccB10TrainA)
        
        ClassFit <- train(W ~ input, data = wccB10TrainA,
                          method = "rpart",
                          preProcess = c("center", "scale"),
                          trControl = trCtrl)
        
        models <- list(c(ranfor, linreg, classtree))
        models[[1]] <<- rfFit
        models[[2]] <<- bestLm
        models[[3]] <-- classfit
        
        
        output$info <- renderText({
            p("The three modeling approaches that will be used are the Multiple Linear Regression Model, Classification Tree Model, and the Random Forest Model. They will be used to find a linear regression equation that is made up of a response variable which in this case will the wins variable, an intercept, and a combination of predictor variables.) Multiple Linear Regression Model  pros and cons go here  Classification Tree Model pros and cons go here  Random Forest Model  pros and cons go here")
            
        })
        
    })    
    })




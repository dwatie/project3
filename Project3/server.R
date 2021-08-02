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
    })    
    })




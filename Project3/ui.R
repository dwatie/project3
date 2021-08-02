#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyverse)
library(caret)
library(plotly)
library(ggplot2)
library(randomForest)
library(mathjaxr)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    dashboardHeader(title = "WCC & B10 Basketball 2019"),
    dashboardSidebar(
        menuItem("About", tabName = "about", icon = icon("th")),
        menuItem("Data", tabName = "data", icon = icon("th")),
        menuItem("Data Exploration", tabName = "dataExpl", icon = icon("th")),
        menuItem("Modeling", tabName = "model", icon = icon("th"))
    ),
    dashboardBody(
        # Boxes need to be put in a row (or column)
        tabItems(
            tabItem(tabName = "data",
                fluidRow(
                    box(dataTableOutput("wccB10Table")))),
            
            tabItem(tabName = "dataExpl",
                fluidRow(
                    box(selectInput("plotnum", "Distributions:", 
                                     c("Total Games Played by Conference" = "gmesPlot",
                                       "Density Plot of Games Played by Conference" 
                                       = "densityPlot",
                                       "Wins by Team and Conference" = "winsPlot",
                                       "3pt Percentage by Conference" = "boxPlot"))),
                    
                    box(plotOutput("plots"))),
                
                    box(dataTableOutput("confsumms")),
                    
                    box(selectInput("datasums", "Summary Statistics: ", 
                                    c("Summary of Wins by Conference" = "confWins",
                                      "Summary of 2PT Percentages" = "confTwo",
                                      "Summary of 3PT Percentages" = "confThree",
                                      "Summary of Turnover Forced" = "confTor"))),
                
                    ))
                )    
                    
                    
                    )        
            )


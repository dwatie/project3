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
        sidebarMenu(id = 'sidebarmenu',
                    menuItem("About", tabName = "about", icon = icon("th")),
                    menuItem("Data", tabName = "data", icon = icon("th")),
                    menuItem("Data Exploration", tabName = "dataExpl", icon = icon("line-chart")),
                    menuItem("Modeling", tabName = "model", icon = icon("line-chart"),
                             menuSubItem("Modeling Info", tabName = "info",),
                             menuSubItem("Model Fitting", tabName = "fitting"),
                             menuSubItem("Prediction", tabName = "pred"))
    )),
    dashboardBody(
        # Boxes need to be put in a row (or column)
        tabItems(
            tabItem(tabName = "about",
                    fluidRow(
                        box(
                            img(src="ncaa basketball.html", height = "100px", width = "100px"), p("The purpose of the app is to be able to take a look in the 2019 college basketbal season and explore the statistics from each team. It will give you a look at graphs and numerical summaries and give the option to look at different statistics. There are four main tabs in this app. The tabs that are available are the About section, Data section, Data Exploration section, and Modeling section. The modeling section is broken up into three subtabs that are Model Info, Model Fitting, and Prediction."), br(), p("The Data tab displays the data set that is used for the study. The data is of the 2019 NCAA Basketball season. The variables in the data set are Team, Conference, Games Played, Games Won, 2 Point Field Goal Percentage, 2 point Field Goal Percentage against,  3 Point Field Goal Percentage, 3 point Field Goal Percentage against, Turnovers forced, Turnovers Committed, and there are many more that contribute to the data set. The statistics found in the app were calculated using a subsetted data set that used the conferences of the West Coast Conference (WCC) and the Big Ten (B10). The data set can be found at ",a(href="https://www.kaggle.com/andrewsundberg/college-basketball-dataset?select=cbb.csv", "College Basketball Data")), br(), p("The next tab is the Data Exploration section. Here there will be various graphs and numerical summeries that explore the subsetted data set."), br(), p("The last tab is the Modeling tab. In this tab there are three subtabs, the first is the info subtab that will explain the three modeling approaches, the benefits of each,
and the drawbacks of each. The next subtab is the model fitting tab, where the data is being split into a training and testing set. Then the models will be fitted to the training data set. The final subtab is Prediction where the models that where created in the fitting tab are used for prediction against the actual values in the testing set and the RMSE will be used to determine the best model to use for prediction.")
                    ))),
            
            
            
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


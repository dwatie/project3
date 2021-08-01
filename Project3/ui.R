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
ui <- dashboardPage(
    dashboardHeader(title = "WCC & B10 Basketball 2019"),
    dashboardSidebar(
        menuItem("About", tabName = "about", icon = icon("th")),
        menuItem("Data", tabName = "data", icon = icon("th")),
        menuItem("Data Exploration", tabName = "dataExpl", icon = icon("th")),
        menuItem("Modeling", tabName = "model", icon = icon("th"))
    ),
    dashboardBody(
        # Boxes need to be put in a row (or column)
        fluidRow(
            box(plotOutput("plot1", height = 250)),
            
            box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
            )
        )
    )
)

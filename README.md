# project3
The purpose of the app is to be able to take a look in the 2019 college basketbal season and explore the statistics from each team. It will give you a look at graphs and numerical summaries and give the option to look at different statistics. There are four main tabs in this app. The tabs that are available are the About section, Data section, Data Exploration section, and Modeling section. The modeling section is broken up into three subtabs that are Model Info, Model Fitting, and Prediction. The statistics found in the app were calculated using a subsetted data set that used the conferences of the West Coast Conference (WCC) and the Big Ten (B10). The app gives an in depth look on what could affect the wins a team will earn and will predict the response variable, wins, by using fitted models for prediction.

library(shiny)
library(shinydashboard)
library(tidyverse)
library(caret)
library(plotly)
library(ggplot2)
library(randomForest)
library(mathjaxr)

install.packages("shiny", "shinydashboard", "tidyverse","caret","plotly", "ggplot2", "randomForest", "mathjaxr")

shiny::runGitHub("project3", username = "dwatie")

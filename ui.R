# Final Project 
# INFO 201 B

# ui.R
library(shiny)
library(plotly)
library(styler)
library(lintr)
library(ggplot2)

# data from analysis
source("analysis.R")

#
shinyUI(navbarPage( 
  title = "", 
  tabsetPanel(
    tabPanel(
      
    ), 
    tabPanel(
      "call_type_v_precinct" #Nemo
    ), 
    tabPanel(
      
    ), 
    tabPanel(
      
    )
  )
))

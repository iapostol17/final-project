# Assignment Final Project
# INFO 201 B
# This part was written by Sandy Yang

# server.R
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)

source("analysis.R")

# Sandy
# filter the necessary data for panel 1
panel_1_filtered <- reactive({
  data <- crisis %>%
    filter(
      year > round(input$year_var[1]),
      year < round(input$year_var[2])
    )
  data # return data
})

# Nemo
# plotting for tab 2
# goes here

shinyServer(function(input, output) {
  
}
)



# Assignment Final Project
# INFO 201 B
# This part was written by Sandy Yang

# server.R
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)

source("analysis.R")



shinyServer(function(input, output) {
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
  # data reactivity and plotting for tab 2
  tab_2_filtered <- reactive({
    data <- calls_crimes_and_crisis_precincts %>% 
      filter(Precinct == input$precincts)
    # call distribution check, will choose selected option
    # if the "All" option is not chosen
    if (input$call_result_disposition != "*") {
      data <- data %>% 
        filter(Distribution == input$call_result_disposition)
    }
    # call type check, will choose selected option if
    # the "All" option is not chosen
    if (input$call_type != "*") {
      data <- data %>% 
        filter(Call.Type = input$call_type)
    }
    # returns the reactive dataset
    data
  })
}
)



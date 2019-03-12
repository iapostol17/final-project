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
    data <- crisis_times %>%
      filter(
        year > input$year_var[1],
        year < input$year_var[2]
      )
    
    # filter out the pricinct if All option was not chosen
    if (input$precinct_var != "All") {
      data <- data %>% 
        filter(precinct == input$precinct_var) 
    }
    # filter use of force or not
    if(input$use_forece) {
      data <- data %>% 
        filter(Use.of.Force.Indicator == "Y")
    }
    data # return data
  })
  
  # generate plot here 
  output$num_of_call_vs_date <- renderPlotly({
    p <- ggplot(
      data = panel_1_filtered(),
      mapping = aes_string(
        x = "Reported.Date",
        y = "Sector",
        color = "Precinct"
      )
    ) +
      geom_point() +
      labs(
        x = "Year",
        y = "Number of Events",
        title = "Number of Crisis Call vs Year"
      )
    
    if (input$smooth) {
      p <- p + geom_smooth(se = FALSE)
    }
    p
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



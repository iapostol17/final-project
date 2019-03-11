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

yaer_range <- range(date$year)
#
shinyUI(navbarPage( 
  
  title = "Seattle Crisis Call Analysis",
  tabsetPanel(
    
    # Sandy
    # Showing the number of event (y axix)
    # x axix = month 
    # saperate time by color (can show trendline)
    # allow user filter the data by year of report
    # Use of force or not
    # Type of event
    tabPanel(
      "Numbers of Calls verse year",
      titlePanel("Filter your calls"),
      sidebarLayout(
        sidebarPanel(
          sliderInput(
            "year_var",
            label = "select a year",
            min = min(yaer_range),
            max = max(yaer_range),
            value = yaer_range
          )
        ),
        mainPanel (
          plotOutput("num_of_call_vs_date")
        )
      )
    ), 
    # Nemo
    # Compare/contrast of call type with regards to precinct
    # Bar graph column by call type, fill by precinct
    # Can change to focus on specific crimes by precinct
    tabPanel(
      "call_type_v_precinct"
    ), 
    tabPanel(
      ""
    ), 
    tabPanel(
      ""
    )
  )
))

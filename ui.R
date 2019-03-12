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

yaer_range <- range(crisis$year)
select_values <- levels(crisis$Precinct)[2:7]

#
ui <- shinyUI(navbarPage( 
  
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
          
          # filtera year 
          dateRangeInput(
            "year_var",
            label = "type or select a year",
            start = yaer_range[1],
            end = yaer_range[2],
            format = "yyyy",
            startview = "year"
          ),
          
          selectInput(
            "precinct",
            label = "Select a percinct",
<<<<<<< HEAD
            choices = precinct_choices
=======
            choices = list()
>>>>>>> ec81cdb7565991f8e7dea6ae2c5e776d0292b0e6
          ),
          
          # showing trend line or not
          checkboxInput(
            "smooth", 
            label = strong("Show Trendline"), 
            value = TRUE
          ),
          
          # filter use of force or not
          checkboxInput(
            "use_forece", 
            label = strong("only include use of force"), 
            value = F            
          )
          
        ),
        mainPanel(
          plotOutput("num_of_call_vs_date")
        )
      )
    ), 
    
    # Nemo
    # Compare/contrast of call type with regards to precinct
    # Bar graph column by call type, fill by precinct
    # Can change to focus on specific crimes by precinct
    tabPanel(
      "Call Types and Dispositions by Precinct", 
      
      sidebarLayout(
        sidebarPanel(
          "options", 
          
          # These buttons will allow users to select 
          checkboxGroupInput(
            "precincts", 
            label = "Seattle Police Department Precinct Names", 
            choices = precinct_choices, 
            selected = precincts
          ), 
          
          # Input for crime distribution selection, with all as the
          # default option
          selectInput(
            "call_result_disposition", 
            label = "Disposition of Action Taken", 
            choices = disposition_choices
          ), 
          
          # Input for call types
          radioButtons(
            "call_type", 
            label = "Type of Crisis Call", 
            choices = call_choices
          )
        ), 
        mainPanel(
          
        )
      )
    ), 
    tabPanel(
      ""
    ), 
    tabPanel(
      ""
    )
  )
))

ui
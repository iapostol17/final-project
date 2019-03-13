# Final Project 
# INFO 201 B

# ui.R
library(shiny)
library(styler)
library(lintr)

# data from analysis
source("analysis.R")

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
          
          # filter a year 
          dateRangeInput(
            "year_var",
            label = "Please type in or select a year",
            start = min(crisis_times$year),
            end = max(crisis_times$year),
            min = min(crisis_times$year),
            max = max(crisis_times$year),
            format = "yyyy/mm/dd",
            startview = "month"
          ),
          
          selectInput(
            "precinct_var",
            label = "Select a percinct",
            choices = precinct_choices
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
      "Crisis Calls and Crime Dispositions by Precinct", 
      
      sidebarLayout(
        sidebarPanel(
          h3("Options"), 
          
          # These buttons will allow users to select 
          checkboxGroupInput(
            "precincts", 
            label = "Seattle Police Department Precinct Names", 
            choices = precinct_choices, 
            selected = precincts[1]
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
          # plots the output
          plotlyOutput("disp_precinct_plot"), 
          plotlyOutput("call_precinct_plot")
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

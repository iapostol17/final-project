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
            value = T           
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
  ),
  
  tabPanel("Crime Types",
           # title of page
           h1("Graph of Crimes in Seattle", align ="center"),
           h5("This interactive graph displays the most common crimes in Seattle.
              You can select a year from 2008 and up and it will display a graph
              showing different crimes that have been committed in the selected year.
              This will allow the user to see what the most/least common crime was."),
           sidebarLayout(
             sidebarPanel(
               selectInput("select", "Select Year:",
                  choices = list("2008"="2008", "2009"="2009", "2010"="2010","2011" = "2011",
                                 "2012" = "2012","2013"="2013","2014"="2014","2015"="2015","2016"="2016","2017"= "2017",
                                 "2018" = "2018"))
             ),
             mainPanel(plotOutput("crimetypes"))
           )
           )
))

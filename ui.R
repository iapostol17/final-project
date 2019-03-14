# Final Project
# INFO 201 B

# ui.R
library(shiny)
library(tidyr)
library(dplyr)
library(styler)
library(lintr)
library(leaflet)

# data from analysis
source("analysis.R")
source("data/crime_graph.R")

#
shinyUI(navbarPage(
  title = "Seattle Crisis Call Analysis",
  tabsetPanel(
    tabPanel(
      "Overview", 
      h2("Authors: Imani Apostol, Nikhil Raman, Rayna Tilley, Sandy Yang"),
      
      p("This is the analysis of Crisis Contacts Data collected by Seattle 
        Police Department. The reason for SPD department publishing this information is
         to highlight transparency around our policy, process, 
        and training with regards to police interactions with members 
        of Seattle community experiencing behavioral crisis.")
    ), 

    # Sandy
    # show the seattle area with regaed to number of crisis call
    tabPanel(
      "Numbers of Calls verses Sector in Seattle",
      titlePanel("Seattle Map in relation with crisis call"),
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "precinct_var",
            label = "Precinct",
            choices = precinct_choices[1:5]
          ), 
          selectInput(
            "year_var",
            label = "Year",
            choices = year_choices
          )
        ),
        mainPanel(
          leafletOutput("map")
        )
      )
    ),

    # Nemo
    # Compare/contrast of call type with regards to precinct
    # Bar graph column by call type, fill by precinct
    # Can change to focus on specific crimes by precinct
    tabPanel(
      "Crisis Calls and Crime Dispositions by Precinct",
      
      p(
        paste(
          "These graphs show the frequencies, distributions, and natures of crisis calls", 
          "made to any combination of Seattle Police Department Precincts. Each selection", 
          "will show not only the number of occurances of any given incident, but the portion", 
          "of those cases in which a certain call nature is handled by a specific SPD precinct.", 
          "There is a small legend below for the most-likely unfamiliar terms displayed."
        )
      ), 

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
          plotlyOutput("call_precinct_plot"),
          em(h4("Title Legend:")),
          p(paste(
            "ITA = Involuntary Treatment Act; the foundation of the current ITA court,",
            "which oversees mental health cases that are not criminal in nature."
          )),
          p(paste(
            "Geriatric Regional Assessment Team: a group consisting of chemical",
            "dependency experts, social workers, nurses, on-call occupational",
            "therapists, and geriatric (involving the elderly) psychiatrists."
          )),
          p("DMHP: Designated mental-health professional"),
          p("Onview: officers/callers are at the site of an incident")
        )
      )
    ),

    tabPanel(
      "Crime Types",
      # title of page
      h1("Graph of Crimes in Seattle", align = "center"),
      h5("This interactive graph displays the most common crimes in Seattle.
          You can select a year from 2008 and up and it will display a graph
          showing different crimes that have been committed in the selected year.
          This will allow the user to see what the most/least common crime was."),
      sidebarLayout(
        sidebarPanel(
          selectInput("select", "Select Year:",
            choices = list(
              "2008" = "2008", "2009" = "2009", "2010" = "2010", "2011" = "2011",
              "2012" = "2012", "2013" = "2013", "2014" = "2014", "2015" = "2015", 
              "2016" = "2016", "2017" = "2017",
              "2018" = "2018"
            )
          )
        ),
        mainPanel(plotOutput("crimetypes"))
      )
    ),
    
    ## Rayna Tilley
    tabPanel(
      "Crime Analysis with Respect to Time in Seattle",
      h1("Crime Types and 911 Call Types with Respect to 
         Time of Year and Time of Day", align = "center"),
      h5("information"),
      sidebarLayout(
        sidebarPanel(
          selectInput("r_sector", "Select Precinct/Sector", 
                      choices = c('West' = list(r_west),
                                  'North' = list(r_north),
                                  'East' = list(r_east),
                                  'Southwest' = list(r_southwest),
                                  'South' = list(r_south),
                                  'Unknown' = list(r_unknown))),
          selectInput("r_year", "Select Year", choices = sort(unique(r_time_data$Year), decreasing = F)),
          radioButtons("r_month/day", "Select Time Frame", choices = c("Month", "Day Time"))
        ),
        mainPanel(
          Output("r_time_crime")
        )
      )
    )
  )
))

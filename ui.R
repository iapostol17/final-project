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
      "Overview"
    ),

    # Sandy
    # show the seattle area with regaed to number of crisis call
    tabPanel(
      "Numbers of Calls verse Sector in Seattle",
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
    )
  )
))

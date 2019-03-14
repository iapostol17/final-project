# Final Project
# INFO 201 B

# ui.R
library(shiny)
library(tidyr)
library(dplyr)
library(styler)
library(lintr)
library(leaflet)
library(plotly)

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

      h5(p("In this report we will be analyzing police crisis response data in 
the Seattle area collected by the 
        Seattle Police Department. The SPD published this information to increase
transparency of concering police policies, 
        processes, and training with regards to police interactions with Seattle 
           residents experiencing behavioral crises.")),

      h5(p("We've utilized many data bases regarding 911 calls and other calls
along with police responses in order to answer
           the following questions:")),
      h5(p("1: How many crises are there per year with respect to presinct and sector. By using an interactive plot that displays
            a map of the Seattle area we are able to see the locations in which there is a greater amount of crises happening 
           and if there is a correlation to location in terms of sector and presinct.")),
      h5(p("2: Which presincts handle more calls that result in certain dispositions and results? What are these dispositions? Is
            there a certain presinct that handles more of one type of call than others?")),
      h5(p("3: How many of a certain crisis occur each year in the Seattle region? Which is the most prevalent? Which year had the 
            highest amount of crime?")),
      h5(p("4: How many emergent calls occur during each month a year? What about evening/afternoon versus morning? Is there a
            correlation to time of day?")),
      h4(p("Here our data links:")),
      a(href = "https://l.facebook.com/l.php?u=https%3A%2F%2Fdata.seattle.gov%2FPublic-Safety%2FCrisis-Data%2Fi2q9-thny%3Ffbclid%3DIwAR1_OsjbuBBFHX1mfieFLsS9ZZ5dni8JdSPiCGwCi8pJwDE1eUDZdf9rfqQ&h=AT1whrLU8k3Lmdtb6xmLl11d7rLNuXzkA47jxm5G8putw-ehBd6vqmwx5hmQZ9yZVEBA2P0xqv28FBkC-0NDWZEf3uno3yt_3dN7li0NBeyrR9U3igKUUBbQHw1zMISA0NLe1hbNraFygq_Qmfyr", "Data Base 1 - Police Department"),
      a(href = "https://l.facebook.com/l.php?u=https%3A%2F%2Fwww.seattle.gov%2Fpolice%2Finformation-and-data%2Fcrisis-contacts%3Ffbclid%3DIwAR1wIdWfjSotCyJvQ47VC4vKz9r_wMqPRd7PublqujrlyAn4bsKkvpQ1flM&h=AT1whrLU8k3Lmdtb6xmLl11d7rLNuXzkA47jxm5G8putw-ehBd6vqmwx5hmQZ9yZVEBA2P0xqv28FBkC-0NDWZEf3uno3yt_3dN7li0NBeyrR9U3igKUUBbQHw1zMISA0NLe1hbNraFygq_Qmfyr", "Data Base 2 - Police Department")
    ),

    # Sandy
    # show the seattle area with regaed to number of crisis call
    tabPanel(
      "Numbers of Calls verses Sector in Seattle",
      titlePanel("Seattle Map in relation with crisis call"),
      p("These map show the distributions of crisis calls in Seattle Police  
        Department Precincts. Each circle in the map represent the sectors
        in the area. The size of the circle is related to the number
        of crisis call. User can pick the year they interested in and 
        compare it with other years graph. Below we can see the increase number
        of crisis call in almost sector in 2015-2018."),
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
      p("Note: this data was collected from a different source."),
      sidebarLayout(
        sidebarPanel(
          selectInput("select", "Select Year:",
            choices = list(
              "2008" = "2008", "2009" = "2009", "2010" = "2010", "2011" = "2011",
              "2012" = "2012", "2013" = "2013", "2014" = "2014", "2015" = "2015",
              "2016" = "2016", "2017" = "2017",
              "2018" = "2018"
            ),
            selected = "2011"
          )
        ),
        mainPanel(plotOutput("crimetypes"))
      )
    )

    ## Rayna Tilley
  )
))

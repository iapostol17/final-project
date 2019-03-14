# Assignment Final Project
# INFO 201 B
# This part was written by Sandy Yang

# server.R
library(tidyr)
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)
library(leaflet)
library(stringr)

source("analysis.R")
source("data/crime_graph.R")

shinyServer(function(input, output) {

  # Sandy
  # filter the necessary data for panel 1
  panel_1_filtered <- reactive({
    
    # get the date of crises with respect to user's choices
    # count the number of crisis call
    precinct_crisis <- crisis %>%
      filter(substring(Reported.Date, 1, 4) == input$year_var) %>% 
      group_by(Sector) %>%
      count()
    
    # Turn the list into dataframe and combine withe the dataset that 
    # has number of crisis call in
    precinct_crisis <- full_join(precinct_crisis, sector_geo, by = "Sector")
    precinct_crisis[is.na(precinct_crisis)] <- 0
    
    data <- precinct_crisis %>%
      filter(Precinct == input$precinct_var) %>%
      mutate(popup_content = paste(
        sep = "<br/>",
        paste0("Sector: ", Sector),
        paste0("Number of crisis call: ", n)
      ))
      
      data
  })

  # generate map plot with circle showing
  # nuber of call
  output$map <- renderLeaflet({
    if (input$precinct_var == "WEST") {
      m <- make_map(47.6162, -122.3366)
    }
    if (input$precinct_var == "EAST") {
      m <- make_map(47.6149, -122.3172)
    }
    if (input$precinct_var == "NORTH") {
      m <- make_map(47.7029, -122.3348)
    }
    if (input$precinct_var == "SOUTH") {
      m <- make_map(47.5386, -122.2934)
    }

    if (input$precinct_var == "SOUTHWEST") {
      m <- make_map(47.5359, -122.3619)
    }
    m
  })

  # The function will take doubles latitude and longitude as the
  # parameter and return the corresponding map area
  make_map <- function(latitude, longitudes) {
    m <- leaflet(data = panel_1_filtered()) %>%
      setView(lng = longitudes, lat = latitude, zoom = 12) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPopups(~lng, ~lat, ~popup_content,
        options = popupOptions(closeButton = T)
      ) %>%
      addCircleMarkers(
        ~lng,
        ~lat,
        radius = ~ n / 70,
        color = "red",
        stroke = FALSE, fillOpacity = .4
      )
    m
  }
  # Nemo
  # data reactivity and plotting for tab 2
  #
  # First reactively modifying the dataset
  tab_2_filtered <- reactive({
    data <- calls_crimes_and_crisis_precincts %>%
      filter(Precinct == input$precincts)
    # call distribution check, will choose selected option
    # if the "All" option is not chosen
    if (input$call_result_disposition != "*") {
      data <- data %>%
        filter(Disposition == input$call_result_disposition)
    }
    # call type check, will choose selected option if
    # the "All" option is not chosen
    if (input$call_type != "*") {
      data <- data %>%
        filter(Call.Type == input$call_type)
    }
    # returns the reactive dataset
    data
  })

  # Last, plotting the data in an interactive manner (plotly)
  # Plot of crime Dispositions by Precinct
  output$disp_precinct_plot <- renderPlotly({
    p <- ggplot(data = tab_2_filtered(), mapping = aes_string(
      x = "Disposition",
      fill = "Precinct"
    )) +
      geom_bar(position = "dodge") +
      theme(axis.text.x = element_text(angle = 45, hjust = -1)) +
      labs(
        x = "Crime Disposition",
        y = paste("Number of Calls Made, Total =", nrow(tab_2_filtered())),
        fill = "Precincts"
      ) +
      coord_flip()

    ggplotly(p)
  })

  # Plot of crime Call Type by Precinct
  output$call_precinct_plot <- renderPlotly({
    p <- ggplot(data = tab_2_filtered(), mapping = aes_string(
      x = "Call.Type",
      fill = "Precinct"
    )) +
      geom_bar(position = "fill") +
      theme(axis.text.x = element_text(angle = 45, hjust = 100)) +
      labs(
        x = "Call Received",
        y = "Portion of Calls Received by Selected Precints",
        fill = "Precincts"
      )

    ggplotly(p)
  })

  ## Imani
  ## Crime Filter Data Set
  datatest <- select(datatest, Offense.Type, Year)
  datatest$Offense.Type <- gsub("-.*", "", datatest$Offense.Type)
  datatest$Offense.Type <- gsub(" .*", "", datatest$Offense.Type)

  ## focuses on the most common offenses
  target <- c("WARRARR", "VEH", "THEFT", "ROBBERY", "NARC", "PROPERTY", "HARASSMENT", "FRAUD", "DISTURBANCE", "BURGLARY", "ASSLT")
  newdata <- datatest %>%
    filter(Offense.Type %in% target)

  output$crimetypes <- renderPlot({

    ## filters the year
    year.graph <- newdata[newdata$Year == input$select, ]

    ## prints graph of crimes for that year
    offeneses_graph <- ggplot(data = year.graph) +
      geom_bar(
        width = .2,
        mapping = aes(x = Offense.Type, fill = Offense.Type)
      ) +
      ggtitle("Offenses in Seattle") +
      coord_flip() +
      scale_y_continuous(
        name = "Freq",
        labels = scales::comma
      )

    print(offeneses_graph)
  })
<<<<<<< HEAD
=======
  
>>>>>>> 06d53e46ccf03e37fcc22897f105fad0067f48c7
  ## Rayna Tilley
  
  output$r_time_crime <- renderPlot({
    time_crime <- r_time_data %>%
      filter(Year == input$r_year) %>%
      filter(Sector == input$r_sector)
    
    if (input$r_month/day == "Month") {
      time_crime <- time_crime %>% 
        group_by(Month) %>% 
        count()
    } else {
      time_crime <- time_crime %>% 
        group_by(Time) %>% 
        count()
    }
    time_crime
  })
  
})


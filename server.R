# Assignment Final Project
# INFO 201 B
# This part was written by Sandy Yang

# server.R
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)
library(leaflet)

source("analysis.R")
source("crime_graph.R")

shinyServer(function(input, output) {
  
  # Sandy
  # filter the necessary data for panel 1
  panel_1_filtered <- reactive({
    
  })
  
  
  
  # generate plot here 
  output$map <- renderPlot({
    m <- leaflet() %>% 
      setView(lng = -122.35, lat = 47.61, zoom = 11) %>%       
      addTiles() 
      
    if (input$precinct_var == "SOUTHWEST") {
      m <- leaflet() %>% 
        setView(lng = -122.3619, lat = 47.5359, zoom = 11) %>%       
        addTiles() 
    }
    if(input$precinct_var == "SOUTH"){
      m <- leaflet() %>% 
        setView(lng = -122.2934, lat = 47.5386, zoom = 11) %>%       
        addTiles() 
    }
    if(input$precinct_var == "NORTH"){
      m <- leaflet() %>% 
        setView(lng = -122.3348, lat = 47.7029, zoom = 11) %>%       
        addTiles() 
    }
    if(input$precinct_var == "WEST"){
      m <- leaflet() %>% 
        setView(lng = -122.3366, lat = 47.6162, zoom = 11) %>%       
        addTiles() 
    }
    if(input$precinct_var == "EAST"){
      m <- leaflet() %>% 
        setView(lng = -122.3172, lat = 47.6149, zoom = 11) %>%       
        addTiles() 
    }
    
    m
  })
  
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
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
      labs(
        x = "Crime Disposition", 
        y = paste("Number of Calls Made, Total =", nrow(tab_2_filtered())), 
        fill = "Presiding SPD Precinct"
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
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
      labs(
        x = "Call Received", 
        y = "Portion of Calls Received by Selected Precints", 
        fill = "Involved SPD Precincts"
      )
    
    ggplotly(p)
  })
  
  ## Imani
  ## Crime Filter Data Set 
  datatest <- select(datatest, Offense.Type, Year)
  datatest$Offense.Type <- gsub('-.*',"",datatest$Offense.Type)
  datatest$Offense.Type <- gsub(' .*',"",datatest$Offense.Type)
  
  ## focuses on the most common offenses 
  target <- c("WARRARR", "VEH", "THEFT", "ROBBERY", "NARC", "PROPERTY", "HARASSMENT", "FRAUD", "DISTURBANCE", "BURGLARY", "ASSLT")
  newdata <- datatest%>%
    filter(Offense.Type %in% target)
  
  output$crimetypes <- renderPlot({
    
    ## filters the year
    year.graph <- newdata[newdata$Year == input$select,]
    
    ## prints graph of crimes for that year 
    offeneses_graph <- ggplot(data = year.graph) +
      geom_bar(width = .2, 
               mapping = aes(x = Offense.Type, fill = Offense.Type)) + 
      ggtitle("Offenses in Seattle") + 
      coord_flip() + 
      scale_y_continuous(
        name="Freq", 
        labels = scales::comma) 
    
    print(offeneses_graph)
  })
}
)
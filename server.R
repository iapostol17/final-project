# Assignment Final Project
# INFO 201 B
# This part was written by Sandy Yang

# server.R
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)

# Read in dataset
crime_2008 <- read.csv("data/Seattle_Crime_Stats_by_Police_Precinct_2008-Present.csv")
crime_1990 <- read.csv("data/Seattle_Crime_Stats_by_1990_Census_Tract_1996-2007.csv")
crisis <- read.csv("data/Crisis_Data.csv")
gun_shoot <- read.csv("data/SPD_Officer_Involved_Shooting__OIS__Data.csv")

shinyServer(function(input, output) {
  
}
)



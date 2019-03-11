# Read in dataset
crime_2008 <- read.csv("data/Seattle_Crime_Stats_by_Police_Precinct_2008-Present.csv")
crime_1990 <- read.csv("data/Seattle_Crime_Stats_by_1990_Census_Tract_1996-2007.csv")
crisis <- read.csv("data/Crisis_Data.csv")
gun_shoot <- read.csv("data/SPD_Officer_Involved_Shooting__OIS__Data.csv")


library("lubridate")

# Sandy 
# get the date of crises
crisis <- crisis  %>% 
  mutate(report.date = as.Date(Reported.Date, format = "%Y-%m-%d")) %>% 
  mutate(year = floor_date(report.date, unit = "year")) %>% 
  mutate(month = floor_date(report.date, unit = "month"))  
  
  

  
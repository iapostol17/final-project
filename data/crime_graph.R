#Imani
#Using Seattle Police Department Police Report Incident data to filter by offenses

library(dplyr)
library(ggplot2)
library(data.table)
library('stringr')

install.packages("tidyverse")
crime_data <- read.csv("data/Seattle_Crime_Stats_by_Police_Precinct_2008-Present.csv")
test <- read.csv("data/Seattle_Police_Department_Police_Report_Incident.csv", header = TRUE)


# Filters offenses and removes spacing + "-"
datatest <- select(test, Offense.Type, Year)
datatest$Offense.Type <- gsub('-.*',"",datatest$Offense.Type)
datatest$Offense.Type <- gsub(' .*',"",datatest$Offense.Type)

# focuses on the most common offenses 
target <- c("WARRARR", "VEH", "THEFT", "ROBBERY", "NARC", "PROPERTY", "HARASSMENT", "FRAUD", "DISTURBANCE", "BURGLARY", "ASSLT")
newdata <- datatest%>%
  filter(Offense.Type %in% target)

# example of 2014 crime data 
year.graph <- newdata[newdata$Year == "2008",]

# creates graph for the crimes 
offeneses_graph <- ggplot(data = year.graph) +
  geom_bar(width = .2, mapping = aes(x = Offense.Type, fill = Offense.Type)) + ggtitle("Offenses in Seattle") + coord_flip()+ scale_y_continuous(name="Freq", labels = scales::comma)



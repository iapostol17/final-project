# Read in dataset
crime_2008 <- 
  read.csv("data/Seattle_Crime_Stats_by_Police_Precinct_2008-Present.csv")
crime_1990 <- read.csv
("data/Seattle_Crime_Stats_by_1990_Census_Tract_1996-2007.csv")
crisis <- read.csv("data/Crisis_Data.csv")
gun_shoot <- read.csv("data/SPD_Officer_Involved_Shooting__OIS__Data.csv")


library(lubridate)
library(lintr)
library(dplyr)
library(styler)
library(tidyr)

# Sandy 
# get the date of crises
crisis_times <- crisis  %>% 
  mutate(report.date = as.Date(Reported.Date, format = "%Y-%m-%d")) %>% 
  mutate(year = floor_date(report.date, unit = "year")) %>% 
  mutate(month = as.numeric(substring(Reported.Date, 6, 7))) %>% 
  mutate(hour = as.numeric(substring(Reported.Time, 1, 2)))

crisis_count <- crisis_times %>% 
  group_by(year) %>% 
  count()

# Nemo
# manipulating data from crisis for call types (general and final), precinct, 
# and crime committed.
calls_crimes_and_crisis_precincts <- crisis %>% 
  select(Precinct, Call.Type, Disposition) %>% 
  filter(Disposition != "", Precinct != "", Call.Type != "") %>% 
  filter(!is.na(Disposition), !is.na(Precinct), !is.na(Call.Type))

# choices for precinct checkboxes
precincts <- unique(calls_crimes_and_crisis_precincts$Precinct)
precinct_choices <- list(
  West = precincts[1], 
  North = precincts[2], 
  East = precincts[3], 
  Southwest = precincts[4], 
  South = precincts[5],
  Unknown = precincts[6]
)

# choices for disposition selection box
dispositions <- unique(calls_crimes_and_crisis_precincts$Disposition)
disposition_choices <- list(
  "All" = "*", 
  "Emergent Detention" = dispositions[1], 
  "Chronic Complaint" = dispositions[2], 
  "No Action" = dispositions[3], 
  "Resources Declined" = dispositions[4], 
  "Shelter Transport" = dispositions[5], 
  "Subject Arrested" = dispositions[6], 
  "Voluntary Committal" = dispositions[7], 
  "Crisis Clinic" = dispositions[8], 
  "Mobile Crisis Team" = dispositions[9], 
  "Health/Case Notified" = dispositions[10], 
  "Ger. Reg. Assess. Team" = dispositions[11], 
  "DMHP Referral" = dispositions[12], 
  "Drug/Alcohol Referral" = dispositions[13], 
  "Unable to Contact" = dispositions[14], 
  "N/A" = dispositions[15]
)

# choices for call-type radio buttons
call_types <- unique(calls_crimes_and_crisis_precincts$Call.Type)
call_choices <- list(
  "All" = "*", 
  "911" = call_types[1], 
  "Telephone/Other, Not 911" = call_types[2], 
  "Onview" = call_types[3], 
  "Alarm Call (Not Police Alarm)" = call_types[4], 
  "History Call (Retro)" = call_types[5], 
  "In Person Complaint" = call_types[6], 
  "Proactive (Officer-Initiated)" = call_types[7], 
  "Text Message" = call_types[8], 
  "N/A" = call_types[9]
)

## Rayna Tilley
r_time_data <- crisis %>% 
  select(Occurred.Date...Time, Call.Type, Final.Call.Type, Precinct, Sector) %>% 
  mutate(Crisis_Type = 
            mapply(substr, as.character(Final.Call.Type), 
                   MoreArgs = 
                     list(3, nchar(as.character(Final.Call.Type))))) %>%
  select(-Final.Call.Type) %>%
  mutate(Year = mapply(substr, as.character(Occurred.Date...Time), 
                       MoreArgs = list(7, 11)),
         Month = mapply(substr, as.character(Occurred.Date...Time), 
                        MoreArgs = list(1, 2)),
         Time = mapply(substr, as.character(Occurred.Date...Time), 
                       MoreArgs = list(21, 22))) %>% 
  select(-Occurred.Date...Time) %>%
  select(-Crisis_Type)
r_time_precincts <- as.character(unique(r_time_data$Precinct))
r_time_precincts <- r_time_precincts[-6]
r_west <-
  as.list(as.character(unique(r_time_data[r_time_data$Precinct ==
                                            "WEST", "Sector"])))
r_north <-
  as.list(as.character(unique(r_time_data[r_time_data$Precinct ==
                                            "NORTH", "Sector"])))
r_east <-
  as.list(as.character(unique(r_time_data[r_time_data$Precinct ==
                                            "EAST", "Sector"])))
r_southwest <-
  as.list(as.character(unique(r_time_data[r_time_data$Precinct ==
                                            "SOUTHWEST", "Sector"])))
r_south <-
  as.list(as.character(unique(r_time_data[r_time_data$Precinct ==
                                            "SOUTH", "Sector"])))
r_unknown <-
  as.list(as.character(unique(r_time_data[r_time_data$Precinct ==
                                            "UNKNOWN", "Sector"])))
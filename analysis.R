# Read in dataset
crisis <- read.csv("data/Crisis_Data.csv")

library(lubridate)
library(lintr)
library(dplyr)
library(styler)
library(tidyr)

# Sandy

year_choices <- unique(substring(crisis$Reported.Date,1 , 4))

get_sector <- crisis %>% 
  group_by(Sector) %>% 
  count()

# Beause our dataset do not provide the latitude and longtitude and
# there is no online dataset which provide the geological data for each 
# precinct and sector in Seattle, I have to make the new dataset to 
# recorde the geological location
# The data I use come from google which I google the precinct/sector
# and record the latitude/longtitude Google provided
sector_geo <- list(
  "Sector" = get_sector$Sector,
  "Precinct" = c(
    "UNKNOWN", "NORTH", "EAST", "WEST", "EAST", "SOUTHWEST",
    "EAST", "NORTH", "WEST", "NORTH", "WEST", "NORTH",
    "SOUTH", "WEST",
    "SOUTH", "SOUTH", "NORTH", "SOUTHWEST"
  ),
  "lat" = c(
    47.6062, 47.6608, 47.6343, 47.6307, 47.6130, 47.5446,
    47.6054, 47.6822, 47.5954, 47.7114, 47.6131,
    47.7241, 47.5632, 47.6374, 47.5712, 47.5333,
    47.6806, 47.5580
  ),
  "lng" = c(
    122.3321, -122.356, -122.303, -122.329, -122.319, -122.356,
    -122.293, -122.382, -122.330, -122.295, -122.335,
    -122.339, -122.330, -122.362, -122.297, -122.273,
    -122.309, -122.379
  )
)

sector_geo <- data.frame(sector_geo)


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
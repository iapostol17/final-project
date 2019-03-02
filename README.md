# Final Project
#### Imani Apostol, Rayna Tilley, Sandy Yang, Nikhil Raman


### Project Description
We will be working with the [“Seattle Crime Stats by Police Precinct 2008-Present”](https://data.seattle.gov/Public-Safety/Seattle-Crime-Stats-by-Police-Precinct-2008-Presen/3xqu-vnum) data set. The data was collected by the City of Seattle Department of Information Technology and the Seattle Police Department. We accessed the data from data.seattle.gov. Our target audience will be current Seattle and possibly future residents. The audience will want to learn from the data what the crime rates are in Seattle neighborhoods, including if there has been an increase or decrease in crime over time, what the most common types of crime are, and which areas in Seattle have the highest crime rates. Our project will answer the following questions:
1. What area in Seattle has the highest crime rate?
2. Has there been an increase or decrease in crime over time?
3. What are the most common types of crime?
4. What other factors influence crime occurrences (e.g. Is a specific type of crime more commonly practiced in a specific socioeconomic demographic)?

### Technical Description
We will be reading in our data by using an API provided by the UWPD. In order to access the data, we will go to the data set link and get the access token. After getting the token, then we can retrieve the .json file and turn it into a data frame. The API we selected has a moderately clean dataset. We will only need to filter the data in in order to answer our questions. We may also need to create a new data column (to change it from string to data value). The libraries we will be using will be shiny, ggplot2, and plotly.Creating an interactive website with plotly and shiny may be a big challenge for us. The UWPD database has used the character as string to present the area, which might be challenging for us if we want to show a map using plotly. Also, organizing the data in such a way to display as many possible relationships within shiny’s structures may prove challenging.

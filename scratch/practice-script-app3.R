# load packages
library(tidyverse)
library(leaflet)

# read in data ----
lake_data <- read_csv(here::here("shiny-dashboard", "data", "lake_data_processed.csv"))

# filter data ----
filtered_lakes <- lake_data %>% 
  filter(Elevation >= 8 & Elevation <= 20,
         AvgDepth >= 2 & AvgDepth <= 3,
         AvgTemp >= 4 & AvgTemp <= 6)

# leaflet map ----
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>% 
  setView(lng = -152.048442, lat = 70.249234, zoom = 6) %>% 
  addMiniMap(toggleDisplay = TRUE, 
             minimized = FALSE) %>% 
  addMarkers(data = filtered_lakes,
             lng = filtered_lakes$Longitude, 
             lat = filtered_lakes$Latitude,
             popup = paste0("Site name: ", filtered_lakes$Site, "<br>", 
                            "Elevation: ", filtered_lakes$Elevation, "m above sea-level", "<br>",
                            "Average Depth: ", filtered_lakes$AvgDepth, "m", "<br>",
                            "Average Lake Bed Temperature: ", filtered_lakes$AvgTemp, "°C"))

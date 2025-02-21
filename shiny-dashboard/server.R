server <- function(input, output){
  
  # filter lake data ----
  filtered_lakes_df <- reactive(
    
    lake_data %>% 
    filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2],
           AvgDepth >= input$depth_slider_input[1] & AvgDepth <= input$depth_slider_input[2],
           AvgTemp >= input$temp_slider_input[1] & AvgTemp <= input$temp_slider_input[2])
    )
  
  
  # build leaflet map ----
  output$lake_map_output <- renderLeaflet({
    
    leaflet() %>% 
      addProviderTiles(providers$Esri.WorldImagery) %>% 
      setView(lng = -152.048442, lat = 70.249234, zoom = 6) %>% 
      addMiniMap(toggleDisplay = TRUE, 
                 minimized = FALSE) %>% 
      addMarkers(data = filtered_lakes_df(),
                 lng = filtered_lakes_df()$Longitude, 
                 lat = filtered_lakes_df()$Latitude,
                 popup = paste0("Site name: ", filtered_lakes_df()$Site, "<br>", 
                                "Elevation: ", filtered_lakes_df()$Elevation, "m above sea-level", "<br>",
                                "Average Depth: ", filtered_lakes_df()$AvgDepth, "m", "<br>",
                                "Average Lake Bed Temperature: ", filtered_lakes_df()$AvgTemp, "°C"))
    
  }) # END leaflet map
  
}
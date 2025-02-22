# dashboard header ----
header <- dashboardHeader(
  
  # title ----
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
  
) # END dashboardHeader

# dashboard sidebar ----
sidebar <- dashboardSidebar(
  
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", 
             icon = icon("star")), # tab name is an identifier 
    menuItem(text = "Dashboard", tabName = "dashboard", 
             icon = icon("gauge"))
    
  ) # END sidebarMenu
  
) # END dashboardSidebar

# dashboard body ----
body <- dashboardBody(
  
  # set theme ----
  use_theme("dashboard-fresh-theme.css"),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "welcome",
            
            # left-hand column ----
            column(width = 6,
                   
                   # background intro info box ----
                   box(width = NULL, # inherits width of column
                       
                       title = tagList(icon("water"),
                                       strong("Monitoring Fish Creek Watershed")),
                       includeMarkdown("text/intro.md"),
                       tags$img(src = 'map.jpg',
                                alt = "Map of Northern Alaska, showing Fish Creek Watershed located within the national petroleum reserve.",
                                style = "max-width: 100%;"),
                       tags$h6("Map Source:", 
                               tags$a(href='http://www.fishcreekwatershed.org', "FCWO"),
                               style = 'text-align: center;')
                       
                   ) # END bg info box
                   
            ), # END LH column
            
            # right-hand column ----
            column(width = 6,
                   
                   # first fluidRow
                   fluidRow(
                     
                     # citation box ----
                     box(width=NULL,
                         title = tagList(icon("table"),
                                         strong("Data Source")),
                         
                         includeMarkdown("text/citation.md")
                         
                     ) # END citation box
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width=NULL,
                         title = tagList(icon("triangle-exclamation"),
                                         strong("Disclaimer")),
                         
                         includeMarkdown("text/disclaimer.md")
                         
                     ) # END disclaimer box
                     
                   ) # END second fluidRow
                   
            ) # END RH column
            
    ), # END welcome tabItem
    
    # dashboard tabItem ----
    tabItem(tabName = "dashboard",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4, 
                  
                  title = tags$strong("Adjust lake parameter ranges:"),
                  
                  # first sliderInput ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above sea-level)",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation), 
                                        max(lake_data$Elevation))),
                  
                  # second sliderInput ----
                  sliderInput(inputId = "depth_slider_input",
                              label = "Depth (meters)",
                              min = min(lake_data$AvgDepth),
                              max = max(lake_data$AvgDepth),
                              value = c(min(lake_data$AvgDepth), 
                                        max(lake_data$AvgDepth))),
                  
                  # third sliderInput ----
                  sliderInput(inputId = "temp_slider_input",
                              label = "Temperature (°C)",
                              min = min(lake_data$AvgTemp),
                              max = max(lake_data$AvgTemp),
                              value = c(min(lake_data$AvgTemp), 
                                        max(lake_data$AvgTemp)))
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8,
                  
                  title = tags$strong("Monitored lakes within Fish Creek Watershed"),
                  
                  # leaflet output ----
                  leafletOutput(outputId = "lake_map_output")  
                  # %>%  withSpinner(type = 6, color = "cornflowerblue")
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ) # END dashboard tabItem
    
  ) #END tabItems
  
) # END dashboardBody

# combine all into dashboardPage ----
dashboardPage(header, sidebar, body)
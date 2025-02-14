# Load packages ----
library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)

# UI ----
ui <- fluidPage(

  # app title ----
  tags$h1("My App Title"), 
  
  # app subtitle ----
  tags$h4(tags$strong("Exploring Antarctic Penguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g)",
              min = 2700, max = 6300, 
              value = c(4000, 5000)),

  # body mass plot output ----
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  # year input ----
  checkboxGroupInput(inputId = "year_checkbox_input",
                     label = "Select year(s):",
                     choices = unique(penguins$year), # c(2007, 2008, 2009)
                     selected = 2007),
  # year output 
  DT::dataTableOutput(outputId = "penguin_dt_output")
)
# server ----
server <- function(input, output){
  
  # filter
  body_mass_df <- reactive ({
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
  }) 
  
  # render penguin scatterplot ----
  output$body_mass_scatterplot_output <- renderPlot({
    
    ggplot(na.omit(body_mass_df()), # need to make a reactive df a 'function'
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", 
                                    "Chinstrap" = "purple", 
                                    "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, 
                                    "Chinstrap" = 17, 
                                    "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "white"))
    
  })
  
  # filter
  year_df <- reactive ({
    penguins %>% 
      filter(year %in% c(input$year_checkbox_input))
  }) 
  
  # Create DT penguins
  output$penguin_dt_output <- renderDataTable({
    DT::datatable(year_df())
  }) 
  
  
}

# Combine ui and server into an app ----
shinyApp(ui = ui, server = server)
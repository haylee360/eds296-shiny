# load packages ----
library(tidyverse)
library(palmerpenguins)
library(DT)



# create scatterplot ----
ggplot(na.omit(penguins), 
       aes(x = flipper_length_mm, y = bill_length_mm, 
           color = species, shape = species)) +
  geom_point() +
  scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
  scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
  labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
       color = "Penguin species", shape = "Penguin species") +
  guides(color = guide_legend(position = "inside"),
         size = guide_legend(position = "inside")) +
  theme_minimal() +
  theme(legend.position.inside = c(0.85, 0.2), 
        legend.background = element_rect(color = "white"))

small_year <-  penguins %>% 
    filter(year %in% c(2007, 2008))

# Create DT penguins
DT::datatable(small_year)

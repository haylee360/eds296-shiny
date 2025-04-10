# Load libraries
library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(shinycssloaders)
library(markdown)
library(fresh)

# read in data ----
lake_data <- read_csv('data/lake_data_processed.csv')

library(shiny)
library(readr)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(plotly)
library(shinyWidgets)

dataset <- starwars

fr_esr_parcoursup <- read_delim("C:/UTT/IF36/projet-if36-p23-invisible-touch/data/fr-esr-parcoursup.csv",
                                delim = ";", escape_double = FALSE, na = "NA",
                                trim_ws = TRUE, show_col_types = FALSE)

shinyServer(function(input, output) {
  data_graph <- reactive({
    data_graph <- subset(fr_esr_parcoursup, select = c("dep_lib","fili", "g_olocalisation_des_formations"))
    
    data_graph <- data_graph %>% separate(g_olocalisation_des_formations, c("lat","long"), sep=",") %>% transform(long = as.numeric(long), lat = as.numeric(lat)) %>%  filter(lat > 41.6, lat < 51.5, fili %in% input$fili)
    
    data_graph <- data_graph %>% group_by(lat,long,fili) %>% mutate(quantite=n())
    data_graph
  })
 

  world <- ne_countries(scale = "medium", returnclass = "sf")

  output$plot1 <- renderPlot({
    ggplot(data = world) +
      geom_sf() +
      geom_point(data = data_graph(), aes(x = long, y = lat, color=fili, size=quantite)) +
      coord_sf(xlim = c(-5, 9.5), ylim = c(41, 52), expand = FALSE, datum = NA) +
      labs(color="Formations", size="Quantités") +
      theme(legend.position = "bottom", legend.box = "vertical",
            axis.title = element_blank())
  })
  
  
  
})
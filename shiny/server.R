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

fr_esr_parcoursup <- read_delim("../data/fr-esr-parcoursup.csv",
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
  
  #Graphe 2: taux d'acceptation par académie

  
  tauxParAcademie <- fr_esr_parcoursup %>%
    group_by(acad_mies) %>%
    summarize(tauxParAcademie = mean(prop_tot/voe_tot))
  
  data_tauxParAcademie <- reactive({
  data_tauxParAcademie <- tauxParAcademie %>%
    filter(tauxParAcademie > as.numeric(gsub("%", "", input$seuilTauxParAcademie))/100)})
  
  
  output$plot2 <- renderPlot({
    ggplot(data_tauxParAcademie(), aes(x = acad_mies, y = tauxParAcademie)) +
      geom_bar(stat = "identity", fill="#234E70") +
      geom_text(aes(label = paste0(round(tauxParAcademie*100,1),"%")), angle = 90, vjust = 0.5, size = 4, nudge_y = 0.03) +
      scale_y_continuous(labels = scales::percent_format()) +
      xlab("Académie") +
      ylab("Taux d'acceptation") +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  })
  
  
  
})
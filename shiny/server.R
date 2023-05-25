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

fr_esr_parcoursup_2021 <- read_delim("../data/fr-esr-parcoursup_2021.csv",
                                     delim = ";", escape_double = FALSE, na = "NA",
                                     trim_ws = TRUE)

fr_esr_parcoursup_2020 <- read_delim("../data/fr-esr-parcoursup_2020.csv", 
                                     delim = ";", escape_double = FALSE, na = "NA",
                                     trim_ws = TRUE)



shinyServer(function(input, output) {
  
  # Graphe 1 : Carte Formation
  
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
  
  # Graphe 2 : taux d'acceptation par académie

  tauxParAcademie <- fr_esr_parcoursup %>%
    group_by(acad_mies) %>%
    summarize(tauxParAcademie = mean(prop_tot/voe_tot))
  
  data_tauxParAcademie <- reactive({
    data_tauxParAcademie <- tauxParAcademie %>%
    filter(tauxParAcademie < as.numeric(gsub("%", "", input$seuilTauxParAcademie))/100)
  })
  
  output$plot2 <- renderPlot({
    ggplot(data_tauxParAcademie(), aes(x = acad_mies, y = tauxParAcademie)) +
      geom_bar(stat = "identity", fill="#234E70") +
      geom_text(aes(label = paste0(round(tauxParAcademie*100,1),"%")), angle = 90, vjust = 0.5, size = 4, nudge_y = 0.03) +
      scale_y_continuous(labels = scales::percent_format()) +
      xlab("Académie") +
      ylab("Taux d'acceptation") +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  })
  
  # Onglet 3 : Comparaison entre les UTs
  
  ## Filtrer le dataset pour avoir seulement les UT (UTT, UTC, UTBM)
  UT <- filter(fr_esr_parcoursup,  lib_for_voe_ins == "Formation d'ingénieur Bac + 5 - Série générale", str_detect(g_ea_lib_vx,"Université de Technologie"))
  UT <- UT[-4,]
  
  UT21 <- filter(fr_esr_parcoursup_2021,  lib_for_voe_ins == "Formation d'ingénieur Bac + 5 - Série générale", str_detect(g_ea_lib_vx,"Université de Technologie"))
  UT21 <- UT21[-3,]
  
  UT20 <- filter(fr_esr_parcoursup_2020,  regr_forma == "Réseau des Universités de Technologie", str_detect(g_ea_lib_vx,"Université de Technologie"), detail_forma == "Bac S")
  UT20 <- UT20[-3,]
  
  data <- reactive({
    if (input$annee == 2022) {
      UT
    } else if (input$annee == 2021) {
      UT21
    } else {
      UT20
    } 
  })
  
  annee <- reactive({
    input$annee
  })
  
  output$plot3 <- renderPlotly({
    dataUT <- data() %>%
      select(g_ea_lib_vx,voe_tot, capa_fin) %>%
      rename(c(Ville = g_ea_lib_vx, Voeux_totaux = voe_tot, Capacité_maximal = capa_fin))%>%
      arrange(Ville)
    
    
    dataUT$Ville <- c("Belfort", "Compiègne", "Troyes")
    dataUT<- gather(dataUT, legend, value, -Ville)
    
    #Graphique qui compare le nombre de candidature et le nombre de place pour chaque UT
    plot <- ggplot(dataUT, aes(x = Ville, y = value, fill = legend)) +
            geom_col(position = "dodge") + 
            labs(x = "\n Ville", y = "Nombre") +
            scale_fill_discrete(name = "Légende", labels = c("Capacité", "Candidature"))
    ggplotly(plot)
  })
  
  output$plot4 <- renderPlotly({
    dataUT2 <- data() %>%
      select(g_ea_lib_vx,prop_tot, acc_tot, acc_tot_f) %>%
      mutate(acc_tot = acc_tot - acc_tot_f) %>%
      rename(c(Ville = g_ea_lib_vx, proposition_total = prop_tot, masculin = acc_tot, féminin = acc_tot_f))%>%
      arrange(Ville)
    
    dataUT2$Ville <- c("Belfort", "Compiègne", "Troyes")
    dataUT2 <- gather(dataUT2, legend, value, -Ville)
    
    plot <- ggplot(dataUT2, aes(x = Ville, y = value, fill = legend)) +
              geom_col(position = "dodge") + 
              scale_fill_manual(name = "Candidats",
                                values = c("proposition_total" = "#66c2a5",
                                           "masculin" = "#8da0cb",
                                           "féminin" = "#e78ac3"),
                                labels = c("Masculin ayant accepté",
                                           "Féminin ayant accepté",
                                           "Ayant reçu une proposition")) +  
              labs(x = "\n Ville", y = "Nombre\n")
    
    ggplotly(plot)
  })
  
  output$plot5 <- renderPlotly({
    
    if(annee() == 2020){
      dataUT3 <- data() %>%
        select(g_ea_lib_vx, pct_sansmention ,pct_ab, pct_b, pct_tb) %>%
        arrange(g_ea_lib_vx) %>%
        rename(c(Ville = g_ea_lib_vx, Sans_Mention = pct_sansmention, Assez_Bien = pct_ab, Bien = pct_b, Très_Bien = pct_tb)) 
    } else {
      dataUT3 <- data() %>%
        select(g_ea_lib_vx, pct_sansmention ,pct_ab, pct_b, pct_tb, pct_tbf) %>%
        arrange(g_ea_lib_vx) %>%
        rename(c(Ville = g_ea_lib_vx, Sans_Mention = pct_sansmention, Assez_Bien = pct_ab, Bien = pct_b, Très_Bien = pct_tb, Fécilitations = pct_tbf)) 
    }
    
    dataUT3$Ville <- c("Belfort", "Compiègne", "Troyes")
    dataUT3 <- gather(dataUT3, Mention, Nombre, -Ville)
    
    dataUT3$Mention <- factor(dataUT3$Mention, levels = c("Fécilitations", "Très_Bien", "Bien", "Assez_Bien", "Sans_Mention"))
    
    plot <- ggplot(dataUT3, aes(x = Ville, y = Nombre, fill = Mention)) +
              geom_col(colour = "black", position = "fill") +
              scale_y_continuous(labels = scales::percent) +
              scale_fill_brewer(palette = "PuBu")
    ggplotly(plot)
  })
  
})
library(shinydashboard)
library(shinyWidgets)
library(plotly)

dashboardPage(
  skin = "blue",
  dashboardHeader(title="Parcoursup"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Formations", tabName = "stats", icon = icon("table")),
      menuItem("Taux d'Acceptation", tabName = "academie", icon = icon("percent"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "stats",
        h2("Répartition des formations en France métropolitaine"),
        pickerInput(
          inputId = "fili",
          label = "Formations:", 
          choices = list("BTS", "Autre formation", "CPGE", "Licence", "BUT", "Ecole de Commerce", "Ecole d'Ingénieur", "IFSI", "EFTS", "Licence_Las", "PASS"),
          multiple = TRUE,
          selected = list("BTS", "Autre formation", "CPGE", "Licence", "BUT", "Ecole de Commerce", "Ecole d'Ingénieur", "IFSI", "EFTS", "Licence_Las", "PASS")
        ),
        plotOutput("plot1", width = "90vw", height = "90vh")
      ),
      tabItem(tabName= "academie",
              h2("Taux d'acceptation par académie en phase principale"),
              sliderTextInput(
                inputId = "seuilTauxParAcademie",
                label = "Choisissez le seuil minimal du taux d'acceptation:", 
                choices = c("50%", "45%", "40%", "35%", "30%", "25%", "20%"),
                grid = TRUE
              ),
              plotOutput("plot2", width = "90vw", height = "90vh")
              
              )
    )
  )
)
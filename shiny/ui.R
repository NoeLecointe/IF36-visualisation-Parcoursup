library(shinydashboard)
library(shinyWidgets)
library(plotly)

dashboardPage(
  skin = "blue",
  dashboardHeader(title="Parcoursup"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Formations", tabName = "stats", icon = icon("table"))
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
        
      )
    )
  )
)
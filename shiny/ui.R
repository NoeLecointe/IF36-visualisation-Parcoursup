library(shinydashboard)
library(shinyWidgets)
library(plotly)

dashboardPage(
  skin = "blue",
  dashboardHeader(title="Parcoursup"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Formations", tabName = "stats", icon = icon("table")),
      menuItem("Taux d'Acceptation", tabName = "academie", icon = icon("percent")),
      menuItem("Les UT", tabName = "UT", icon = icon("school"))
    ),
    selectInput("annee", "Année : ", c("2022", "2021", "2020"))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "stats",
        h2("Répartition des formations en France métropolitaine"),
        uiOutput("list_forma"),
        plotOutput("plot1", width = "90vw", height = "90vh")
      ),
      
      tabItem(tabName= "academie",
        h2("Taux d'acceptation par académie en phase principale"),
        uiOutput("val_pour"),
        plotOutput("plot2", width = "90vw", height = "90vh")
      ),
       
      tabItem(tabName= "UT",
        h2("Comparaison entre les UTs\n"),
        
        fluidRow(
          box(
            title = "Nombre de places / nombre de candidatures aux UT", 
            status = "warning",
            plotlyOutput("plot3")
          ),
          box(
            title = "Proposition d'admission", 
            status = "warning",
            plotlyOutput("plot4")
          ),
          box(
            title = "Mention au bac des admis", 
            status = "warning",
            plotlyOutput("plot5")
          )
        ) 
      )
    )
  )
)
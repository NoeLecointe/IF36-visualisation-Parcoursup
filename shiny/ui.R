library(shinydashboard)
library(shinyWidgets)
library(plotly)

dashboardPage(
  skin = "blue",
  dashboardHeader(title="Parcoursup"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Informations", icon = icon("circle-info"),
        menuSubItem("Générales", tabName= "gene"),
        menuSubItem("Académies", tabName= "acad")
      ),
      menuItem("Formations", tabName = "stats", icon = icon("table")),
      menuItem("Taux d'Acceptation", tabName = "academie", icon = icon("percent")),
      menuItem("Les UT", tabName = "UT", icon = icon("school"))
    ),
    selectInput("annee", "Année : ", c("2022", "2021", "2020"))
  ),
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "gene",
        infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
        infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
        infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
      ),
      tabItem(tabName = "acad",
        h2("Informations"),
        
        fluidRow(
          box(
            uiOutput("academie")
          ),
          box(
            uiOutput("etab")
          )
        ),
        box(
          title = "Académie", solidHeader = TRUE, status = "info",
          width = 12, collapsible = TRUE, collapsed = TRUE,
          h3(textOutput("acade"), style = "text-align:center;"),
          valueBoxOutput("candidat_tot"),
          valueBoxOutput("candidat_tot_f"),
          valueBoxOutput("candidat_tot_m"),
          valueBoxOutput("place_tot")
        ),
        box(
          title = "Formation", solidHeader = TRUE, status = "warning",
          width = 12, collapsible = TRUE, collapsed = TRUE,
          h3(textOutput("etabli"), style = "text-align:center;"),
          box(title = "Formation dans l'établissement", status = "info", solidHeader = TRUE, p(textOutput("type_forma")))
        )
        
      ),
      
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

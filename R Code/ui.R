
library(rsconnect)
library(shiny)
library(ggplot2)

basicPage(
  titlePanel("Warzone Statistics"),
 # selectInput("select", "Select columns to display", colnames(tableOutput("table2")), multiple = TRUE),
  
  
  (mainPanel(
    verbatimTextOutput("summary"),
    tableOutput("table1"),
    selectInput("variable", "Click to select columns for table below:",
                c(
                  "Kills" = "Kills", 
                  "Kills Per Game" = "Kills Per Game", 
                  "Headshots" = "Headshots", 
                  "Team Wipes" = "Team Wipes", 
                  "Deaths" = "Deaths", 
                  "Damage Done" = "Damage Done", 
                  "Damage Taken" = "Damage Taken", 
                  "Avg. Life Time" = "Avg. Life Time", 
                  "Score" = "Score", 
                  "Score Per Minute" = "Score Per Minute", 
                  "Distance Traveled" = "Distance Traveled", 
                  "Gulag Deaths" = "Gulag Deaths",
                  "Gulag Kills" = "Gulag Kills", 
                  "Executions" = "Executions",
                  "Sent The Vids?" = "Sent the Vids?"), multiple = TRUE),
    tableOutput("table2")
  )
))



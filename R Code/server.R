# necessary packages

library(shiny)
library(ggplot2)
library(jsonlite)
library(gridExtra)
library(grid)
library(tidyr)
library(dplyr)
library(xtable)
library(DT)

options(shiny.maxRequestSize=30*1024^2)

# read in JSON data
m <- fromJSON(readLines('./mark1.json'), flatten = TRUE)
b <- fromJSON(readLines('./brian1.json'), flatten = TRUE)
e <- fromJSON(readLines('./evan1.json'), flatten = TRUE)
j <- fromJSON(readLines('./jordan1.json'), flatten = TRUE)
k <- fromJSON(readLines('./kevin1.json'), flatten = TRUE)
r <- fromJSON(readLines('./ryan1.json'), flatten = TRUE)
w <- fromJSON(readLines('./will1.json'), flatten = TRUE)
m2 <- fromJSON(readLines('./miles1.json'), flatten = TRUE)

# combine data files
dataset <- do.call(rbind, Map(data.frame, Mark = m, Brian = b, Evan = e, Jordan = j,
                              Kevin = k, Ryan = r, Willy = w, Miles = m2))

dat <- dataset[1, , ]
dt <- gather(dat)

# data started as wins.. kept the object name 'wins' even though it becomes all variables
wins <-dt[c(1, 18, 35, 52, 69, 86, 103, 120), ]
names(wins) <- c('Name', 'Wins')

# KD Ratio
wins$'K/D Ratio' <- dt[c(3, 20, 37, 54, 71, 88, 105, 122), 2]
wins$'K/D Ratio' <- as.numeric(wins$'K/D Ratio')
wins$'K/D Ratio' <- formatC(wins$'K/D Ratio', digits = 3, format = "f")

row.names(wins) <- c("Mark", "Brian", "Evan", "Jordan",
                              "Kevin", "Ryan", "Willy", "Miles")
# Downs
wins$'Downs' <- dt[c(4, 21, 38, 55, 72, 89, 106, 123), 2]
wins$Name <- row.names(wins)

# Top 25, 10, and 5.. also GP
wins$'Games Played' <- dt[c(12, 29, 46, 63, 80, 97, 114, 131), 2]
wins$'Top 25' <- dt[c(5, 22, 39, 56, 73, 90, 107, 124), 2]
wins$'Top 10' <- dt[c(6, 23, 40, 57, 74, 91, 108, 125), 2]
wins$'Top 5' <- dt[c(9, 26, 43, 60, 77, 94, 111, 128), 2]

# Revives, kills, score per minute
wins$Revives <- dt[c(8, 25, 42, 59, 76, 93, 110, 127), 2]
wins$Kills <- dt[c(2, 19, 36, 53, 70, 87, 104, 121), 2]
wins$'Score Per Minute' <- dt[c(14, 31, 48, 65, 82, 99, 116, 133), 2]
wins$'Score Per Minute' <- as.numeric(wins$'Score Per Minute')
wins$'Score Per Minute' <- formatC(wins$'Score Per Minute', digits = 1, format = "f")

######## Recent Ganes (20)

m3 <- fromJSON(readLines('./mark2.json'), flatten = TRUE)
b2 <- fromJSON(readLines('./brian2.json'), flatten = TRUE)
e2 <- fromJSON(readLines('./evan2.json'), flatten = TRUE)
j2 <- fromJSON(readLines('./jordan2.json'), flatten = TRUE)
k2 <- fromJSON(readLines('./kevin2.json'), flatten = TRUE)
r2 <- fromJSON(readLines('./ryan2.json'), flatten = TRUE)
w2 <- fromJSON(readLines('./will2.json'), flatten = TRUE)
m4 <- fromJSON(readLines('./miles2.json'), flatten = TRUE)

options(scipen = 999)
dataset2 <- do.call(rbind, Map(data.frame, Mark = m3$summary$all, Brian = b2$summary$all, 
                               Evan = e2$summary$all, 
                               Jordan = j2$summary$all,
                              Kevin = k2$summary$all, Ryan = r2$summary$all, 
                              Willy = w2$summary$all, 
                              Miles = m4$summary$all))

# ineffeciently combine data (lines 80-125)
kills <- round(c(m3$summary$all$kills, b2$summary$all$kills, e2$summary$all$kills, j2$summary$all$kills, 
          k2$summary$all$kills, r2$summary$all$kills, w2$summary$all$kills, m4$summary$all$kills), 2)

objectiveTeamWiped <- round(c(m3$summary$all$objectiveTeamWiped, b2$summary$all$objectiveTeamWiped, e2$summary$all$objectiveTeamWiped, j2$summary$all$objectiveTeamWiped, 
           k2$summary$all$objectiveTeamWiped, r2$summary$all$objectiveTeamWiped, w2$summary$all$objectiveTeamWiped, m4$summary$all$objectiveTeamWiped), 2)

avgLifeTime <- round(c(m3$summary$all$avgLifeTime, b2$summary$all$avgLifeTime, e2$summary$all$avgLifeTime, j2$summary$all$avgLifeTime, 
                 k2$summary$all$avgLifeTime, r2$summary$all$avgLifeTime, w2$summary$all$avgLifeTime, m4$summary$all$avgLifeTime), 2)

score <- round(c(m3$summary$all$score, b2$summary$all$score, e2$summary$all$score, j2$summary$all$score, 
           k2$summary$all$score, r2$summary$all$score, w2$summary$all$score, m4$summary$all$score), 2)

scorePerMinute<- round(c(m3$summary$all$scorePerMinute, b2$summary$all$scorePerMinute, e2$summary$all$scorePerMinute, j2$summary$all$scorePerMinute, 
                   k2$summary$all$scorePerMinute, r2$summary$all$scorePerMinute, w2$summary$all$scorePerMinute, m4$summary$all$scorePerMinute), 2)

headshots<- round(c(m3$summary$all$headshots, b2$summary$all$headshots, e2$summary$all$headshots, j2$summary$all$headshots, 
              k2$summary$all$headshots, r2$summary$all$headshots, w2$summary$all$headshots, m4$summary$all$headshots), 2)

killsPerGame<- round(c(m3$summary$all$killsPerGame, b2$summary$all$killsPerGame, e2$summary$all$killsPerGame, j2$summary$all$killsPerGame, 
                 k2$summary$all$killsPerGame, r2$summary$all$killsPerGame, w2$summary$all$killsPerGame, m4$summary$all$killsPerGame), 2)

distanceTraveled<- round(c(m3$summary$all$distanceTraveled, b2$summary$all$distanceTraveled, e2$summary$all$distanceTraveled, j2$summary$all$distanceTraveled, 
                     k2$summary$all$distanceTraveled, r2$summary$all$distanceTraveled, w2$summary$all$distanceTraveled, m4$summary$all$distanceTraveled), 2)

deaths<- round(c(m3$summary$all$deaths, b2$summary$all$deaths, e2$summary$all$deaths, j2$summary$all$deaths, 
           k2$summary$all$deaths, r2$summary$all$deaths, w2$summary$all$deaths, m4$summary$all$deaths), 2)

kdRatio<- round(c(m3$summary$all$kdRatio, b2$summary$all$kdRatio, e2$summary$all$kdRatio, j2$summary$all$kdRatio, 
            k2$summary$all$kdRatio, r2$summary$all$kdRatio, w2$summary$all$kdRatio, m4$summary$all$kdRatio), 2)

gulagDeaths<- round(c(m3$summary$all$gulagDeaths, b2$summary$all$gulagDeaths, e2$summary$all$gulagDeaths, j2$summary$all$gulagDeaths, 
                k2$summary$all$gulagDeaths, r2$summary$all$gulagDeaths, w2$summary$all$gulagDeaths, m4$summary$all$gulagDeaths), 2)

gulagKills<- round(c(m3$summary$all$gulagKills, b2$summary$all$gulagKills, e2$summary$all$gulagKills, j2$summary$all$gulagKills, 
               k2$summary$all$gulagKills, r2$summary$all$gulagKills, w2$summary$all$gulagKills, m4$summary$all$gulagKills), 2)

executions<- round(c(m3$summary$all$executions, b2$summary$all$executions, e2$summary$all$executions, j2$summary$all$executions, 
               k2$summary$all$executions, r2$summary$all$executions, w2$summary$all$executions, m4$summary$all$executions), 2)

damageDone<- round(c(m3$summary$all$damageDone, b2$summary$all$damageDone, e2$summary$all$damageDone, j2$summary$all$damageDone, 
               k2$summary$all$damageDone, r2$summary$all$damageDone, w2$summary$all$damageDone, m4$summary$all$damageDone), 2)

damageTaken<- round(c(m3$summary$all$damageTaken, b2$summary$all$damageTaken, e2$summary$all$damageTaken, j2$summary$all$damageTaken, 
                k2$summary$all$damageTaken, r2$summary$all$damageTaken, w2$summary$all$damageTaken, m4$summary$all$damageTaken), 2)

recentdat <-data.frame(rbind(kills, objectiveTeamWiped, avgLifeTime, score, scorePerMinute, headshots, killsPerGame, distanceTraveled,
       deaths, kdRatio, gulagDeaths, gulagKills, executions, damageDone, damageTaken))

names(recentdat) <- c("Mark", "Brian", "Evan", "Jordan", "Kevin", "Ryan", "Willy", "Miles")
recentdat <- t(recentdat)

# add in joke data 
vids<-t(data.frame(fromJSON(readLines('./sentthevids.json'))))
recentdat <- data.frame(cbind(recentdat,vids))

recentdat2 <- recentdat[, c(10, 1, 7, 6, 2, 9, 14, 15, 3, 4, 5, 8, 11, 12, 13, 16)]
colnames(recentdat2) <- c("K/D Ratio", "Kills", "Kills Per Game", "Headshots", "Team Wipes", "Deaths", "Damage Done", 
                      "Damage Taken", "Avg. Life Time", "Score", "Score Per Minute", "Distance Traveled", "Gulag Deaths",
                      "Gulag Kills", "Executions", "Sent the Vids?")

# everything below this is specific to R Shiny, to build the web app 
shinyServer(function(input, output) {
   
   output$table1 <- renderTable(wins,  caption = "Warzone Stats- Total", caption.placement = getOption("xtable.caption.placement", "top"))


    output$table2 <- renderTable( 
             recentdat2[, c("K/D Ratio", input$variable), drop = FALSE],
                                 rownames = TRUE, caption = "Warzone Stats- Last 20 Games",
        caption.placement = getOption("xtable.caption.placement", "top"))})
    

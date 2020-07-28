# COD Warzone data for '@brian send the vids' pro gamers

## Project Overview
To get COD Warzone data, gamertags of friends are entered into GETrequests via the application Postman. 
The JSON files are then read into R, pre-processed in R, then sent to R Shiny to create a web application. 

## Postman Details
GET requests are currently made for each seperate gamertag (16 total, 2 different API endpoints). Need to create a Postman Collection, 
so that all requests can be run at the same time. This will also be useful for automatic refresh (Monitor utility in Postman). 

## R and R Shiny Details
Because the resulting JSON files have more data than what is ultimately shown, much of the R code used is to whittle down the columns we need, and to 
put the data in a format that R Shiny wants. Server.R and ui.R are the two R SHiny files needed, although other projects combine these into one. R Studio is the 
editor used when creating R code, and is great for testing the web app before publishing. 

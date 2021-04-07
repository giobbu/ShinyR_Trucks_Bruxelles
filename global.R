library(dplyr)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(leaflet)
library(htmlwidgets)
library(htmltools)
library(ggmap)
library(DT)
library(stats)
library(tibble)
library(ggplot2)
library("plotly")
library("reshape2")

library("geojsonio")
library(sp)

library(leaflet.minicharts)
library("Cairo")
library(ggthemes)


file="/Users/mobiaid/Desktop/MOBIAid_APP/mycsv.csv"
tbl <-  read.csv(file)
tbl$X<-NULL
tbl<-as_data_frame(tbl)
data2 <- split(tbl, tbl$date)


file1="/Users/mobiaid/Desktop/MOBIAid_APP/mycsv1.csv"
tbl1 <-  read.csv(file1)
tbl1$X<-NULL
tbl1<-as_data_frame(tbl1)
atad2 <- split(tbl1, tbl1$date)


out<-geojson_read("bruxelles.json")
and<-geojson_read("Andercopy.json") #1
aud<-geojson_read("Audercopy.json") #2
agat<-geojson_read("Agatcopy.json") #3
vil<-geojson_read("Villecopy.json") #4
etter<-geojson_read("Ettercopy.json") #5
ever<-geojson_read("Evercopy.json") #6
stgil<-geojson_read("stgilcopy.json") #7
fore<-geojson_read("Forestcopy.json") #8
gans<-geojson_read("Ganscopy.json") #9
ixel<-geojson_read("Ixelcopy.json") #10
jette<-geojson_read("Jettecopy.json") #11
koek<-geojson_read("Koekcopy.json") #12
molen<-geojson_read("Molencopy.json") #13
nood<-geojson_read("Noodcopy.json") #14
schae<-geojson_read("Schaercopy.json") #15
uccl<-geojson_read("Ucclcopy.json") #16
boit<-geojson_read("Boitscopy.json") #17
lamb<-geojson_read("Lambcopy.json") #18
pier<-geojson_read("Pierrecopy.json") #19

bxl<-geojson_read("bruxy.json",what = "sp")
And<-geojson_read("Anderlecht.json",what = "sp") #1
Aud<-geojson_read("Auderghem.json",what = "sp") #2
Agat<-geojson_read("Berchem-Sainte-Agathe.json",what = "sp") #3
Vil<-geojson_read("Bruxelles-ville.json",what = "sp") #4
Etter<-geojson_read("Etterbeek.json",what = "sp") #5
Ever<-geojson_read("Evere.json",what = "sp") #6
Stgil<-geojson_read("stgilles.json",what = "sp") #7
Fore<-geojson_read("Forest.json",what = "sp") #8
Gans<-geojson_read("Ganshoren.json",what = "sp") #9
Ixel<-geojson_read("Ixelles.json",what = "sp") #10
Jette<-geojson_read("Jette.json",what = "sp") #11
Koek<-geojson_read("Koekelberg.json",what = "sp") #12
Molen<-geojson_read("Molenbeek-Saint-Jean.json",what = "sp") #13
Nood<-geojson_read("Noode.json",what = "sp") #14
Schae<-geojson_read("Schaerbeek.json",what = "sp") #15
Uccl<-geojson_read("Uccle.json",what = "sp") #16
Boit<-geojson_read("Watermael-Boitsfort.json",what = "sp") #17
Lamb<-geojson_read("Woluwe-Saint-Lambert.json",what = "sp") #18
Pier<-geojson_read("Woluwe-Saint-Pierre.json",what = "sp") #19
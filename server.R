

server <- shinyServer( function(input, output, session) {





observe({
  
  
  unit <- as.integer(difftime(as.Date(input$date0),"2017-10-11")) #as.Date()
  
  data3 <- atad2[[unit]]
  
  
  coord1<-data3
  
  coordinates(coord1) <- ~first.longit. + first.lat.
  
  #######################################################################################         
  
  proj4string(coord1) <- proj4string(bxl) 
  
  camion<-over(coord1, as(bxl,"SpatialPolygons"))
  
  camion[is.na(camion)]<-0
  
  sum(camion)
  
  
  ################################################################################################################
  
  
  out<-geojson_read("bruxelles.json")
  
  pal <- colorNumeric(palette = colorRampPalette(c("red", "blue"))(3), domain = 1:3)
  pal3 <- colorNumeric(palette = colorRampPalette(c("blue","red"))(8), domain = 0:sum(camion))
  colors <- c("red", "green", "blue")
  
  updateSliderInput(session, "slider", min =unique(data3$hour)[1], max = length((unique(data3$hour))))
  
  
  observe({
    
    selectedTime <- as.numeric(input$slider)
    
    coord1<-data3[data3$hour==selectedTime,]
    
    coordinates(coord1) <- ~first.longit. + first.lat.
    
    proj4string(coord1) <- proj4string(bxl) 
    
    camion<-over(coord1, as(bxl,"SpatialPolygons"))
    
    camion[is.na(camion)]<-0
    
    dfnew1<-data3[data3$hour==selectedTime,]
    
    dfnew1 <- data.frame(dfnew1$date, dfnew1$first.class_id.,camion)
    names(dfnew1) <- c("date", "class", "camion")
    
    pipi1<-dfnew1 %>%  group_by(class) %>% summarise(value=sum(camion,na.rm = TRUE))
    
    pipi1<-t(pipi1)
    
    maptime<-leaflet(data3)  %>% addProviderTiles(providers$CartoDB.Positron) %>% 
      setView(4.350382, 50.847436, zoom = 11)  %>% 
      addGeoJSON(out, color=pal3(sum(camion)),fillOpacity = 0, group="Brussels") %>%
      addLayersControl(baseGroups = c("OSMap"),overlayGroups =c("trucks","Brussels") )%>%
      hideGroup("trucks")%>% 
      addMinicharts( 4.4123, 50.738 , chartdata = sum(camion), showLabels = TRUE, width = 60)%>% 
      addMinicharts(4.350382, 50.847436,chartdata =pipi1[2,], colorPalette = colors,width = 95, height = 85)
    
    output$plot0 = renderLeaflet(maptime)})
  
  
  #################################################################################################################
  dfnew <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion)
  names(dfnew) <- c("date", "hour", "long","lat", "class", "camion")
  
  
  pipi<-dfnew %>%  group_by(hour, class) %>% summarise(value=sum(camion,na.rm = TRUE))
  pip<-dfnew %>%  group_by(hour,class) %>% summarise(BXL=n())
  
  
  pipi$class<-as.character(pipi$class)
  df_sing = melt(pipi, id =c('hour','class') )
  
  output$table0 <- DT::renderDataTable({ pipi })
  
  
  
  
})


############################################################################################################################################################################################


map <- leaflet() %>% addProviderTiles(providers$CartoDB.Positron) %>% setView(4.350382, 50.847436, zoom=11)

output$plot1 = renderLeaflet(map)



########################################### Data Table  
output$table <- DT::renderDataTable({
  
  unit <- as.integer( difftime(as.Date(input$date1), "2017-10-11" ))
  
  data3 <- subset( data2[[unit]], hour == input$hourly1 ) # input$hourly
})




observe({
  
  
  unit <- as.integer(difftime(as.Date(input$date1),"2017-10-11")) #as.Date()
  
  data3 <- subset(data2[[unit]], hour == input$hourly1) 
  
  ############################################################          
  coord1<-data3
  
  coordinates(coord1) <- ~first.longit. + first.lat.
  
  proj4string(coord1) <- proj4string(bxl)
  proj4string(coord1) <- proj4string(And) # 1
  proj4string(coord1) <- proj4string(Aud) # 2
  proj4string(coord1) <- proj4string(Agat) # 3
  proj4string(coord1) <- proj4string(Vil) # 4
  proj4string(coord1) <- proj4string(Etter) # 5
  proj4string(coord1) <- proj4string(Ever) # 6
  proj4string(coord1) <- proj4string(Stgil) # 7
  proj4string(coord1) <- proj4string(Fore) # 8
  proj4string(coord1) <- proj4string(Gans) # 9
  proj4string(coord1) <- proj4string(Ixel) # 10
  proj4string(coord1) <- proj4string(Jette) # 11
  proj4string(coord1) <- proj4string(Koek) # 12
  proj4string(coord1) <- proj4string(Molen) # 13
  proj4string(coord1) <- proj4string(Nood) # 14
  proj4string(coord1) <- proj4string(Schae) # 15
  proj4string(coord1) <- proj4string(Uccl) # 16
  proj4string(coord1) <- proj4string(Boit) # 17
  proj4string(coord1) <- proj4string(Lamb) # 18
  proj4string(coord1) <- proj4string(Pier) # 19
  
  camion<-over(coord1, as(bxl,"SpatialPolygons"))
  camion1<-over(coord1, as(And,"SpatialPolygons")) # trucks in anderlecht
  camion2<-over(coord1, as(Aud,"SpatialPolygons")) # trucks in auderghem
  camion3<-over(coord1, as(Agat,"SpatialPolygons")) # trucks in Berchem-Sainte-Agathe
  camion4<-over(coord1, as(Vil,"SpatialPolygons")) # trucks in Bruxelles-Ville
  camion5<-over(coord1, as(Etter,"SpatialPolygons")) # trucks in Etterbeek
  camion6<-over(coord1, as(Ever,"SpatialPolygons")) # trucks in Evere
  camion7<-over(coord1, as(Stgil,"SpatialPolygons")) # trucks in St Gilles
  camion8<-over(coord1, as(Fore,"SpatialPolygons")) # trucks in Forest
  camion9<-over(coord1, as(Gans,"SpatialPolygons")) # trucks in Ganshoren
  camion10<-over(coord1, as(Ixel,"SpatialPolygons")) # trucks in Ixelles
  camion11<-over(coord1, as(Jette,"SpatialPolygons")) # trucks in Jette
  camion12<-over(coord1, as(Koek,"SpatialPolygons")) # trucks in Koekelberg
  camion13<-over(coord1, as(Molen,"SpatialPolygons")) # trucks in Molenbeek
  camion14<-over(coord1, as(Nood,"SpatialPolygons")) # trucks in Noode
  camion15<-over(coord1, as(Schae,"SpatialPolygons")) # trucks in Schaerbeek
  camion16<-over(coord1, as(Uccl,"SpatialPolygons")) # trucks in Uccle
  camion17<-over(coord1, as(Boit,"SpatialPolygons")) # trucks in Boitsfort
  camion18<-over(coord1, as(Lamb,"SpatialPolygons")) # trucks in Lambert
  camion19<-over(coord1, as(Pier,"SpatialPolygons")) # trucks in Pierre
  
  camion[is.na(camion)]<-0
  camion1[is.na(camion1)]<-0
  camion2[is.na(camion2)]<-0
  camion3[is.na(camion3)]<-0
  camion4[is.na(camion4)]<-0
  camion5[is.na(camion5)]<-0
  camion6[is.na(camion6)]<-0
  camion7[is.na(camion7)]<-0
  camion8[is.na(camion8)]<-0
  camion9[is.na(camion9)]<-0
  camion10[is.na(camion10)]<-0
  camion11[is.na(camion11)]<-0
  camion12[is.na(camion12)]<-0
  camion13[is.na(camion13)]<-0
  camion14[is.na(camion14)]<-0
  camion15[is.na(camion15)]<-0
  camion16[is.na(camion16)]<-0
  camion17[is.na(camion17)]<-0
  camion18[is.na(camion18)]<-0
  camion19[is.na(camion19)]<-0
  
  sum(camion)
  sum(camion1)
  sum(camion2)
  sum(camion3)
  sum(camion4)
  sum(camion5)
  sum(camion6)
  sum(camion7)
  sum(camion8)
  sum(camion9)
  sum(camion10)
  sum(camion11)
  sum(camion12)
  sum(camion13)
  sum(camion14)
  sum(camion15)
  sum(camion16)
  sum(camion17)
  sum(camion18)
  sum(camion19)
  
  ###########################################################  set up palette colors      
  pal <- colorNumeric(palette = colorRampPalette(c("red", "blue"))(10), domain = 0:max(data3$first.speed.))
  pal2 <- colorNumeric(palette = colorRampPalette(c("blue", "red"))(5), domain = 0:length(camion))
  pal3 <- colorNumeric(palette = colorRampPalette(c("blue","red"))(8), domain = 0:sum(camion))
  
  
  ###########################################################           
  district <- c("Anderlecht","Auderghem","St-Agathe","Bruxelles-ville",
                "Etterbeek","Evere","St Gilles", "Forest", "Ganshoren", 
                "Ixelles", "Jette","Koekelberg", "Molenbeek", "Noode",
                "Schaerbeek", "Uccle", "Boitsfort","Lambert", "Pierre")
  
  trucks <- c(sum(camion1),sum(camion2),sum(camion3),sum(camion4),sum(camion5),
              sum(camion6),sum(camion7),sum(camion8),sum(camion9),sum(camion10),
              sum(camion11),sum(camion12),sum(camion13),sum(camion14),sum(camion15),
              sum(camion16),sum(camion17),sum(camion18),sum(camion19))
  
  diamonds <- data.frame(district, trucks)   # set up dataframe for plotting
  
  ########################################################### 
  
  maptime <-leaflet(data3)  %>% addProviderTiles(providers$CartoDB.Positron) %>% setView(4.350382, 50.847436, zoom = 11) %>%
    addCircleMarkers(~first.longit., ~first.lat., 
                     label= paste("ID :  ",as.character(data3$ID)," --- Velocity : ",as.character(as.integer(data3$first.speed.))),
                     color = ~pal(data3$first.speed.),
                     group = "trucks") %>%
    
    addGeoJSON(and, color=pal3(sum(camion1)),fillOpacity = 0.50, group="Anderlecht") %>%                   # 1
    addGeoJSON(aud, color=pal3(sum(camion2)),fillOpacity = 0.50, group="Auderghem") %>%                    # 2
    addGeoJSON(agat, color=pal3(sum(camion3)),fillOpacity = 0.50, group="Berchem-Sainte-Agathe") %>%       # 3
    addGeoJSON(vil, color=pal3(sum(camion4)), fillOpacity = 0.50, group="Bruxelles-ville") %>%             # 4
    addGeoJSON(etter, color=pal3(sum(camion5)),fillOpacity = 0.50, group="Etterbeek") %>%                  # 5
    addGeoJSON(ever, color=pal3(sum(camion6)),fillOpacity = 0.50, group="Evere") %>%                        # 6
    addGeoJSON(stgil, color=pal3(sum(camion7)),fillOpacity = 0.50, group="StGilles") %>%                     # 7
    addGeoJSON(fore, color=pal3(sum(camion8)), fillOpacity = 0.50, group="Forest") %>%                     # 8
    addGeoJSON(gans, color=pal3(sum(camion9)),fillOpacity = 0.50, group="Ganshoren") %>%                   # 9
    addGeoJSON(ixel, color=pal3(sum(camion10)),fillOpacity = 0.50, group="Ixelles") %>%                     # 10
    addGeoJSON(jette, color=pal3(sum(camion11)),fillOpacity = 0.50, group="Jette") %>%                      # 11
    addGeoJSON(koek, color=pal3(sum(camion12)),fillOpacity = 0.50, group="Koeklberg") %>%                   # 12
    addGeoJSON(molen, color=pal3(sum(camion13)),fillOpacity = 0.50, group="Molenbeek") %>%                  # 13
    addGeoJSON(nood, color=pal3(sum(camion14)),fillOpacity = 0.50, group="Noode") %>%                       # 14
    addGeoJSON(schae, color=pal3(sum(camion15)),fillOpacity = 0.50, group="Schaerbeek") %>%                 # 15
    addGeoJSON(uccl, color=pal3(sum(camion16)),fillOpacity = 0.50, group="Uccle") %>%                       # 16
    addGeoJSON(boit, color=pal3(sum(camion17)),fillOpacity = 0.50, group="Boitsfort") %>%                   # 17
    addGeoJSON(lamb, color=pal3(sum(camion18)),fillOpacity = 0.50, group="Lambert") %>%                     # 18
    addGeoJSON(pier, color=pal3(sum(camion19)),fillOpacity = 0.50, group="Pierre") %>% 
    addLayersControl(baseGroups = c("OSMap"),
                     overlayGroups =c("trucks","Anderlecht","Auderghem","Berchem-Sainte-Agathe",
                                      "Bruxells-Capital","Bruxelles-ville","Etterbeek","Evere",
                                      "StGilles","Forest","Ganshoren","Ixelles","Jette","Koeklberg",
                                      "Molenbeek", "Noode","Schaerbeek","Uccle",
                                      "Boitsfort", "Lambert","Pierre"))%>% 
    hideGroup("trucks") %>% 
    
    
    addMinicharts( 4.4123, 50.738 , chartdata = sum(camion), showLabels = TRUE, width = 60) %>%     
    addMinicharts( 4.3123401, 50.8381411 , chartdata = sum(camion1), showLabels = TRUE, width = 40) %>% # anderlecht
    addMinicharts( 4.4331389, 50.8156571 , chartdata = sum(camion2), showLabels = TRUE, width = 40) %>% # auderghem
    addMinicharts( 4.292702, 50.8639835 , chartdata = sum(camion3), showLabels = TRUE, width = 40)  %>% # Berchem-Sainte-Agathe
    addMinicharts( 4.3521027661457, 50.854422 , chartdata = sum(camion4), showLabels = TRUE, width = 40) %>% # Bruxelles-ville
    addMinicharts( 4.3895104, 50.8368511 , chartdata = sum(camion5), showLabels = TRUE, width = 40) %>% # Etterbeek
    addMinicharts( 4.4021602, 50.8704524 , chartdata = sum(camion6), showLabels = TRUE, width = 40) %>% # Evere
    addMinicharts( 4.345668, 50.8267409 , chartdata = sum(camion7), showLabels = TRUE, width = 40) %>% # St Gilles
    addMinicharts( 4.3177512, 50.8091426 , chartdata = sum(camion8), showLabels = TRUE, width = 40) %>% # Forest
    addMinicharts( 4.3175103, 50.8712396 , chartdata = sum(camion9), showLabels = TRUE, width = 40) %>% # Ganshoren
    addMinicharts( 4.3815707, 50.8222854 , chartdata = sum(camion10), showLabels = TRUE, width = 40) %>% # Ixelles
    addMinicharts( 4.3260903, 50.8777634 , chartdata = sum(camion11), showLabels = TRUE, width = 40) %>% # Jette
    addMinicharts( 4.3257084, 50.8622633 , chartdata = sum(camion12), showLabels = TRUE, width = 40) %>% # Koekelberg
    addMinicharts( 4.3227779, 50.8543551 , chartdata = sum(camion13), showLabels = TRUE, width = 40) %>% # Molenbeek
    addMinicharts( 4.3723364, 50.8530739 , chartdata = sum(camion14), showLabels = TRUE, width = 40) %>% # Noode
    addMinicharts( 4.3737121, 50.8676041 , chartdata = sum(camion15), showLabels = TRUE, width = 40) %>% # Schaerbeek
    addMinicharts( 4.3372348, 50.8018201 , chartdata = sum(camion16), showLabels = TRUE, width = 40) %>% # Uccle
    addMinicharts( 4.4158177, 50.799394 , chartdata = sum(camion17), showLabels = TRUE, width = 40) %>% # Boitsfort
    addMinicharts( 4.4284842, 50.8466928 , chartdata = sum(camion18), showLabels = TRUE, width = 40) %>% # Lambert
    addMinicharts( 4.4432967, 50.8292429 , chartdata = sum(camion19), showLabels = TRUE, width = 40) # Pierre
  
  
  
  ####### Pie Chart
  charttime <- plot_ly(diamonds, labels = ~district, values = ~trucks, type = 'pie',
                       textposition = 'inside',
                       textinfo = 'label+percent',
                       insidetextfont = list(color = '#FFFFFF'),
                       hoverinfo = 'text',
                       text = ~paste(district, ': ', trucks, ' trucks')) %>%
    
    layout(title = "Trucks in Districts",
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  
  ##### Bar Chart
  charttime1 <- ggplot2::diamonds  %>%
    plot_ly(x = ~district, y = ~trucks, color = ~district, type = "bar")%>%
    layout(xaxis = list(title = "", tickangle = -45),
           yaxis = list(title = ""),
           margin = list(b = 100))     
  
  
  
  
  output$plot1 = renderLeaflet(maptime)
  output$histCentile <- renderPlotly({charttime})
  output$histCentile1 <- renderPlotly({charttime1})
  
  
  
  
})



observe({
  
  
  unit <- as.integer(difftime(as.Date(input$date),"2017-10-11")) #as.Date()
  
  data3 <- atad2[[unit]]
  
  coord1<-data3
  
  coordinates(coord1) <- ~first.longit. + first.lat.
  
  #######################################################################################         
  proj4string(coord1) <- proj4string(bxl) 
  proj4string(coord1) <- proj4string(And) # 1
  proj4string(coord1) <- proj4string(Aud) # 2
  proj4string(coord1) <- proj4string(Agat) # 3
  proj4string(coord1) <- proj4string(Vil) # 4
  proj4string(coord1) <- proj4string(Etter) # 5
  proj4string(coord1) <- proj4string(Ever) # 6
  proj4string(coord1) <- proj4string(Stgil) # 7
  proj4string(coord1) <- proj4string(Fore) # 8
  proj4string(coord1) <- proj4string(Gans) # 9
  proj4string(coord1) <- proj4string(Ixel) # 10
  proj4string(coord1) <- proj4string(Jette) # 11
  proj4string(coord1) <- proj4string(Koek) # 12
  proj4string(coord1) <- proj4string(Molen) # 13
  proj4string(coord1) <- proj4string(Nood) # 14
  proj4string(coord1) <- proj4string(Schae) # 15
  proj4string(coord1) <- proj4string(Uccl) # 16
  proj4string(coord1) <- proj4string(Boit) # 17
  proj4string(coord1) <- proj4string(Lamb) # 18
  proj4string(coord1) <- proj4string(Pier) # 19
  
  camion<-over(coord1, as(bxl,"SpatialPolygons"))
  camion1<-over(coord1, as(And,"SpatialPolygons")) # trucks in anderlecht
  camion2<-over(coord1, as(Aud,"SpatialPolygons")) # trucks in auderghem
  camion3<-over(coord1, as(Agat,"SpatialPolygons")) # trucks in Berchem-Sainte-Agathe
  camion4<-over(coord1, as(Vil,"SpatialPolygons")) # trucks in Bruxelles-Ville
  camion5<-over(coord1, as(Etter,"SpatialPolygons")) # trucks in Etterbeek
  camion6<-over(coord1, as(Ever,"SpatialPolygons")) # trucks in Evere
  camion7<-over(coord1, as(Stgil,"SpatialPolygons")) # trucks in St Gilles
  camion8<-over(coord1, as(Fore,"SpatialPolygons")) # trucks in Forest
  camion9<-over(coord1, as(Gans,"SpatialPolygons")) # trucks in Ganshoren
  camion10<-over(coord1, as(Ixel,"SpatialPolygons")) # trucks in Ixelles
  camion11<-over(coord1, as(Jette,"SpatialPolygons")) # trucks in Jette
  camion12<-over(coord1, as(Koek,"SpatialPolygons")) # trucks in Koekelberg
  camion13<-over(coord1, as(Molen,"SpatialPolygons")) # trucks in Molenbeek
  camion14<-over(coord1, as(Nood,"SpatialPolygons")) # trucks in Noode
  camion15<-over(coord1, as(Schae,"SpatialPolygons")) # trucks in Schaerbeek
  camion16<-over(coord1, as(Uccl,"SpatialPolygons")) # trucks in Uccle
  camion17<-over(coord1, as(Boit,"SpatialPolygons")) # trucks in Boitsfort
  camion18<-over(coord1, as(Lamb,"SpatialPolygons")) # trucks in Lambert
  camion19<-over(coord1, as(Pier,"SpatialPolygons")) # trucks in Pierre
  
  ################################################################################################################
  dfnew <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion)
  names(dfnew) <- c("date", "hour", "long","lat", "class", "camion")
  dfnew1 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion1)
  names(dfnew1) <- c("date", "hour", "long","lat", "class", "camion1")
  dfnew2 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion2)
  names(dfnew2) <- c("date", "hour", "long","lat", "class", "camion2")
  dfnew3 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion3)
  names(dfnew3) <- c("date", "hour", "long","lat", "class", "camion3")
  dfnew4 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion4)
  names(dfnew4) <- c("date", "hour", "long","lat", "class", "camion4")
  dfnew5 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion5)
  names(dfnew5) <- c("date", "hour", "long","lat", "class", "camion5")
  dfnew6 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion6)
  names(dfnew6) <- c("date", "hour", "long","lat", "class", "camion6")
  dfnew7 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion7)
  names(dfnew7) <- c("date", "hour", "long","lat", "class", "camion7")
  dfnew8 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion8)
  names(dfnew8) <- c("date", "hour", "long","lat", "class", "camion8")
  dfnew9 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion9)
  names(dfnew9) <- c("date", "hour", "long","lat", "class", "camion9")
  dfnew10 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion10)
  names(dfnew10) <- c("date", "hour", "long","lat", "class", "camion10")
  dfnew11 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion11)
  names(dfnew11) <- c("date", "hour", "long","lat", "class", "camion11")
  dfnew12 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion12)
  names(dfnew12) <- c("date", "hour", "long","lat", "class", "camion12")
  dfnew13 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion13)
  names(dfnew13) <- c("date", "hour", "long","lat", "class", "camion13")
  dfnew14 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion14)
  names(dfnew14) <- c("date", "hour", "long","lat", "class", "camion14")
  dfnew15 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion15)
  names(dfnew15) <- c("date", "hour", "long","lat", "class", "camion15")
  dfnew16 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion16)
  names(dfnew16) <- c("date", "hour", "long","lat", "class", "camion16")
  dfnew17 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion17)
  names(dfnew17) <- c("date", "hour", "long","lat", "class", "camion17")
  dfnew18 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion18)
  names(dfnew18) <- c("date", "hour", "long","lat", "class", "camion18")
  dfnew19 <- data.frame(data3$date, data3$hour,data3$first.longit.,data3$first.lat.,data3$first.class_id.,camion19)
  names(dfnew19) <- c("date", "hour", "long","lat", "class", "camion19")
  
  pipi<-dfnew %>%  group_by(hour, class) %>% summarise(value=sum(camion,na.rm = TRUE))
  pip<-dfnew %>%  group_by(hour,class) %>% summarise(BXL=n())
  pip1<-dfnew1 %>%  group_by(hour,class) %>% summarise(ANDERLECHT=sum(camion1,na.rm = TRUE))
  pip2<-dfnew2 %>%  group_by(hour,class) %>% summarise(AUDERGHEM=sum(camion2,na.rm = TRUE))
  pip3<-dfnew3 %>%  group_by(hour,class) %>% summarise(STAGATHE=sum(camion3,na.rm = TRUE))
  pip4<-dfnew4 %>%  group_by(hour,class) %>% summarise(BRUXELLESVILLE=sum(camion4,na.rm = TRUE))
  pip5<-dfnew5 %>%  group_by(hour,class) %>% summarise(ETTERBEEK=sum(camion5,na.rm = TRUE))
  pip6<-dfnew6 %>%  group_by(hour,class) %>% summarise(EVERE=sum(camion6,na.rm = TRUE))
  pip7<-dfnew7 %>%  group_by(hour,class) %>% summarise(STGILLES=sum(camion7,na.rm = TRUE))
  pip8<-dfnew8 %>%  group_by(hour,class) %>% summarise(FOREST=sum(camion8,na.rm = TRUE))
  pip9<-dfnew9 %>%  group_by(hour,class) %>% summarise(GANSHOREN=sum(camion9,na.rm = TRUE))
  pip10<-dfnew10 %>%  group_by(hour,class) %>% summarise(IXELLES=sum(camion10,na.rm = TRUE))
  pip11<-dfnew11 %>%  group_by(hour,class) %>% summarise(JETTE=sum(camion11,na.rm = TRUE))
  pip12<-dfnew12 %>%  group_by(hour,class) %>% summarise(KOEKLBERG=sum(camion12,na.rm = TRUE))
  pip13<-dfnew13 %>%  group_by(hour,class) %>% summarise(MOLENBEEK=sum(camion13,na.rm = TRUE))
  pip14<-dfnew14 %>%  group_by(hour,class) %>% summarise(NOODE=sum(camion14,na.rm = TRUE))
  pip15<-dfnew15 %>%  group_by(hour,class) %>% summarise(SCHAERBEEK=sum(camion15,na.rm = TRUE))
  pip16<-dfnew16 %>%  group_by(hour,class) %>% summarise(UCCLE=sum(camion16,na.rm = TRUE))
  pip17<-dfnew17 %>%  group_by(hour,class) %>% summarise( BOITSFORT=sum(camion17,na.rm = TRUE))
  pip18<-dfnew18 %>%  group_by(hour,class) %>% summarise(LAMBERT=sum(camion18,na.rm = TRUE))
  pip19<-dfnew19 %>%  group_by(hour,class) %>% summarise(PIERRE=sum(camion19,na.rm = TRUE))
  
  
  library(plotly)
  
  dfew <- data.frame(pip1,pip2[,3],pip3[,3],pip4[,3],pip5[,3],pip6[,3],pip7[,3],pip8[,3],pip9[,3],pip10[,3],pip11[,3],pip12[,3],pip13[,3],pip14[,3],pip15[,3],
                     pip16[,3],pip17[,3],pip18[,3],pip19[,3])
  
  
  
  
  output$table1 <- DT::renderDataTable({ dfew })
  output$table2 <- DT::renderDataTable({dd<-subset(dfew , hour == input$hourly )  })
  
  
  
  dfew$class<-as.character(dfew$class)
  pipi$class<-as.character(pipi$class)
  
  
  
  df_tot = melt(dfew, id =c('hour','class') )
  df_sing = melt(pipi, id =c('hour','class') )
  
  
  
  g2 <- ggplot(df_tot, aes(x = hour, y = value, fill=class)) + 
    geom_bar(stat="identity",alpha=.5) + 
    facet_wrap(~ variable, scales = 'free_y') +
    mynamestheme +
    ylim(0, NA) + 
    ggtitle("Trucks in Districts", data3$date) +
    labs(y="Trucks per Class", x = "hours", fill = "Truck Class") 
  
  
  g3 <- ggplot(df_sing, aes(x = hour, y = value, fill=class)) + 
    geom_bar(stat="identity",alpha=.5) + 
    mynamestheme +
    ylim(0, NA) +
    ggtitle("Trucks in Bruxelles", data3$date) +
    labs(y="Trucks per Class", x = "hours", fill = "Truck Class") 
  
  
  output$histCentile2 <-renderPlot(g2)
  output$histCentile3 <-renderPlot(g3)
  
  
})






})
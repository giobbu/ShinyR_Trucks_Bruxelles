


ui <- dashboardPage(
  skin="yellow",
  
  dashboardHeader(title = "Trucks Mobility",
                  dropdownMenu(type = "notifications",
                               notificationItem(
                                 text = "MOBI-AID Pleasure!",
                                 icon = icon("exclamation-triangle"),
                                 status = "warning"))),
  
  
  ## Sidebar content
  dashboardSidebar(
    
    
    sidebarMenu(
      
      menuItem("MOBI-AID project", tabName = "project", icon = icon("home")),
      menuItem("Index", tabName = "index", icon = icon("archive")),
      menuItem("Dashboard", tabName = "Dashboard", icon = icon("dashboard")),
      menuItem("Charts", tabName = "Charts", icon = icon("bar-chart"))  #truck
      
    )
  ),
  
  
  dashboardBody(
    
    tabItems(
      
      
      tabItem( tabName = "project",fluidPage(includeHTML("project.html"))),
      
      tabItem( tabName = "index",
               
               fluidPage( box(leafletOutput("plot0",height = 900) ,
                              
                              fluidRow(column(5,selectInput("date0", "Date",c("2017-10-13","2017-10-14","2017-10-15","2017/10/16","2017/10/17","2017/10/18","2017/10/19"))),
                                       column(5,sliderInput("slider", label = "Select Time",  min = unique(data3$hour)[1] , max = length((unique(data3$hour))),value = 1,step=1, animate=TRUE)))),
                          includeHTML("rightcopy.html")
                          
               )),
      
      
      
      
      
      tabItem( tabName = "Dashboard",
               
               fluidPage( 
                 
                 fluidRow(
                   
                   column(5,selectInput("date1", "Date", c("2017-10-13","2017-10-14","2017-10-15","2017/10/16","2017/10/17","2017/10/18","2017/10/19"))),
                   
                   column(5,selectInput("hourly1", "Hour",  c("2","3","4","5","6","7","8","9","10", "11","12","13","14","15","16","17","18","19","20","21","22","23")))),
                 
                 
                 box(leafletOutput("plot1",height="600px"),
                     DT::dataTableOutput("table")),
                 
                 box(plotlyOutput("histCentile",height="600px"),
                     
                     plotlyOutput("histCentile1",height="500px")
                 )
                 
                 
               ), includeHTML("rightcopy.html")),
      
      
      tabItem( tabName = "Charts",
               
               fluidPage(
                 
                 fluidRow(column(5, selectInput("date", "Date",c("2017-10-13","2017-10-14","2017-10-15","2017/10/16","2017/10/17","2017/10/18","2017/10/19")))),
                 
                 fluidRow(column(8,plotOutput("histCentile2",height="600px")), column(4,plotOutput("histCentile3"))),
                 
                 fluidRow(column(2, selectInput("hourly", "Time", c("2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23")))),
                 
                 fluidRow(column(10 ,DT::dataTableOutput("table2"))),
                 
                 fluidRow(column(8,DT::dataTableOutput("table1")))
                 
                 
               ), includeHTML("rightcopy.html"))
      
      
      
      
      
    )))
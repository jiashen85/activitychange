library(data.table)
dat=fread(input="data/4cities.csv",na.strings="NA",stringsAsFactors = FALSE)
library(dplyr)

shinyServer(function(input,output){
   
  tablevalues=reactive({
    dat1=filter(dat,gender==input$gender & age==input$age & name==input$cty)
    dat1[hightemp<30 ,hightemp1:="<30"]
    dat1[hightemp>=30 & hightemp<40 ,hightemp1:="30-39"]
    dat1[hightemp>=40 & hightemp<50 ,hightemp1:="40-49"]
    dat1[hightemp>=50 & hightemp<60 ,hightemp1:="50-59"]
    dat1[hightemp>=60 & hightemp<70 ,hightemp1:="60-69"]
    dat1[hightemp>=70 & hightemp<80 ,hightemp1:="70-79"]
    dat1[hightemp>=80 & hightemp<90 ,hightemp1:="80-89"]
    dat1[hightemp>=90 ,hightemp1:=">90"]
    
    avg=round(mean(dat1$steps),0)
    pt=dat1[,.(meansteps=round(mean(steps),0)),by=hightemp1]
   preft=pt$hightemp1[which(pt$meansteps==max(pt$meansteps))]
   
   
    dat1$temp=factor(ifelse(dat1$hightemp1==preft,1,0))
    tdif=round(mean(dat1$steps[which(dat1$temp==1)])-mean(dat1$steps[which(dat1$temp==0)]),0)
    
    data.frame(
      Metrics = c("City", 
                  "Age",
                  "Gender",
                  "Average Steps in your group",
                  "Preferred Temperature",
                  "Decrease in Steps Outside Preferred Temp"
      ),
      Value = c(input$cty, 
                input$age,
                input$gender,
                avg,
                preft,
                tdif), 
      stringsAsFactors=FALSE)
  })
  # Show the values using an HTML table
  output$values <- renderTable({
    tablevalues()
  })
  
})
library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Find Your Activity Change!"),
  sidebarPanel(
    selectInput("cty","Choose your city:", choices=c(
      "Beijing","Berlin","Chicago","Dallas")),
    selectInput("age","Choose your age:",choices=c("20-29","30-39","40-49","50-59","60+")),
    selectInput ("gender","Choose your gender:",choices=c("F","M")),
    submitButton("Submit")
    
  ),
  mainPanel(
    tableOutput("values")
    
  )
))
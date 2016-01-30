#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(theme = "bootstrap.min.css",

  # Application title
  titlePanel("Body Fat Calculator"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        h3("How to Use"),
        p("Provide your height, weight, age and sex, then press 'Calculate'."),
        h3("Functionality"),
        p("This will estimate your body fat percentage using the formula described ",
          a(href = "https://en.wikipedia.org/wiki/Body_fat_percentage#From_BMI", "here"), "."),
        h3("Disclaimer"),
        p("Outcomes are based on formulas, actual measurements may vary, a lot!")
    ),

    mainPanel(
        fluidRow(
            column(width = 2, numericInput("weight", label = h4("Weight [kg]"), min = 0, value = 71)),
            column(width = 2, numericInput("height", label = h4("Height [m]"), min = .01, value = 1.82, step = .01))),
        fluidRow(
            column(width = 2, radioButtons("sex", label = h4("Sex"), choices = list("Male", "Female"), inline = TRUE)),
            column(width = 4, sliderInput("age", label = h4("Age [y]"), min = 0, max = 100, value = 31))
        ),
        submitButton("Calculate"),
        hr(),
        h3("Your BMI is:"), verbatimTextOutput("bmi"),
        h3("Your body fat percentage is:"), verbatimTextOutput("bodyFat"),
        h3("Your score is:"), plotOutput("score")
    )
  )
))

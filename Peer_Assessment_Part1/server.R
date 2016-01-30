#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny); library(ggplot2)

options(shiny.trace=TRUE)

categories <- data.frame(
    category = factor(rep(c(rep("Essential fat", 2), rep("Athletes", 2), rep("Fitness", 2), rep("Average", 2), rep("Obese", 2)), 2),
                      levels = c("Obese", "Average", "Fitness", "Athletes", "Essential fat"), ordered = TRUE),
    sex = factor(c(rep(0, 10), rep(1, 10)), levels = c(0, 1), labels = c("Female", "Male")),
    value = c(10, 13, 14, 20, 21, 24, 25, 31, 32, 40, 2, 5, 6, 13, 14, 17, 18, 24, 25, 40)
)

bmi <- function(weight, height) { weight / height ^ 2 }

bodyFat <- function(bmi, age, sex) {
    sex <- if(sex == "Male") 1 else 0
    if(age <= 18) # Children
        (1.51 * bmi) - (0.70 * age) - (3.6 * sex) + 1.4
    else # Adults
        (1.20 * bmi) + (0.23 * age) - (10.8 * sex) - 5.4
}

score <- function(bodyFat, sex) {
    ggplot(categories[categories$sex == sex,], aes(value, category, color = category)) +
        geom_line(size = 1) +
        geom_vline(aes(xintercept = bodyFat), size = 2, color = "red") +
        xlab("Body Fat Percentage") +
        ylab("Category")
}

shinyServer(function(input, output) {
    bmiTmp <- reactive(bmi(input$weight, input$height))
    bodyFatTmp <- reactive(bodyFat(bmiTmp(), input$age, input$sex))
    output$bmi <- renderPrint({round(bmiTmp(), 1)})
    output$bodyFat <- renderPrint({round(bodyFatTmp(), 1)})
    output$score <- renderPlot({score(bodyFatTmp(), input$sex)}, width = 800, height = 400)
})
# UI for CVD risk calculator using D'Agostino et. al (2008) office-based method

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Cardiovascular risk"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       numericInput("age", "What is your age?", value=30, min=1, max=99, step=1),
       selectInput("sex", "Gender", choices = list(Male=0, Female=1)),
       radioButtons("rxbp", "Are you on treatment for high blood pressure?", choices = list(No=0, Yes=1)),
       numericInput("sbp", "What is your systolic blood pressure?", value=120, min=50, max=250, step=1),
       numericInput("height","What is your height in cm?",value=160, min=100, max=250, step=1),
       numericInput("weight", "What is your weight in kg?", value=70, min=25, max=250, step=1),
       radioButtons("smoking", "Do you smoke?", choices=list(No=0, Yes=1)),
       radioButtons("diabetes", "Do you have diabetes?", choices=list(No=0, Yes=1))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
       tabPanel("Result", h4("Your 10 year risk of developing cardiovasular disease is:"),
                conditionalPanel(condition="input.sex==0",textOutput(outputId="outm")),
                conditionalPanel(condition="input.sex==1",textOutput(outputId="outf"))),

        tabPanel("Instructions",
                p("Enter the information on the left side and check the prediction of the
              risk of developing cardiovascular disease in 10 years in the Result tab")),

       tabPanel("References",
                p("Regression coefficients and hazard ratios were obtained from
                supplementary table 1 for the office-based non-laboratory predictors of CVD
                from the following paper:
                  D’Agostino, Ralph B., Ramachandran S. Vasan, Michael J. Pencina, Philip A. Wolf,
                  Mark Cobain, Joseph M. Massaro, and William B. Kannel. General
                  cardiovascular risk profile for use in primary care.
                  Circulation 117, no. 6 (2008): 743-753."))

       )

    )
  )
))

#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Calculate risk
shinyServer(function(input, output) {

  a <- reactive(input$rxbp)
  yesrxbp <- reactive(if (a()==1) 1 else 0)
  norxbp <- reactive(if (a()==0) 1 else 0)


  b <- reactive(input$smoking)
  smok <- reactive(if (b()==1) 1 else 0)

  c <- reactive(input$diabetes)
  diab <- reactive(if (c()==1) 1 else 0)

  bmi <- reactive(input$weight/((input$height)/100)^2)

  riskma <- reactive(3.11296*log(input$age) +
                      0.79277*log(bmi()) +
                      1.85508*norxbp()*log(input$sbp) +
                      1.92672*yesrxbp()*log(input$sbp) +
                      0.70953*smok() +
                      0.53160*diab()
                    )


  riskfa <- reactive(2.72107*log(input$age) +
                      0.51125*log(bmi()) +
                      2.81291*norxbp()*log(input$sbp) +
                      2.88267*yesrxbp()*log(input$sbp) +
                      0.61868*smok() +
                      0.77763*diab()
                    )



  riskm <- reactive((1-0.88431^(exp(riskma()-23.9388)))*100)
  riskf <- reactive((1-0.94833^(exp(riskma()-26.0145)))*100)

  output$outm <- renderText({ paste(round(riskm(),1)," %") })
  output$outf <- renderText({ paste(round(riskf(),1)," %") })

})





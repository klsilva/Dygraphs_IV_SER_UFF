#Pacotes sugestionados
pacotes <- c("shiny", "xts", "dygraphs", "magrittr", "readxl")
lapply(pacotes, library, character.only = TRUE)

#Carrege os dados aqui

#Ui

ui <- fluidPage(
    titlePanel("Petr�leo Brent"),
    mainPanel(dygraphOutput(outputId = " #Complete com outputId  ")))

#Server

server <- function(input, output) {
    output$dygraph <- renderDygraph({ #Complete com o gr�fico
    })
}

#Roda a aplica��o
shinyApp(ui = ui, server = server)

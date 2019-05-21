#Pacotes sugestionados
pacotes <- c("shiny", "xts", "dygraphs", "magrittr", "readxl")
lapply(pacotes, library, character.only = TRUE)

#Carrege os dados aqui

#Ui

ui <- fluidPage(
    titlePanel("Petróleo Brent"),
    mainPanel(dygraphOutput(outputId = " #Complete com outputId  ")))

#Server

server <- function(input, output) {
    output$dygraph <- renderDygraph({ #Complete com o gráfico
    })
}

#Roda a aplicação
shinyApp(ui = ui, server = server)

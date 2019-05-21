pacotes <- c("shiny", "xts", "dygraphs", "magrittr", "readxl")
lapply(pacotes, library, character.only = TRUE)

setwd("C:\\Users\\kmlou\\OneDrive\\Área de Trabalho\\Dygraphs_IV_SER_UFF-master\\Input")

dados_brent <-
  read_xls("Brent.xls")

str(dados_brent)

dados_brent <-
  as.xts(x = dados_brent$Preço_Brent, order.by = dados_brent$Data)
colnames(dados_brent)[1] <- "Preço_Brent"

#Ui

ui <- fluidPage(
  titlePanel("Petróleo Brent"),
  mainPanel(dygraphOutput("dygraph")))

#Server

server <- function(input, output) {
  output$dygraph <- renderDygraph({
    dygraph(dados_brent) %>% dyLimit(
      min(dados_brent$Preço_Brent),
      label = "preço mínimo",
      labelLoc = "right",
      color = "blue",
      strokePattern = "dashed"
    ) %>%
      dyLimit(
        max(dados_brent$Preço_Brent),
        label = "preço máximo",
        labelLoc = "left",
        color = "red",
        strokePattern = "dashed"
      )
  })
}

#Roda a aplicação
shinyApp(ui = ui, server = server)

#Instala e carrega pacotes
pacotes <- c("readxl", "xts", "dygraphs", "magrittr", "quantmod")
lapply(pacotes, install.packages)
lapply(pacotes, library, character.only = TRUE)

#Define área de trabalho
setwd("C:/Users/kmlou/OneDrive/Área de Trabalho/Input")

##Dygraphs

#Dados númericos
set.seed(22)
dados_num = data.frame(tempo = c(seq(0, 20, 0.05), 20),
                       valor = runif(n = 402, min = 0, max = 10))
str(dados_num)
#Séries temporais

dados_brent <-
  read_xls("Brent.xls")

str(dados_brent)

#Transforma em um objeto xts
dados_brent <-
  as.xts(x = dados_brent$Preço_Brent, order.by = dados_brent$Data)
colnames(dados_brent)[1] <- "Preço_Brent"


#Função:Dygraphs

#Caso - dados númericos

dygraph(dados_num)

#Casos - séries temporais

dygraph(dados_brent)

#Outros argumentos da função dygraph
dygraph(dados_brent,
        main = "Preço do Petroléo Brent",
        xlab = "Anos",
        ylab = "Preço do Petroléo (doláres)")

#Função:dyAxis

dygraph(dados_brent, main = "Preço do Petroléo Brent") %>% dyAxis(
  name = "x",
  label = "Anos",
  axisLabelFontSize = 14,
  axisLineColor = "black",
  axisLineWidth = 2,
  drawGrid = FALSE
) %>% dyAxis(
  name = "y",
  label = "Preço",
  axisLabelFontSize = 14,
  axisLineColor = "black",
  axisLineWidth = 2,
  drawGrid = FALSE
)


#dyOptions

dygraph(dados_brent,
        main = "Preço do Petróleo Brent",
        xlab = "Anos",
        ylab = "Preço do Petroléo (doláres)") %>% dyOptions(
          fillGraph = FALSE,
          fillAlpha = 0.5,
          stepPlot = FALSE,
          stemPlot = FALSE,
          drawPoints = FALSE,
          pointSize = 2,
          pointShape = "star",
          colors = "blue",
          colorValue = 0.5,
          axisLabelFontSize = 14,
          axisLineColor = "black",
          axisLineWidth = 2,
          drawGrid = TRUE,
          gridLineColor = "pink",
          gridLineWidth = 2
        )

#Função:dyCrosshair
dygraph(dados_brent) %>%  dyCrosshair(direction = "vertical")

#Função:dyRangeSelector

dygraph(dados_brent) %>% dyRangeSelector(
  dateWindow = c("1996-03-04", "2006-03-04"),
  fillColor = "green",
  strokeColor = "blue",
  height = 40
)

#Função:dyUnzoom

dygraph(dados_brent) %>% dyRangeSelector(
  dateWindow = c("1996-03-04", "2006-03-04"),
  fillColor = "green",
  strokeColor = "blue",
  height = 40
) %>% dyUnzoom()


#Função:dySeries
#Dois eixos y

load("precipitacao_sp.Rda")
load("temp_media_sp.Rda")

tempo_sp <- cbind(dados_temp, dados_precip)

dygraph(tempo_sp, main = "Condições Climáticas de São Paulo em Janeiro de 2018") %>% dySeries(
  "Temperatura",
  axis = "y2",
  color = "green",
  fillGraph = FALSE,
  stepPlot = FALSE,
  stemPlot = FALSE,
  drawPoints = FALSE,
  pointSize = 2,
  pointShape = "star",
  strokeWidth = 1,
  strokePattern = "dashed"
)

#Além de gráficos de linhas

dygraph(dados_temp) %>% dyBarChart()

dygraph(tempo_sp, main = "Condições Climáticas de São Paulo em Janeiro de 2018") %>% dyMultiColumn()

dados_IBM <-
  getSymbols('IBM', from = Sys.Date() - 30, auto.assign = FALSE)

head(dados_IBM)

dados_IBM <- dados_IBM[, 1:4]

dygraph(dados_IBM) %>% dyCandlestick()

dygraph(dados_precip) %>% dyShadow(name = "Precipitação")

dygraph(tempo_sp, main = "Condições Climáticas de São Paulo em Janeiro de 2018") %>% dyFilledLine(name = "Precipitação")

#Função:dyHighlight

dygraph(tempo_sp, main = "Condições Climáticas de São Paulo em Janeiro de 2018") %>% dyHighlight(
  highlightCircleSize = 5,
  highlightSeriesBackgroundAlpha = 0.2,
  hideOnMouseOut = FALSE
)

#Função:dyLegend

dygraph(tempo_sp, main = "Condições Climáticas de São Paulo em Janeiro de 2018") %>% dyLegend(
  show = "onmouseover",
  showZeroValues = TRUE,
  hideOnMouseOut = FALSE,
  labelsSeparateLines = TRUE,
  width = 250
)


#Função:dyAnnotation

dygraph(dados_precip) %>% dyAnnotation(
  "2018-01-30",
  text = "A",
  tooltip =
    "Maior Precipitação do Mês",
  width = 15,
  height = 20
)


#Função:dyShading

dygraph(dados_brent) %>% dyShading(
  from = "1990-09-02",
  to = "1991-02-28",
  color =
    "red",
  axis = "x"
)

#Função:dyEvent

dygraph(dados_brent) %>% dyEvent(
  "2007-07-24",
  label = "Crise do Subprime",
  labelLoc = "top",
  color = "black",
  strokePattern = "dashed"
)

#Função:dyLimit

dygraph(dados_brent) %>% dyLimit(
  min(dados_brent$Preço_Brent),
  label = "preço mínimo",
  labelLoc = "right",
  color = "blue",
  strokePattern = "dashed"
) %>% dyLimit(
  max(dados_brent$Preço_Brent),
  label = "preço máximo",
  labelLoc = "left",
  color = "red",
  strokePattern = "dashed"
)


#Função:dyRoller

dygraph(dados_brent) %>% dyRoller(showRoller = TRUE, rollPeriod = 120)


#Mais uma aplicação:dySeries

dados_ts <-
  ts(data = rnorm(n = 20),
     start = c(1996, 1),
     frequency = 4)

hw <- HoltWinters(dados_ts)

dados_ts_predict <-
  predict(hw, n.ahead = 10, prediction.interval = TRUE)


dygraph(dados_ts_predict) %>% dySeries(c("lwr", "fit", "upr"))

dados_ts_all <- cbind(dados_ts, dados_ts_predict)

dygraph(dados_ts_all) %>%
  dySeries("dados_ts", label = "Valores", axis = "y2") %>%
  dySeries(
    "dados_ts_predict.fit",
    "dados_ts_predict.upr",
    "dados_ts_predict.lwr",
    axis = "y",
    label = "Valores preditos"
  )


#Função:dyPlugin

dyHide <- function(dygraph) {
  dyPlugin(dygraph = dygraph,
           name = "Hide",
           path = "hide.js")
}

dygraph(tempo_sp, main = "Condições Climáticas de São Paulo em Janeiro de 2018") %>%
  dyHide()

#Salvando o gráfico em png

dygraph(dados_brent) %>% dyLimit(
  min(dados_brent$Preço_Brent),
  label = "preço mínimo",
  labelLoc = "right",
  color = "blue",
  strokePattern = "dashed"
) %>% dyLimit(
  max(dados_brent$Preço_Brent),
  label = "preço máximo",
  labelLoc = "left",
  color = "red",
  strokePattern = "dashed"
) %>% htmltools::save_html(file = "min_max_prec_brent.html")

webshot::webshot(url = "min_max_prec_brent.html", "min_max_prec_brent.png")

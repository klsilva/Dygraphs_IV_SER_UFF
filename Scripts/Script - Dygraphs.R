#Instala e carrega pacotes
pacotes <- c("readxl", "xts", "dygraphs", "magrittr", "quantmod")
lapply(pacotes, install.packages)
lapply(pacotes, library, character.only = TRUE)

#Define �rea de trabalho
setwd("Dygraphs_IV_SER_UFF-master\\Input")

##Dygraphs

#Dados n�mericos
set.seed(22)
dados_num = data.frame(tempo = c(seq(0, 20, 0.05), 20),
                       valor = runif(n = 402, min = 0, max = 10))
str(dados_num)
#S�ries temporais

dados_brent <-
  read_xls("Brent.xls")

str(dados_brent)

#Transforma em um objeto xts
dados_brent <-
  as.xts(x = dados_brent$Pre�o_Brent, order.by = dados_brent$Data)
colnames(dados_brent)[1] <- "Pre�o_Brent"


# Fun��o:Dygraphs
# Fun��o respons�vel por plotar os dados.

# Caso - dados n�mericos

dygraph(dados_num)

#Casos - s�ries temporais

dygraph(dados_brent)

#Outros argumentos da fun��o dygraph
dygraph(dados_brent,
        main = "Pre�o do Petrol�o Brent",
        xlab = "Anos",
        ylab = "Pre�o do Petrol�o (dol�res)")

# Fun��o:dyAxis
# Define op��es para um eixo de um gr�fico dygraph. 

dygraph(dados_brent, main = "Pre�o do Petrol�o Brent") %>% dyAxis(
  name = "x",
  label = "Anos",
  axisLabelFontSize = 14,
  axisLineColor = "black",
  axisLineWidth = 2,
  drawGrid = FALSE
) %>% dyAxis(
  name = "y",
  label = "Pre�o",
  axisLabelFontSize = 14,
  axisLineColor = "black",
  axisLineWidth = 2,
  drawGrid = FALSE
)


# Fun��o:dyOptions
# Adiciona op��es a um gr�fico dygraph.

dygraph(dados_brent,
        main = "Pre�o do Petr�leo Brent",
        xlab = "Anos",
        ylab = "Pre�o do Petrol�o (dol�res)") %>% dyOptions(
          fillGraph = FALSE,
          fillAlpha = 0.5,
          drawPoints = TRUE,
          pointSize = 2,
          pointShape = "star",
          colors = "red",
          axisLabelFontSize = 14,
          axisLineColor = "black",
          axisLineWidth = 2,
          drawGrid = TRUE,
          gridLineColor = "pink",
          gridLineWidth = 2
        )

# Fun��o:dyCrosshair
# Desenha uma linha sobre o ponto mais pr�ximo ao mouse quando o usu�rio passa este sobre o gr�fico.

dygraph(dados_brent) %>%  dyCrosshair(direction = "both")


# Exerc�cio

# Carregue o conjunto de dados "WTI.xls" como dados_wti
# Plote o conjunto de dados.
# Adicione o t�tulo "Pre�o do Petr�leo WTI" ao gr�fico
# Adicione o label "Anos" para o eixo x e o label "Pre�o (USD)" ao eixo y
# Customize o seu gr�fico a partir do dyOptions. Dica: Utilize o help.


# Fun��o:dyRangeSelector
# Adiciona um seletor de intervalo � parte inferior do gr�fico que permite aos usu�rios deslocar e aplicar zoom a v�rios per�odos

dygraph(dados_brent) %>% dyRangeSelector(
  dateWindow = c("1996-03-04", "2006-03-04"),
  fillColor = "green",
  strokeColor = "blue",
  height = 40
)

# Fun��o:dyUnzoom
# Adiciona o bot�o Unzoom no gr�fico quando este est� ampliado.
dygraph(dados_brent) %>% dyRangeSelector(
  dateWindow = c("1996-03-04", "2006-03-04"),
  fillColor = "green",
  strokeColor = "blue",
  height = 40
) %>% dyUnzoom()


# Fun��o:dySeries
# Adiciona uma s�rie de dados a um gr�fico dygraph.

# Dois eixos y

load("precipitacao_sp.Rda")
load("temp_media_sp.Rda")

tempo_sp <- cbind(dados_temp, dados_precip)

dygraph(tempo_sp, main = "Condi��es Clim�ticas de S�o Paulo em Janeiro de 2018") %>% dySeries(
  "Temperatura",
  axis = "y2",
  color = "green",
  fillGraph = FALSE,
  stepPlot = FALSE,
  stemPlot = TRUE,
  drawPoints = FALSE,
  pointSize = 2,
  pointShape = "star",
  strokeWidth = 1,
  strokePattern = "dashed"
)

#Al�m de gr�ficos de linhas

dygraph(dados_temp) %>% dyBarChart()

dygraph(tempo_sp, main = "Condi��es Clim�ticas de S�o Paulo em Janeiro de 2018") %>% dyMultiColumn()

dados_IBM <-
  getSymbols('IBM', from = Sys.Date() - 30, auto.assign = FALSE)

head(dados_IBM)

dados_IBM <- dados_IBM[, 1:4]

dygraph(dados_IBM) %>% dyCandlestick()

dygraph(dados_precip) %>% dyShadow(name = "Precipita��o")

dygraph(tempo_sp, main = "Condi��es Clim�ticas de S�o Paulo em Janeiro de 2018") %>% dyFilledLine(name = "Precipita��o")


# Fun��o:dyHighlight
# Configura op��es para destaques das s�rie de dados quando o mouse � passado sobre o gr�fico

dygraph(tempo_sp, main = "Condi��es Clim�ticas de S�o Paulo em Janeiro de 2018") %>% dyHighlight(
  highlightCircleSize = 5,
  highlightSeriesBackgroundAlpha = 0.2,
  hideOnMouseOut = FALSE
)


# Exerc�cio 

# Una dados_wti e dados_brent e denomine prec_conj
# Utilize o dyRangeSelector para o per�odo de "1996-03-04" a "2016-03-04"
# Adicione o bot�o de Unzoom ao gr�fico
# Por fim adicione o dyHighlight ao gr�fico
# Fa�a com que o highlight desapare�a quando o mouse n�o esteja sobre o gr�fico


# Fun��o:dyLegend
# Configura a legenda dos gr�ficos.

dygraph(tempo_sp, main = "Condi��es Clim�ticas de S�o Paulo em Janeiro de 2018") %>% dyLegend(
  show = "onmouseover",
  showZeroValues = TRUE,
  hideOnMouseOut = TRUE,
  labelsSeparateLines = TRUE,
  width = 250
)


# Fun��o:dyAnnotation
# Define uma anota��o de texto para um dado espec�fico.

dygraph(dados_precip) %>% dyAnnotation(
  "2018-01-30",
  text = "A",
  tooltip =
    "Maior Precipita��o do M�s",
  width = 15,
  height = 20
)


# Fun��o:dyShading
# Especifica uma regi�o do gr�fico para seja feito um sombreamento de plano de fundo.

dygraph(dados_brent) %>% dyShading(
  from = "1990-09-02",
  to = "1991-02-28",
  color =
    "red",
  axis = "x"
)

# Fun��o:dyEvent
# Adiciona uma linha vertical relacionada a um evento.

dygraph(dados_brent) %>% dyEvent(
  "2007-07-24",
  label = "Crise do Subprime",
  labelLoc = "bottom",
  color = "black",
  strokePattern = "dashed"
)

# Fun��o:dyLimit
# Adiciona linha de limite horizontal ao gr�fico.

dygraph(dados_brent) %>% dyLimit(
  min(dados_brent$Pre�o_Brent),
  label = "pre�o m�nimo",
  labelLoc = "right",
  color = "blue",
  strokePattern = "dashed"
) %>% dyLimit(
  max(dados_brent$Pre�o_Brent),
  label = "pre�o m�ximo",
  labelLoc = "left",
  color = "red",
  strokePattern = "dashed"
)


# Exerc�cio

# Plote o dados_wti
# A partir das fun��es explicadas a cima:
# Mostre onde ocorreu a Crise do Subprime ("2007-07-24")
# Mostre a Guerra do Golfo (In�cio: "1990-09-02",Fim: "1991-02-28")
# Indique um dos seus anivers�rio no gr�fico. Qual era o pre�o do petr�leo WTI no dia?
# Mostre no gr�fico o pre�o m�nimo, m�dio e m�ximo do petr�leo WTI.


# Fun��o:dyRoller
# Adiciona uma caixa de texto que realiza m�dia m�vel � parte inferior do gr�fico.

dygraph(dados_brent) %>% dyRoller(showRoller = TRUE, rollPeriod = 120)


# Mais uma aplica��o:dySeries

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


# Fun��o:dyPlugin
# Inclui um plugin.
dyHide <- function(dygraph) {
  dyPlugin(dygraph = dygraph,
           name = "Hide",
           path = "hide.js")
}

dygraph(tempo_sp, main = "Condi��es Clim�ticas de S�o Paulo em Janeiro de 2018") %>%
  dyHide()

# Salvando o gr�fico em png

dygraph(dados_brent) %>% dyLimit(
  min(dados_brent$Pre�o_Brent),
  label = "pre�o m�nimo",
  labelLoc = "right",
  color = "blue",
  strokePattern = "dashed"
) %>% dyLimit(
  max(dados_brent$Pre�o_Brent),
  label = "pre�o m�ximo",
  labelLoc = "left",
  color = "red",
  strokePattern = "dashed"
) %>% htmltools::save_html(file = "min_max_prec_brent.html")

webshot::webshot(url = "min_max_prec_brent.html", "min_max_prec_brent.png")

# Solu��o

# Carregue o conjunto de dados "WTI.xlsx" como dados_wti
# Plote o conjunto de dados.
# Adicione o t�tulo "Pre�o do Petr�leo WTI" ao gr�fico
# Adicione o label "Anos" para o eixo x e o label "Pre�o (USD)" ao eixo y
# Customize o seu gr�fico a partir do dyOptions. Dica: Utilize o help.


dados_wti <-
  read_xls("WTI.xls")

str(dados_brent)

#Transforma em um objeto xts
dados_wti <-
  as.xts(x = dados_wti$Pre�o_WTI, order.by = dados_wti$Data)
colnames(dados_brent)[1] <- "Pre�o_WTI"

dygraph(dados_wti,main="Pre�o do Petr�leo WTI") %>% dyAxis(
  name = "x",
  label = "Anos"
) %>% dyAxis(
  name = "y",
  label = "Pre�o (USD)",
)

#ou 

dygraph(dados_wti,main="Pre�o do Petr�leo WTI",xlab="Anos",ylab="Pre�o (USD)")



# Una dados_wti e dados_brent e denomine prec_conj
# Utilize o dyRangeSelector para o per�odo de "1996-03-04" a "2016-03-04"
# Adicione o bot�o de Unzoom ao gr�fico
# Por fim adicione o dyHighlight ao gr�fico
# Fa�a com que o highlight desapare�a quando o mouse n�o esteja sobre o gr�fico

prec_conj<-cbind(dados_wti,dados_brent)

dygraph(prec_conj) %>% dyRangeSelector(
  dateWindow = c("1996-03-04", "2016-03-04"),
  fillColor = "green",
  strokeColor = "blue",
  height = 40
) %>% dyUnzoom() %>% dyHighlight(
  highlightCircleSize = 5,
  highlightSeriesBackgroundAlpha = 0.2,
  hideOnMouseOut = TRUE
)


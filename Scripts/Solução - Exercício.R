# Solução

# Carregue o conjunto de dados "WTI.xlsx" como dados_wti
# Plote o conjunto de dados.
# Adicione o título "Preço do Petróleo WTI" ao gráfico
# Adicione o label "Anos" para o eixo x e o label "Preço (USD)" ao eixo y
# Customize o seu gráfico a partir do dyOptions. Dica: Utilize o help.


dados_wti <-
  read_xls("WTI.xls")

str(dados_brent)

#Transforma em um objeto xts
dados_wti <-
  as.xts(x = dados_wti$Preço_WTI, order.by = dados_wti$Data)
colnames(dados_brent)[1] <- "Preço_WTI"

dygraph(dados_wti,main="Preço do Petróleo WTI") %>% dyAxis(
  name = "x",
  label = "Anos"
) %>% dyAxis(
  name = "y",
  label = "Preço (USD)",
)

#ou 

dygraph(dados_wti,main="Preço do Petróleo WTI",xlab="Anos",ylab="Preço (USD)")



# Una dados_wti e dados_brent e denomine prec_conj
# Utilize o dyRangeSelector para o período de "1996-03-04" a "2016-03-04"
# Adicione o botão de Unzoom ao gráfico
# Por fim adicione o dyHighlight ao gráfico
# Faça com que o highlight desapareça quando o mouse não esteja sobre o gráfico

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


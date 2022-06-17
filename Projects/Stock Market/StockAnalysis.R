library(quantmod)
symbolBasket <- c('AAPL', 'AMZN', 'BRK-B', 'SPY')
getSymbols(symbolBasket , src='yahoo')
summary(`AMZN`)

AMZN <- as.xts(`AMZN`)
names(AMZN)

names(AMZN) <- c("AMZN.Open", "AMZN.High", "AMZN.Low", "AMZN.Close", "AMZN.Volume", "AMZN.Adjusted")
names(AMZN)

plot(AMZN$AMZN.Open)
plot(AMZN$AMZN.Close)
plot(AMZN$AMZN.Volume)

lineChart(AMZN$AMZN.Open, line.type = 'h', theme = 'black', TA = NULL)

lineChart(AMZN, line.type = 'h', theme = 'black')

barChart(AMZN, bar.type = 'hlc', TA = NULL)
candleChart(AMZN, TA=c(addMACD(),addVo()), subset = '2019')
chartSeries(AMZN, 
            type = c("auto", "candlesticks"), 
            subset = '2019-01::',
            show.grid = TRUE,
            major.ticks='auto', minor.ticks=TRUE,
            TA=c(addMACD(),addVo()))

chartSeries(AMZN, 
            type = c("auto", "matchsticks"), 
            subset = '2018-01::',
            show.grid = TRUE,
            major.ticks='auto', minor.ticks=TRUE,
            multi.col = FALSE,
            TA=c(addMACD(),addVo(),addSMA(n=200,col = 'blue'),addSMA(n=50,col = 'red'),addSMA(n=22,col = 'green'),
                 addROC(n=200,col = 'blue'),addROC(n=50,col = 'red'),addROC(n=22,col = 'green')))


AMZN.EMA.20<- EMA(AMZN$AMZN.Close, n=20)
AMZN.EMA.50<- EMA(AMZN$AMZN.Close, n=50)
AMZN.EMA.100<- EMA(AMZN$AMZN.Close, n=100)
AMZN.EMA.200<- EMA(AMZN$AMZN.Close, n=200)
chartSeries(AMZN, theme=chartTheme('black'),
            type = c("auto", "matchsticks"), 
            subset = '2018-01::',
            show.grid = TRUE,
            major.ticks='auto', minor.ticks=TRUE,
            multi.col = FALSE,
            TA=c(addMACD(),addVo(),addADX(n = 14, maType = "EMA")))

library(prophet)
library(lubridate)
library(ggplot2)
library(pacman)
pacman::p_load(data.table, fixest, BatchGetSymbols, finreportr, ggplot2, lubridate)
first.date <- Sys.Date() - 2500
last.date <- Sys.Date()
freq.data <- "daily"
tickers <- c("BALKRISIND.NS")

stocks <- BatchGetSymbols(tickers = tickers,
                          first.date = first.date,
                          last.date = last.date,
                          freq.data = freq.data,
                          do.cache = FALSE,
                          thresh.bad.data = 0)
data<-stocks$df.tickers
data<-na.omit(data)
head(data)

qplot(data$ref.date, data$price.close,data=data)

ds <- data$ref.date
y <- data$price.close
df <- data.frame(ds, y)
head(df)

m <- prophet(df)
future <- make_future_dataframe(m, periods = 30)
forecast <- predict(m, future)
pred <- forecast$yhat[1:dim(df)[1]]
actual <- m$history$y
plot(actual, pred)

summary(lm(pred~actual))

prophet_plot_components(m, forecast)

tail(forecast) 
plot(m, forecast)
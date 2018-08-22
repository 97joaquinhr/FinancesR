install.packages("quantmod")
install.packages("dplyr")

library(quantmod)
library(dplyr)

#Clean up the Global environments
rm(list=ls())

getSymbols(Symbols = "ALSEA.MX",src="yahoo")

class(ALSEA.MX)
names(ALSEA.MX)
head(ALSEA.MX)

index(ALSEA.MX)[1]

dim(ALSEA.MX)

#returns the number of observations
obs=index(ALSEA.MX)[dim(ALSEA.MX)[1]]
obs

range(index(ALSEA.MX))

getSymbols(Symbols = c("AAPL","GE"), #name of tickers
           from = "2017-01-01",#starting date
           to = "2017-12-31",#end date
           src= "yahoo") #the source

tickers.zoo=merge(AAPL,GE)
head(Ad(tickers.zoo),10)
chartSeries(ALSEA.MX,theme = ("white"))

ALSEA.df=ALSEA.MX
rm(ALSEA.MX)
names(ALSEA.df)<-c("Open_alsea","High_alsea","Low_alsea","Close_alsea","Volume_alsea", "Adjusted_price_alsea")
View(ALSEA.df)
summary(ALSEA.df)
ALSEA.df$Close_lag1_alsea <- lag(ALSEA.df$Close_alsea, n = 1)
ALSEA.df$R_alsea=ALSEA.df$Close_alsea/ALSEA.df$Close_lag1_alsea-1
head(ALSEA.df,10)

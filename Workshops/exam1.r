#install.packages("quantmod")
#install.packages("dplyr")
#install.packages("IntroCompFinR")
#install.packages("PerformanceAnalytics")
#install.packages("readxl")
#install.packages("tseries")
library(quantmod)
library(readxl)
library(dplyr)
# The IntroCompFinR package has functions for portfolio optimization
library(IntroCompFinR)
# The PerformanceAnalytics package has several functions to evaluate, manage
# and optimize portfolios
library(PerformanceAnalytics)
# The tseries package has functions related to time series data management
library(tseries)
rm(list = ls())
#hay que cambiar esto para que funcione
setwd("C:/Users/joaqu/Documents/Codigo/FinancesR/Workshops")
input.df = read_excel("InputEx1.xlsx",sheet="Portfoliosets")
sheet.list<-input.df$sheet


# Download the financial information from the web
for (j in 1:length(input.df$portfolio)){
  input2.df=read_excel("InputEx1.xlsx",sheet=sheet.list[j])
  tickers.list=input2.df$ticker
  getSymbols(tickers.list,
             from = "2016-01-01", to = Sys.Date()-1,
             periodicity = "monthly",
             src = "yahoo")
  prices.zoo=xts()
  for (i in 1:length(tickers.list)){
    prices.zoo=merge(prices.zoo,get(tickers.list[i]))
  }
  returns.zoo=diff(log(prices.zoo))
  returns.df <- as.data.frame(returns.zoo, na.remove = TRUE) %>%
    na.omit() %>%
    select(contains("Adjusted"))
  covm=var(returns.df)
  ER <-exp(apply(returns.df,2,mean))-1
  W=as.matrix(input2.df[,2:length(input2.df)])
  ERP <- t(W) %*% ER
  VARP <-t(W)%*% covm %*% W
  VARP=diag(VARP)
  RISKP <-sqrt(VARP)
  plot(RISKP,ERP, main="Portolio Risk vs Return")
  #ERP
  print(ERP)
  #RISKP
  print(RISKP)
  gmvportws = globalMin.portfolio(ER, covm,shorts=input.df$short[j])
  #GVM
  print(gmvportws)
  
  #hpr
  for (i in 1:length(returns.df)){
    print(exp(sum(returns.df[i]))-1)
  }
}

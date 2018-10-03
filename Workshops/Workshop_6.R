library(quantmod)
library(dplyr)
library(readxl)
setwd("C:/Users/joaqu/Documents/Codigo/FinancesR/Workshops")
input.df<-read_excel("InputW6.xlsx",sheet = "ticklist")
tickers.list<-input.df$ticker
getSymbols(tickers.list,
           from = "2014-01-01", to = "2017-12-31",
           periodicity = "monthly",
           src = "yahoo")

# prices.zoo <- merge(tickers.list)
# prices.zoo <- merge(tickers.list[1], tickers.list[2], tickers.list[3], tickers.list[4])
p1<-get(tickers.list[1])
p2<-get(tickers.list[2])
p3<-get(tickers.list[3])
p4<-get(tickers.list[4])
prices.zoo <- merge(p1, p2, p3, p4)
rm(p1, p2, p3, p4)
#Merge all
objList <- lapply(tickers.list, get)
class(objList)
head(objList[[1]])
prices.zoo <- merge(objList[[1]], objList[[2]], objList[[3]], objList[[4]])
prices.zoo <- do.call(merge, objList)
prices.df <- as.data.frame(prices.zoo) %>%
  na.omit() %>%
  select(contains("Adjusted"))
returns.df <- diff(log(as.zoo(prices.df)))
head(returns.df)
tail(returns.df)
# We get the market ticker from the mkt1 Sheet:
mkt.df <-read_excel("InputW6.xlsx",sheet = "mkt")
mktindex <-mkt.df$ticker
getSymbols(mktindex,
           from = "2014-01-01", to = "2017-12-31",
           periodicity = "monthly",
           src = "yahoo")

# I assign an object for the market data frame that was just brought from the web:
mktindex<-substr(mktindex,2,nchar(mktindex))
MXX<-get(mktindex)
# I select only the Adjusted price columm:
marketprices.df <- as.data.frame(MXX) %>%
  select(contains("Adjusted"))
# I create market returns:
mktreturns.df <- diff(log(as.zoo(marketprices.df)))
returns.df<-merge(mktreturns.df,returns.df)
# I create a list of tickers without .MX:
tickers.list<-sub(".MX","",tickers.list,fixed=TRUE)
tickers.list
# The sub function identifies a substring and replace it with other substring
# Now I assign the column names to returns.df:
colnames(returns.df)<-c(mktindex,tickers.list)
head(returns.df)
alfamod <- lm(ALFAA ~ MXX, data=returns.df)
class(alfamod)
attributes(alfamod)
summary(alfamod)
s <-summary(alfamod)
class(s)
s$coefficients
s$coefficients[,1]
betasalfa <- coefficients(lm(ALFAA ~ MXX, data=returns.df))
rets.mat <- as.matrix(returns.df)
class(rets.mat)
head(rets.mat)
ncol(rets.mat)
results.m = matrix(nrow=ncol(rets.mat)-1, ncol=2)
for(i in 2:ncol(rets.mat)) {
  results.m[i-1,] = coefficients(lm(rets.mat[,i] ~ rets.mat[,1]))
}
results.m
regf<-function(i) {
  return(coefficients(lm(rets.mat[,i] ~ rets.mat[,1])))
}
results.coeffs <- lapply(2:ncol(rets.mat), regf )
class(results.coeffs)
results.coeffs
results.coeffs[[1]]
stderrors<-function(i) {
  s<-summary(lm(rets.mat[,i] ~ rets.mat[,1]))
  return(s$coefficients[,2])
}
results.se <- lapply(2:ncol(rets.mat), stderrors )
results.se

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

ALSEA.df$r_alsea <- log(ALSEA.df$Close_alsea/ALSEA.df$Close_lag1_alsea)
head(ALSEA.df, 10)

summary(ALSEA.df$r_alsea)
hist(ALSEA.df$r_alsea, xlim=c(-0.1, 0.1), breaks = 500,
     main = "Histogram of daily compounded returns", xlab = "Compounded return")

HPR_from_r <- exp(sum(ALSEA.df$r_alsea, na.rm = TRUE))-1
n <- as.numeric(nrow(ALSEA.df))
Close_price_0 <- as.numeric(ALSEA.df$Close_alsea[1])
Close_price_n <- as.numeric(ALSEA.df$Close_alsea[n])
HPR_from_price <- Close_price_n/Close_price_0-1

HPR_from_r
HPR_from_price 
attributes(ALSEA.df)
ALSEA.df$year <- format(as.Date(index(ALSEA.df)), "%Y")
head(ALSEA.df, 10)

ALSEA_by_year.df <- as.data.frame(ALSEA.df) %>%
  group_by(year) %>%
  summarise(r_mean = mean(r_alsea, na.rm=TRUE))

ALSEA_by_year.df <- ALSEA_by_year.df %>%
  mutate(R_mean = exp(r_mean)-1)

barplot(ALSEA_by_year.df$R_mean,
        main = "Average daily return per year",
        xlab = "Year",
        ylab = "Return",
        names.arg = ALSEA_by_year.df$year,
        col = ifelse(ALSEA_by_year.df$R_mean > 0,"darkgreen","red"))

install.packages("quadprog")
install.packages("PerformanceAnalytics")
install.packages("IntroCompFinR", repos = "http://R-Forge.R-project.org")

library(PerformanceAnalytics)
library(IntroCompFinR)

# Clean up the Global environment
rm(list = ls())
# Download the new data
getSymbols(c("AAPL","WMT","MSFT","GE","TSLA"),
           from = "2015-01-01", to = "2017-12-31",
           src = "yahoo")

portfolio.zoo <- merge(AAPL, WMT, MSFT, GE, TSLA)
rm(AAPL, WMT, MSFT, GE, TSLA)

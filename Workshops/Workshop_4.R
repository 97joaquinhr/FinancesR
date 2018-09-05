#Workshop 4
#Joaquin Herrera
install.packages("tseries")

library(quantmod)
library(dplyr)
# The IntroCompFinR package has functions for portfolio optimization
library(IntroCompFinR)
# The PerformanceAnalytics package has several functions to evaluate, manage
# and optimize portfolios
library(PerformanceAnalytics)
# The tseries package has functions related to time series data management
library(tseries)

# Clean up the Global environment
rm(list = ls())
# Download the financial information from the web
getSymbols(c("AAPL","WMT","MSFT","GE","TSLA"),
           from = "2015-01-01", to = "2017-12-31",
           periodicity = "monthly",
           src = "yahoo")
# Merge
portfolio_bymth.zoo <- merge(AAPL, WMT, MSFT, GE, TSLA)
# Remove original objects
rm(AAPL, WMT, MSFT, GE, TSLA)
# Compounded returns calculation
returns.zoo <- diff(log(portfolio_bymth.zoo))
# We can also use the function Return.Calculate from the PerformanceAnalytics to do the same we did:
# returns.zoo <-Return.Calculate(portfolio_bymth.zoo,method="log")

returns.df <- as.data.frame(returns.zoo) %>% # Copy `returns.zoo` as data frame
  na.omit() %>% # remove the NAs
  select(contains("Adjusted")) # Keep the adjusted close prices only

# To avoid scientific notations for outputs, I define the following:
options(scipen=100)
options(digits=2)
returns.zoo<-as.zoo(returns.df)
# I use the table.Stats function from the PerformanceAnalytics package:
table.Stats(returns.df)

#We can do a Boxplot of the returns to better appreciate the median, the quartiles
#Q1 and Q3, volatility and extreme values of these returns:
chart.Boxplot(returns.zoo)
#covmat<-var(returns.df) works as well

ret.mat <- coredata(as.matrix(returns.df))
# Variance-covariance matrix
#We calculate the var-covar
covmat <- var(ret.mat)
# Vector of expected returns
er <- exp(apply(ret.mat, 2, mean)) -1

# Variance-covariance matrix
covmat

# Vector of expected returns
er

gmvportws <- globalMin.portfolio(er, covmat)
# Print the whole object
gmvportws

# Check the attributes
attributes(gmvportws)

# To see the weights of the portfolio
gmvportws$weights
# To see the class of the object
class(gmvportws)
gmvportwos <- globalMin.portfolio(er, covmat, shorts = FALSE)
# Print the object
gmvportwos

ef <- efficient.frontier(er, covmat, nport = 100,
                         alpha.min = -0.5,
                         alpha.max = 1.5,
                         shorts = TRUE)
attributes(ef)
plot(ef, plot.assets = TRUE, col = "blue", pch = 16)

#Part V. Exercise
getSymbols(c("ALFAA.MX","BIMBOA.MX"),
           from = "2015-01-01", to = "2017-12-31",
           periodicity = "monthly",
           src = "yahoo")
# Merge
data<- merge(ALFAA.MX,BIMBOA.MX)
# Remove original objects
rm(ALFAA.MX,BIMBOA.MX)
# Compounded returns calculation
returns1 <- diff(log(data))
# We can also use the function Return.Calculate from the PerformanceAnalytics to do the same we did:
# returns.zoo <-Return.Calculate(portfolio_bymth.zoo,method="log")

returns1 <- as.data.frame(returns1) %>% # Copy `returns.zoo` as data frame
  na.omit() %>% # remove the NAs
  select(contains("Adjusted")) #
colnames(returns1)<-c("rAlfa","rBimbo")
head(returns1)

# Variance-covariance matrix
#We calculate the var-covar
covmat <- var(returns1)
# Vector of expected returns
er <- exp(apply(returns1, 2, mean)) -1
er
wa<-seq(from=0, to=1,by=0.1)
wb<-1-wa
w<-rbind(wa,wb)
ERP<-t(w)%*%er
ERP
VARP<-t(w)%*%covmat%*%w
VARP<-diag(VARP)
VARP
RISKP <-sqrt(VARP)
RISKP
ERP
class(ERP)
class(RISKP)
plot(RISKP,ERP, main="Portolio Risk vs Return")



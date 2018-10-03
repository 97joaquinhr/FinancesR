factorialLoop<-function(x){
  r=1
  for(i in 1:x){
    r=r*i
  }
  return(r)
}
FR<-function(x){
  if(x==1||x==0)
    return(1)
  else
    return (x*FR(x-1))
}
library(quantmod)
##workshop7
#Writing  a function to run the market model
#Input: 1) a vector of stock cc returns, 2) a vector of market ret
#output: a vector with the following results: beta0, sd(beta0), p-value(beta0),
#beta1,sd(beta1),p-value(beta1),observations
#
#process
#1. Calculate betas:
# 1.1 Run the regression model with lm function
# 1.2 Get where to find the betas, std errors and p-values
# 1.3 get the valid non-missing observations
#2 Create a vector for the results
#3 fill-out the vector
#4 return the vector
getSymbols(c("AAPL","^GSPC"),
           from = "2014-01-01", to = "2017-12-31",
           periodicity = "monthly",
           src = "yahoo")
adjprices=merge(Ad(AAPL),Ad(GSPC))
returns=diff(log(as.zoo((adjprices))))
mktModel<-function(stockret,marketret){
  m=lm(stockret ~ marketret)
  s=summary(m)
  beta0<-s$coefficientes[1,1]
  beta1<-s$coefficientes[2,1]
  #todavia falta
}
modelo1=mktModel(returns$AAPL.Adjusted,returns$GSPC.Adjusted)
modelo1$coefficients[2,1]

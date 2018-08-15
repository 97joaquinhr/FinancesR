# # workshop 2
# Lists
# I create 2 vectors
v1=c(1,2,3)
v2=c(90,95,100)

matrix = cbind(v1,v2)
class(matrix)

# I create a data frame from the matrix 
#df stands for data frame
grades.df= as.data.frame(matrix)
#adding a column
grades.df = cbind(grades.df,c("Pass","Fail","Pass"))
colnames(grades.df)=c("Student","Grade","Status")
#I am renaming the status column  values
grades.df$Status=c("good","very good","excellent")

list1=list(matrix,grades.df,v1)
list1
#We use 2 inside the brackets because `grades.df` is the second element inside the list
list1Element2 <- list1[2]
list1Element2
#it is not a data.frame any more
class(list1Element2)
length(list1Element2)
#you can extract as a data.frame
list1Element2.df <- as.data.frame(list1[2])
class(list1Element2.df)
length(list1Element2.df)

# Remove object list1Element2.df
rm(list1Element2.df)
# Crete the object list1Element2.df again but using a diffent way to extract from the list
list1Element2.df <- list1[[2]]
class(list1Element2.df)
length(list1Element2.df)

names(list1) <- c("MyMatrix", "TheGradesDataFrame", "TheVector")
list1$MyMatrix

Arrests.df=USArrests
class(Arrests.df)
head(Arrests.df) #show the first 6 rows
tail(Arrests.df,10)
summary(Arrests.df)#show the last 10 rows

Arrests.df$Murder > 7.788

# Subset the following rows and columns from the arrests dataframe as follow:
# Rows: defined by `arrests$Murder > 7.788`
# Columns: all (empty after comma)
Arrests.df[Arrests.df$Murder > 7.788,]

# Also we can make reference to the mean of Murders directly using the function mean:
Arrests.df[Arrests.df$Murder > mean(Arrests.df$Murder),]

dim(Arrests.df[Arrests.df$Murder > mean(Arrests.df$Murder),])

#We can also save the mean value in a new variable to make the code easier to read and structure:
meanMurder <- mean(Arrests.df$Murder)
dim(Arrests.df[Arrests.df$Murder > meanMurder,])[1]

Arrests.df[Arrests.df$Murder > meanMurder & Arrests.df$Assault > 300,]
Arrests.df[Arrests.df$Murder < meanMurder & Arrests.df$Assault < 50,]

?subset
subset(Arrests.df, Murder < meanMurder & Assault < 50)

##Conditionals
#simple condition
grade <- 70
if(grade > 69){
  "You have passed this course. Well done!"
}
#if and else if
gradePartial1 <- 80
gradePartial2 <- 60
gradeFinalExam <- 100
FinalGrade <- (gradePartial1*0.25 + gradePartial1*0.25 + gradeFinalExam*0.5)
if(FinalGrade > 90){
  "You did an Excellent job!"
} else if(FinalGrade > 69){
  "You have passed this course. Well done."
} else if(FinalGrade > 0){
  "Sorry you have failed the course."
}

#if, else if, and else 
gradePartial1 <- -70
gradePartial2 <- 60
gradeFinalExam <- -60
FinalGrade <- (gradePartial1*0.25 + gradePartial1*0.25 + gradeFinalExam*0.5)
if(FinalGrade > 90){
  "You did awesome!"
} else if(FinalGrade > 69){
  "You have passed this course. Well done."
} else if(FinalGrade > 0){
  "Sorry you have failed the course."
} else {
  "I have not graded your exams"
}

#%in% checks whether a value exists inside a vector
# Both elements in the first vector appears in the second vector
c(1,2) %in% c(6,4,8,3,2,1)

# Only the last two elements of the first verctor appear in the second
c(6,4,8,3,2,1) %in% c(1,2)

## For Loop
students<-c("Pedro","Laura","Bryan")
for(name in students){
  ##Instead of name you can write any variable just change it inside the loop
  print(paste("Hi, my name is",name))
}

#nested loops
numbers <- NULL
for(i in c(2,1,0)){
  for(e in seq(9,0)){
    #The seq is a function that returns a sequence of numbers in a vector.
    x <- as.numeric(paste(i, e, sep = ""))
    # We write the next condition because we only want numbers equal or less than 20,
    # and the loop creates numbers until 29
    if(x <= 20){
      numbers<-c(numbers,x)
    }
  }
}
numbers

install.packages("quantmod")
library(quantmod)
tickers=c("AAPL","JPM","GE")
for(i in tickers){
  if(i %in% c("AAPL","JPM","GE")){
    getSymbols(i)
    print(paste("the prices of the ticker",i,"have been downloaded"))
  }
}

tickers <- c("AAPL","GM","INTGSTMXM193N","GE","JPM")
for(i in tickers){
  if(i %in% c("AAPL","GE")){
    getSymbols(i,src = "yahoo")
    print(paste("the prices of the ticker",i,"have been downloaded from yahoo"))
  }
  else if(i=="INTGSTMXM193N"){
    getSymbols(i,src = "FRED")
    #Note that the source for the FED is called FRED
    print(paste("the data of the ticker",i,"have been downloaded from the FED (Federal Reserve Bank of the US) "))
  }
}

tickers <- c("AAPL","GM","INTGSTMXM193N","GE","JPM")
for(i in tickers){
  if(i %in% c("AAPL","GE")){
    getSymbols(i,src = "yahoo")
    print(paste("the prices of the ticker",i,"have been downloaded from yahoo"))
  }
  else if(i=="INTGSTMXM193N"){
    getSymbols(i,src = "FRED")
    print(paste("the data of the ticker",i,"have been downloaded from the FED (Federal Reserve Bank of the US) "))
  }
  else {
    print(paste("The ticker",i,"has not been downloaded"))
  }
}

#while loop
APR<-0.10
# I define Annual Percentage Rate to be equal to 10%
INV<-100
# Initial investment equal to $100
MULTIPLE<-2
# Multiple = 2 to check when the investment double
BALANCE<-INV
# I start assigning the balance equal to the initial investment
year<-0
# I start with year equal to zero
while (BALANCE<MULTIPLE*INV) {
  # the exit condition means that while the balance is less than the initial investment
  # multiplied by the multiple, then continue with the iterations of the loop
  year<-year+1
  # I increase the value of year by 1
  BALANCE<-BALANCE*(1+APR)
  # I multiply the current balance times the growth factor (1+APR) using to the
  # Annual Percentage Rate
}
print(paste(
  "To multiply your investment times ", MULTIPLE, "you need ", year, " years."))
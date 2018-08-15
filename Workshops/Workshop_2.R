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

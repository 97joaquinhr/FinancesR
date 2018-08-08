## Joaquin Herrera A01207504
# I can do calculations:
4+5
x<-5
x
# tambien puede ser declarado como x=10
x<-10
z<-2*x+20
z
## vectors
y<-c(1,2,3,4,5)
y
#y<-c(10,11,12,13,14,15,16,17,18,19,20)
#declaras un arreglo del 10 al 20, tendra 11 elementos
y<-10:20
y
x<-30:40
# c() means container
z<-c(y,x)
w<-x-y
a=5
w<-x-a

students<-c("André","Daniel","Enrique","Eduardo","Denisse","Guliana")

#integer vector
x=c(1L,2L,5L,10L)

status=c(T,F,TRUE,FALSE)
#crea arreglo con elementos del 100 al 200 con saltos de 5 en 5
vector=seq(100,200,5)

#puedo acceder a varias localidades de un arreglo a la vez con la ayuda de otro arreglo dentro del indice
vector[c(1,5,10)]

## Matrix

#del 1 al 10, 2 filas, 5 columnas, esto llena las filas primero y luego pasa a la siguiente columna
# a menos declare byrow como true
m1=matrix(1:10,nrow = 2,ncol = 5,byrow = T)
View(m1)

#merge vector into a matrix
v1=c(1,2,3)
v2=10:12
#column bind
matrix1=cbind(v1,v2)
View(matrix1)
#row bind
m2=rbind(v1,v2)
View(m2)

#displayed as rows times columns
dim(matrix1)
dim(m2)

#[r,c] access 
x=m2[1,2]
x

#create a vector from a matrix
c2=matrix1[,2]
c2

r2=matrix1[2,]
r2

## Data frames
x <- data.frame(Student = c("Paco","Raul","Beto"), Grade = c(9, 5, 7))
x
dim(x)

#the mean of the grades is:
mean(x[,2])
#accedes a un atributo del objeto x, en java seria: x.Grade
mean(x$Grade)

#I can check attributes
attributes(x)
#or the class
class(x)
names(x)
#renombrar
rownames(x)=c("r1","r2","r3")
names(x)=c("StudentName","GradeP1")

my.matrix <- matrix(1:4, nrow = 2, ncol = 2)
my.df <- as.data.frame(my.matrix)
class(my.df)

#create new col
x$Fail=c(T,F,T)

#rename just one column
colnames(x)[2]="Grades"

#I can install R packages from users
#I an install the package quantmod, which is used for data collection
# and financial analysis:
install.packages("quantmod")
#Once the package is installed:
#library(quantmod)
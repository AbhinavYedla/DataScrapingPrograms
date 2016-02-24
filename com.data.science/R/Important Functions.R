a<-as.Date("2016-01-31") #for date assign date to variable
is.numeric(a) #Test for numeric
nchar(a) #Count chars
v1<-c(10,2,3,4,5) #vector list 
v1<- 1:5 #assign 1 to 5 values to v1

v1[5]# 5 th element
v1[1:6]# first 6 elements
length(v1) # length of vector
v1< 5 #test entire vector aganist 5

any(v1<5) # any number is less than 5 then true
all(v1<5) # if all of the numbers are less than 5 then true

dataFrameVaraible <- data.frame(id,age,name) # create a data Frame i.e data in the form of row and colums
nrow(dataFrameVaraible) # dataFrame row 
ncol(dataFrameVaraible)# dataFrame column
names(dataFrame) # name of the column in data frame
head(dataFrame) # first 6
tail(dataFrame)
id <- 1:15
age <- c(18,13,66,32,3,43,54,656,87,323,7,2,9,34,65)
name <-c ("bucky","tom","bobby","henry","emily","baby","hannah","joe","cathy","sandY","lesley","emma","ann","old dan","eric")

dataFrame <- data.frame(id,age,name)
dataFrame
nrow(dataFrame)
ncol(dataFrame)
names(dataFrame)
head(dataFrame)
tail(dataFrame)
dataFrame[2]
dataFrame$age

dataFrame[1:9, 3] # 1 to 9 row 3rd column

class(dataFrame[,3]) # get type of column

listVar<-list(11,"abhinav",c(1:10),dataFrame) # can combine different data types in list
names(listVar)<-c("id","name1","value","data") # set names to listVar columns

listVar[["data"]][3] # get 3rd column in data frame
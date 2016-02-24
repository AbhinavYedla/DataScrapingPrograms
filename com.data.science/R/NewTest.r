library(RCurl)
library(stringr)
library(plyr)
library(RJSONIO)
library(data.table)

json_data <-
  fromJSON(
    "https://www.devex.com/api/public/search/jobs?filter%5Bstatus%5D=active&&page%5Bnumber%5D=1&page%5Bsize%5D=5",method =
      'C',nullValue = NA
  )



json_data <- sapply(json_data, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})
json_data
rbindlist(json_data, fill=TRUE,use.names=TRUE)

columnNames <- rownames(json_data)

n <- length(columnNames)

columnNames


finalData <- data.frame(column_name = columnNames,json_data)
class(finalData)

columnNames <- unique(rownames(json_data))

i <- integer(1)




line <- columnNames[1]

for (i in 2:length(columnNames)) {
  line <- paste(line,columnNames[i],sep = ",")
}

write.table(
  line, file = "data-appended.csv", sep = ",",
  row.names = FALSE,col.names = FALSE,append = FALSE,quote = FALSE
)



line <- as.character(finalData[1,2])
prev <- line
class(line)
b<-1
d<-0
c<-1


for (i in 2:n) {
  
  if (identical(as.character(finalData[i,1]),as.character(finalData[1,1]))) {
    write.table(
      line, file = "data-appended.csv", sep = ",",
      row.names = FALSE,col.names = FALSE,append = TRUE,quote = FALSE
    )
    
    line <- NA
    prev <- NA
    
    c<-1
  }
  
 # while (!identical(lapply(finalData[i,1], as.character),list(columnNames[c]))) {
    
 #   c<-c+1
  #  if(c>length(columnNames)){
    #  c<-1
    #  d<-1
   # }
    #if(d&&c>b){
     # c<-b
    #  line<-paste(line,"No Data",spe=",")
     # d<-0
      #break
    #}
  #}
  
  
  if (identical(as.character(finalData[i,1], as.character),prev)) {
    finalData[i,2]<- gsub(",", "---", finalData[i,2])
    line <- paste(line,"---",finalData[i,2],sep = " ")
  }else{
    if (is.character(line)) {
      finalData[i,2]<-gsub(",", "---", finalData[i,2])
      line <- paste(line,finalData[i,2],sep = ",")
    }
    else{
      finalData[i,2]<-gsub(",", "---", finalData[i,2])
      line <- as.character(finalData[i,2])
    }
  }
  b<-c
}
write.table(
  line, file = "data-appended.csv", sep = ",",
  row.names = FALSE,col.names = FALSE,append = TRUE,quote = FALSE
)

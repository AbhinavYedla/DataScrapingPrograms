library(RCurl)
library(stringr)
library(plyr)
library(RJSONIO)
library(data.table)

term <- "Research"
secondterm<-""
json_data <-
  fromJSON(
    paste(
      "https://www.devex.com/api/public/search/jobs?filter%5Bkeywords%5D%5B%5D=",term,"%20",secondterm,"&filter%5Bstatus%5D=active&&page%5Bnumber%5D=1&page%5Bsize%5D=2000",sep =
        ""
    ),method =
      'C'
  )
totalRows<- as.numeric(json_data[1])


if(totalRows!=0){
json_data <- sapply(json_data["data"], function(x) {
  x[sapply(x, is.null)] <- "No Data"
  unlist(x)
})


columnNames <- rownames(json_data)

n <- length(columnNames)



finalData <- data.frame(column_name = columnNames,json_data)



columnNames <- unique(rownames(json_data))


json_data <- data.frame()

i <- integer(1)

line <- columnNames[1]

for (i in 2:length(columnNames)) {
  line <- paste(line,columnNames[i],sep = ",")
  
}
term <- paste(term," ",secondterm,".","csv",sep ="")

write.table(
  line, file = term, sep = ",",
  row.names = FALSE,col.names = FALSE,append = FALSE,quote = FALSE
)

line <- as.character(finalData[1,2])

testList <- list()
myline <- character()


testList[["id"]] <- as.character(finalData[1,2])

for (i in 2:n) {
  if (identical(as.character(finalData[i,1]),as.character(finalData[1,1]))) {
    for (k in 1:length(columnNames)) {
      a <- as.character(testList[[columnNames[k]]])
      
      if (length(a) == 0L) {
        a <- " "
      }
      if (length(myline) == 0L)
        myline <- a
      else
        myline <- paste(myline,a,sep = ",")
      
    }
    testList <- list()
    write.table(
      myline, file = term, sep = ",",
      row.names = FALSE,col.names = FALSE,append = TRUE,quote = FALSE
    )
    myline <- character()
    
  }
  
  
  temp <- finalData[i,2]
  temp <- gsub(",","---",temp)
  testList[[as.character(finalData[i,1])]] <- temp
  
  
  
  
}
write.table(
  myline, file = term, sep = ",",
  row.names = FALSE,col.names = FALSE,append = TRUE,quote = FALSE
)
}

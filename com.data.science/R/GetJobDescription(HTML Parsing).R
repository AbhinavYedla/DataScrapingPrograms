# load packages
library(RCurl)
library(XML)

#Vector of terms
term <- c(
  "Survey",
  "Impact assessment",
  "Data analytics",
  "Statistics",
  "Research",
  "Evaluation"
)


#Get the data from csv files and store it in Data frame
for (i in 1:6) {
  #Read only the slug_and_id column
  data <- read.csv(
    paste(term[i],"csv",sep = "."), quote = "",
    row.names = NULL,
    stringsAsFactors = FALSE
  )[,c("name","slug_and_id")]
  
  
  df <-
    data.frame(JobName = data[,1], SlugID = data[,2],stringsAsFactors = FALSE)
  
  fileName <- paste(term[i],"JobDescription",".txt",sep = "")
  
  
  
  for (j in 1:nrow(df)) {
    # download html
    url <-
      getURL(
        paste("https://www.devex.com/jobs/",df[j,2],sep = ""), followlocation = TRUE,.encoding = 'UTF-8'
      )
    
    # parse html
    doc = htmlParse(url, asText = TRUE,encoding = 'UTF-8')
    
    divClass <- "//div[@data-partial='job-description']//text()"
    tempText <- xpathSApply(doc,divClass,xmlValue)
    
    #tempText <- gsub("[\r\n]"," ",tempText)
    
    tempText <- paste(tempText,collapse = " ")
    
    
    
    tempText <-
      paste("TERM: ", term[i]," ::: ","JOB NAME: ", df[j,1], " ::: ","DESCRIPTION: ",tempText)
    
    
    write(tempText,file = fileName,append = TRUE)
  }
  
  
  
}

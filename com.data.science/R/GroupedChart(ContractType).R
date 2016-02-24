library(plyr)  # For count
library(ggplot2) # For Bar Graph
library(googleVis)

#Vector of terms
term <- c(
  "Evaluation",
  "Research",
  "Statistics",
  "Impact assessment",
  "Survey",
  "Data analytics"
)


#Final Data Frame
completeData <- data.frame()


#Get the data from csv files and store it in Data frame
for (i in 1:6) {
  #Read only the career_level.name column
  data <- read.csv(
    paste(term[i],"csv",sep = "."), quote = "",
    row.names = NULL,
    stringsAsFactors = FALSE
  )[,"contract_length.name"]
  
  #Get Levels and frequency
  colValues <- unclass(count(data))
  
  #Temp Data Frame
  df <-
    data.frame(
      Term = term[i],ContractType = colValues$x, Frequency = colValues$freq
    )
  
  
  Pie <- gvisPieChart(df[,2:3],options = list(
    width = 1100, height = 630,title = term[i]
  ))
  
  plot(Pie)
  print(Pie, file = paste(term[i],"_Pie",".html",sep = ""))
  #Merge temp data frame to main data frame
  if (i == 1) {
    #To Tidy the data
    df <- df[df$ContractType != "2" ,]
    df <- df[df$ContractType != "" ,]
    completeData <- df
  }
  else{
    completeData <- rbind(completeData,df)
  }
}

#Remove unwanted data
#completeData<-completeData[completeData$ContractType != "" ,]

#Plot the graph
#ggplot(completeData,  aes(x = factor(ContractType), Frequency, fill = Term)) +
# geom_bar(stat = "identity", position = "dodge") +
#scale_fill_brewer(palette = "Set1")


ggplot(data = completeData) + geom_bar(stat = "identity") +
  aes(
    x = reorder(ContractType,-Frequency,sum),y = Frequency,label = Frequency,fill =
      Term
  ) +
  theme(plot.title = element_text(
    family = "Trebuchet MS", color = "#666666", face = "bold", size = 14, hjust =
      0
  )) +
  theme(axis.title = element_text(
    family = "Trebuchet MS", color = "#666666", face = "bold", size = 14
  )) + labs(x = "Contract Type",
            y = "Number of Jobs",
            title = "Total Number of Jobs based on the Term and Contract Type")
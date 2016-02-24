library(plyr)  # For count
library(ggplot2) # For Bar Graph

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
  )[,"career_level.name"]
  
  #Get Levels and frequency
  colValues <- unclass(count(data))
  
  #Temp Data Frame
  df <-
    data.frame(Term = term[i],Level = colValues$x, Frequency = colValues$freq)
  
  
  df <- df[df$Level != "Published" ,]
  
  Pie <- gvisPieChart(df[,2:3],options = list(
    width = 1100, height = 630,title = term[i]
  ))
  
  plot(Pie)
  print(Pie, file = paste(term[i],"_Pie",".html",sep = ""))
  #Merge temp data frame to main data frame
  completeData <- rbind(completeData,df)
  
}

#Remove unwanted data
completeData <- completeData[completeData$Level != "" ,]

#Plot the graph
#ggplot(completeData,  aes(x = factor(Level), Frequency, fill = Term)) +
#geom_bar(stat = "identity", position = "dodge") +
#  scale_fill_brewer(palette = "Set1")


ggplot(data = completeData) + geom_bar(stat = "identity") +
  aes(
    x = reorder(Level,-Frequency,sum),y = Frequency,label = Frequency,fill =
      Term
  ) +
theme(plot.title = element_text(
  family = "Trebuchet MS", color = "#666666", face = "bold", size = 14, hjust =
    0
)) +
  theme(axis.title = element_text(
    family = "Trebuchet MS", color = "#666666", face = "bold", size = 14
  )) +  labs(x = "Job Level",
              y = "Number of Jobs",
              title = "Total Number of Jobs based on the Term and Job Level")
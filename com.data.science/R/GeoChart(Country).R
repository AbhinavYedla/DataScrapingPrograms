library(plyr)  # For count
library(ggplot2) # For Bar Graph
library(googleVis)
installed.packages("googleVis")
#Vector of terms
term <- c(
  "Evaluation",
  "Survey",
  "Impact assessment",
  "Data analytics",
  "Statistics",
  "Research"
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
  )[,c("job_locations.location.name","job_locations.location.countries.name")]
  
  #Temp Data Frame
  df <-
    data.frame(Term = term[i],Location = data$job_locations.location.name)
  #Remove unwanted data
  df <- df[df$Location != "No Data",]
  
  df2 <-
    data.frame(Term = term[i],Location = data$job_locations.location.countries.name)
  #Remove unwanted data
  df2 <- df2[df2$Location != "No Data",]
  
  #Merge temp data frame to main data frame
  completeData <- rbind(completeData,df,df2)
  
  
}




#Get Levels and frequency
colValues <- unclass(count(completeData$Location))


df <- data.frame(Location = colValues$x,Frequency = colValues$freq)

df <- df[df$Location != "United States" ,]
df <- df[df$Location != "Worldwide" ,]

#Plot the graph
Geo = gvisGeoChart(
  df, locationvar = "Location",
  colorvar = "Frequency",
  options = list(
    projection = "kavrayskiy-vii",width = 1100, height = 630,title = 'Total Jobs Per Term',
    colorAxis="{values:[0,25,50,80],
                                   colors:[\'red', \'pink', \'orange',\'green']}")
)

print(Geo, file = "JobsvsLocation_Geo.html")

plot(Geo)

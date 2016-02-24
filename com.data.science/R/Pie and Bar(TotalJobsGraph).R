library(RJSONIO)
library(googleVis)

term <- c("Survey",
          "Evaluation",
          "Impact assessment",
          "Data analytics",
          "Statistics",
          "Interviewer",
          "Research")

secondterm<-""
json_data <- data.frame()
totalRows<-numeric()

for(i in 1:7){
  

json_data <-
  fromJSON(
    paste(
      "https://www.devex.com/api/public/search/jobs?filter%5Bkeywords%5D%5B%5D=",term[i],"%20",secondterm,"&filter%5Bstatus%5D=active&&page%5Bnumber%5D=1&page%5Bsize%5D=1",sep =
        ""
    ),method =
      'C'
  )


totalRows[i]<- c(as.numeric(json_data[1]))


}
bar_data<-data.frame(term,totalRows)

sort_bar_data <-bar_data[with(bar_data, order(-totalRows)), ]
#dev.off()
names(totalRows)<-term
color<-c("cadetblue2","aquamarine","goldenrod2","coral","deeppink3","snow","slategrey")
barpos<-barplot(totalRows,main = "Total Jobs per term",col =color)

text(barpos,totalRows,labels=totalRows,cex.lab = 1.5)




Column <- gvisColumnChart(sort_bar_data,options=list(colors="[ '#1A8763', '#1A8760','#871B47','#5C3291','#1A8763','#1A8762','#5C3292']",
                                                width=1100, height=630,title='Total Jobs Per Term'))
plot(Column)
print(Column, file="JobsvsTerm_Bar.html")

Pie <- gvisPieChart(sort_bar_data,options=list(
                                          width=1100, height=630,title='Total Jobs Per Term'))
print(Column, file="JobsvsTerm_Pie.html")
plot(Pie)
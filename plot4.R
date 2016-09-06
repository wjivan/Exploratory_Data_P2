#Clear and set directory
rm(list=ls())
setwd("./Project")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")
unzip("exdata%2Fdata%2FNEI_data.zip")
dat<-readRDS("summarySCC_PM25.rds")
classification<-readRDS("Source_Classification_Code.rds")

#Subsetting classification file
cols<-c(1,3,4,7,8,9,10)
class1<-classification[,cols]

#Merge two files together
datmerge<-merge(dat,class1)
str(datmerge)

#Subsetting merged file
sub4<-datmerge[which(grepl(" ([Cc]oal) ",datmerge$SCC.Level.Three)|grepl(" ([Cc]oal) ",datmerge$SCC.Level.Four)),]
plot4<-aggregate(sub4$Emissions,by=list(year=sub4$year),FUN=sum)
names(plot4)<-c("Year","Emission")
plot4$Emission<-plot4$Emission/1000


#Print
png("plot4.png")
barplot(plot4$Emission,names.arg = plot4$Year,col="darkblue",xlab="Year",ylab="Total Emission in kilotonnes",main="Emissions from coal combustion related sources")
dev.off()

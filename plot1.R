#Clear and set directory
rm(list=ls())
setwd("./Project")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")
unzip("exdata%2Fdata%2FNEI_data.zip")
dat<-readRDS("summarySCC_PM25.rds")
classification<-readRDS("Source_Classification_Code.rds")

#Aggregate
plot1<-aggregate(dat$Emissions,by=list(yr=dat$year),FUN=sum)
names(plot1)<-c("Year","TotalEmissions")
plot1$TotalEmissions<-plot1$TotalEmissions/1000000

#Print
png("plot1.png")
barplot(plot1$TotalEmissions,names.arg = plot1$Year,col="darkblue", xlab="Years",ylab="Total Emissions in millions of tonnes")
dev.off()

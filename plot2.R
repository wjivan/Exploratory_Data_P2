#Clear and set directory
rm(list=ls())
setwd("./Project")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")
unzip("exdata%2Fdata%2FNEI_data.zip")
dat<-readRDS("summarySCC_PM25.rds")
classification<-readRDS("Source_Classification_Code.rds")

#Subsetting
sub2<-dat[which(dat$fips=="24510"),]

#Aggregate
plot2<-aggregate(sub2$Emissions,by=list(yr=sub2$year),FUN=sum)
names(plot2)<-c("Year","TotalEmissions")
plot2$TotalEmissions<-plot2$TotalEmissions/1000000

#Print
png("plot2.png")
barplot(plot2$TotalEmissions,names.arg = plot2$Year,col="darkblue", xlab="Years",ylab="Total Emissions in millions of tonnes")
dev.off()

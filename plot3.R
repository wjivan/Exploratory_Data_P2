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
plot3<-aggregate(sub2$Emissions,by=list(year=sub2$year,type=sub2$type),sum)
names(plot3)<-c("year","type","emission")
library(ggplot2)

#Print
png("plot3.png")
qplot(year,emission,data=plot3,facets=.~type)
dev.off()

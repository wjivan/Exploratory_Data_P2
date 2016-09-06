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
sub5<-datmerge[which(datmerge$type=="ON-ROAD" & datmerge$fips=="24510"),]
plot5<-aggregate(sub5$Emissions,by=list(year=sub5$year),sum)
names(plot5)<-c("Year","Emission")


#Print
png("plot5.png")
barplot(plot5$Emission,names.arg = plot5$Year,col="darkblue",xlab="Year",ylab="Total Emission in kilotonnes",main="Emissions from motor vehicles on the road")
dev.off()

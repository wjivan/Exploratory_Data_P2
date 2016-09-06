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
sub6<-datmerge[which(datmerge$fips=="24510" | datmerge$fips=="06037"),]
sub6<-sub6[which(sub6$type=="ON-ROAD"),]
plot6<-aggregate(sub6$Emissions,by=list(sub6$year,sub6$fips),sum)
names(plot6)<-c("Year","County","Emission")


#Print
png("plot6.png")
g<-ggplot(data=plot6,aes(factor(Year), Emission))+
        geom_bar(stat="identity")+
        facet_grid(.~County)+
        xlab("Year")+
        ylab("Total Emissions")+
        ggtitle("Total Emission from motor vehicles in Baltimore vs LA")
print(g)
dev.off()

rm(list=ls())
setwd("./Project")

unzip("exdata%2Fdata%2FNEI_data.zip")
dat<-readRDS("summarySCC_PM25.rds")
classification<-readRDS("Source_Classification_Code.rds")

names(dat)
str(dat)
str(classification)

plot1<-aggregate(dat$Emissions,by=list(yr=dat$year),FUN=sum)
names(plot1)<-c("Year","TotalEmissions")
plot1$TotalEmissions<-plot1$TotalEmissions/1000000
plot(plot1$Year,plot1$TotalEmissions,type="h",lwd=4,xlab="Year",ylab="Total Emissions in Millions of Tons")
barplot(plot1$TotalEmissions,names.arg = plot1$Year,col="darkblue", xlab="Years",ylab="Total Emissions in millions of tonnes")

sub2<-dat[which(dat$fips=="24510"),]
plot2<-aggregate(sub2$Emissions,by=list(yr=sub2$year),FUN=sum)
names(plot2)<-c("Year","TotalEmissions")
plot2$TotalEmissions<-plot2$TotalEmissions/1000000
plot(plot2$Year,plot2$TotalEmissions,type="h",lwd=4,xlab="Year",ylab="Total Emissions in Millions of Tons")
barplot(plot2$TotalEmissions,names.arg = plot2$Year,col="darkblue", xlab="Years",ylab="Total Emissions in millions of tonnes")

plot3<-aggregate(sub2$Emissions,by=list(year=sub2$year,type=sub2$type),sum)
names(plot3)<-c("year","type","emission")
library(ggplot2)
qplot(year,emission,data=plot3,facets=.~type)

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
str(classification)
names(classification)
cols<-c(1,3,4,7,8,9,10)
class1<-classification[,cols]
datmerge<-merge(dat,class1)
str(datmerge)

sub4<-datmerge[which(grepl(" ([Cc]oal) ",datmerge$SCC.Level.Three)|grepl(" ([Cc]oal) ",datmerge$SCC.Level.Four)),]
plot4<-aggregate(sub4$Emissions,by=list(year=sub4$year),FUN=sum)
names(plot4)<-c("Year","Emission")
plot4$Emission<-plot4$Emission/1000
barplot(plot4$Emission,names.arg = plot4$Year,col="darkblue",xlab="Year",ylab="Total Emission in kilotonnes",main="Emissions from coal combustion related sources")

#sub5<-datmerge[which(grepl(" ([Mm]otor) | ([Vv]ehicle) ",datmerge$SCC.Level.Three)|grepl(" ([Mm]otor) | ([Vv]ehicle) ",datmerge$Short.Name)),]
#sub5<-sub5[which(sub5$fips=="24510"),]
datmerge$type<-as.factor(datmerge$type)
levels(datmerge$type)
sub5<-datmerge[which(datmerge$type=="ON-ROAD" & datmerge$fips=="24510"),]
plot5<-aggregate(sub5$Emissions,by=list(year=sub5$year),sum)
names(plot5)<-c("Year","Emission")
barplot(plot5$Emission,names.arg = plot5$Year,col="darkblue",xlab="Year",ylab="Total Emission in kilotonnes",main="Emissions from motor vehicles on the road")

sub6<-datmerge[which(datmerge$fips=="24510" | datmerge$fips=="06037"),]
sub6<-sub6[which(sub6$type=="ON-ROAD"),]
plot6<-aggregate(sub6$Emissions,by=list(sub6$year,sub6$fips),sum)
names(plot6)<-c("Year","County","Emission")
g<-ggplot(data=plot6,aes(factor(Year), Emission))+
        geom_bar(stat="identity")+
        facet_grid(.~County)+
        xlab("Year")+
        ylab("Total Emissions")+
        ggtitle("Total Emission from motor vehicles in Baltimore vs LA")
print(g)

setwd("C:/Users/mdepweg/Documents/coursera/Exploratory Data Analysis/Emissions")
library(ggplot2)
library(plyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merge <- merge(NEI, SCC, by.x="SCC", by.y = "SCC", all="TRUE")
head(merge)
coal <- merge[grepl("Coal", merge$Short.Name, fixed=TRUE),]

sumCoal <- aggregate(coal$Emissions ~ coal$year, FUN=sum)
#head(sumTable)
colnames(sumCoal)<- c("year", "Emissions")

png(filename="plot4.png", width = 480, height = 480, units = "px")
plot(sumCoal$year, as.numeric(sumCoal$Emissions), type="l", xlab="Year", ylab="Emissions from Coal Sources", main="Emissions from PM2.5 by Year")
dev.off()

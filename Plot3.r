setwd("C:/Users/mdepweg/Documents/coursera/Exploratory Data Analysis/Emissions")
library(ggplot2)
library(plyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merge <- merge(NEI, SCC, by.x="SCC", by.y = "SCC", all="TRUE")

Baltimore <- merge[merge$fips == "24510",]

# create factors with value labels 
Baltimore$type2 <- as.factor(Baltimore$type)

BaltimoreSummary <- ddply(Baltimore, .(year,type), summarize, Total = sum(Emissions))

png(filename="plot3.png", width = 480, height = 480, units = "px")
ggplot(BaltimoreSummary, aes(x=year, y=Total, group=type, color=type))+geom_line()+geom_point()+
  labs(x="Year", y="Total Emissions from All Sources", title="Baltimore City, MD Emissions by Year and Type")
dev.off()

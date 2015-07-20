setwd("C:/Users/mdepweg/Documents/coursera/Exploratory Data Analysis/Emissions")
library(ggplot2)
library(plyr)


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merge <- merge(NEI, SCC, by.x="SCC", by.y = "SCC", all="TRUE")

Cities <- merge[which(merge$fips == "24510"| merge$fips=="06037"),]
head(Cities)
Cities$City<-revalue(Cities$fips, c("24510"="Baltimore City", "06037"="Los Angeles"))
CitiesMobile <- Cities[Cities$type=="ON-ROAD",]

CitiesSummary <- ddply(CitiesMobile, .(year,City), summarize, Total = sum(Emissions))

png(filename="plot5.png", width = 480, height = 480, units = "px")
ggplot(CitiesSummary2, aes(x=year, y=Total, color=City))+geom_line()+geom_point()+
  labs(x="Year", y="Total Emissions from Mobile Sources", title="Baltimore City, MD Emissions by Year and Type")
dev.off()
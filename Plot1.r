setwd("C:/Users/mdepweg/Documents/coursera/Exploratory Data Analysis/Emissions")


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merge <- merge(NEI, SCC, by.x="SCC", by.y = "SCC", all="TRUE")
#head(merge)
#head(NEI)
#unique(NEI$year)

sumTable <- aggregate(merge$Emissions ~ merge$year, FUN=sum)
#head(sumTable)
colnames(sumTable)<- c("year", "Emissions")

png(filename="plot1.png", width = 480, height = 480, units = "px")
plot(sumTable$year, as.numeric(sumTable$Emissions), type="l", xlab="Year", ylab="Emissions from All Sources", main="Emissions from PM2.5 by Year")
dev.off()

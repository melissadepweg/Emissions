setwd("C:/Users/mdepweg/Documents/coursera/Exploratory Data Analysis/Emissions")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merge <- merge(NEI, SCC, by.x="SCC", by.y = "SCC", all="TRUE")

Baltimore <- merge[merge$fips == "24510",]
sumTable2 <- aggregate(Baltimore$Emissions ~ Baltimore$year, FUN=sum)
#head(sumTable2)
colnames(sumTable2)<- c("year", "Emissions")

png(filename="plot2.png", width = 480, height = 480, units = "px")
plot(sumTable2$year, as.numeric(sumTable2$Emissions), type="l", xlab="Year", ylab="Emissions from All Sources", main="Baltimore City, MD Emissions from PM2.5 by Year")
dev.off()
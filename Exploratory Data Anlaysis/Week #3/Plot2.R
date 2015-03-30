## Exploratory Data Analysis - Project #2 - Question #2

## Load Data - Ensure"summarySCC_PM25.rds" & "Source_Classification_Code.rds" are in your working directory
NEI = readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question #2 - Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
Year = c(1999,2002,2005,2008)
BaltimoreData = subset(NEI, fips == "24510")
Baltimore_PM2.5_emissions = tapply(BaltimoreData$Emissions, BaltimoreData$year, sum)
b2 = data.frame(Baltimore_PM2.5_emissions)
plot(Year, b2$Baltimore_PM2.5_emissions, type = "b", ylab = "Total PM2.5 emissions", main = "Total PM2.5 emissions by Year in Baltimore")
dev.copy(png, file = "plot2.png")
dev.off()

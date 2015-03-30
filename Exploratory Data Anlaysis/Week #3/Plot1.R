## Exploratory Data Analysis - Project #2 - Question #1

## Load Data - Ensure"summarySCC_PM25.rds" & "Source_Classification_Code.rds" are in your working directory
NEI = readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question #1 - Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

Year = c(1999,2002,2005,2008)
US_PM2.5_emissions = tapply(NEI$Emissions, NEI$year, sum)
c2 = data.frame(US_PM2.5_emissions)
plot(Year, c2$US_PM2.5_emissions, type = "b", ylab = "Total PM2.5 emissions", main = "Total PM2.5 emissions by Year")
dev.copy(png, file = "plot1.png")
dev.off()

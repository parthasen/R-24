## Exploratory Data Analysis - Project #2 - Question #5

## Load Data - Ensure"summarySCC_PM25.rds" & "Source_Classification_Code.rds" are in your working directory
NEI = readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question #5 - How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(ggplot2)
library(plyr)
BaltimoreData = subset(NEI, fips == "24510")
Road = grepl("Onroad", SCC$Data.Category)
SCC2 = cbind(SCC, Road)
plyr_test = join(BaltimoreData,SCC2, by = "SCC")
BalRoadData = subset(plyr_test, plyr_test$Road == TRUE)
qplot(year, Emissions, data=BalRoadData, stat="summary", fun.y="sum", geom = "line", main = "Emissions from Motor Vehicles in Baltimore by Year")
dev.copy(png, file = "plot5.png")
dev.off()

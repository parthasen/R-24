## Exploratory Data Analysis - Project #2 - Question #3

## Load Data - Ensure"summarySCC_PM25.rds" & "Source_Classification_Code.rds" are in your working directory
NEI = readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question #3 - Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?

library(ggplot2)
BaltimoreData = subset(NEI, fips == "24510")
qplot(year, Emissions, data=BaltimoreData, stat="summary", fun.y="sum", col=type, geom = "line", main = "Baltimore City Emissions by Type & Year")
dev.copy(png, file = "plot3.png")
dev.off()

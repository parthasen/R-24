## Exploratory Data Analysis - Project #2 - Question #6

## Load Data - Ensure"summarySCC_PM25.rds" & "Source_Classification_Code.rds" are in your working directory
NEI = readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question #6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County.

## Load relevant packages
library(ggplot2)
library(plyr)

## Step #1 - Extact Baltimore Motor Vehcile Dataset
BaltimoreData = subset(NEI, fips == "24510")
Road = grepl("Onroad", SCC$Data.Category)
SCC2 = cbind(SCC, Road)
plyr_test = join(BaltimoreData,SCC2, by = "SCC")
BalRoadData = subset(plyr_test, plyr_test$Road == TRUE)

## Step #2 - Extact Los Angeles Motor Vehcile Dataset
LAData = subset(NEI, fips == "06037")
plyr_test = join(LAData,SCC2, by = "SCC")
LARoadData = subset(plyr_test, plyr_test$Road == TRUE)

## Step #4 - Bind and relable Baltimore & Los Angeles Dataset
LA_vs_BAL = rbind(BalRoadData,LARoadData)
LA_vs_BAL$fips = sub("24510", "Baltimore", LA_vs_BAL$fips)
LA_vs_BAL$fips = sub("06037", "Los Angeles", LA_vs_BAL$fips)

## Step #5 - Plot and Save PNG
qplot(year, Emissions, data=LA_vs_BAL, stat="summary", fun.y="sum", geom = "line", facets = .~fips, main = "Motor Vehicle Emissions in Baltimore & Los Angeles by Year")
dev.copy(png, file = "plot6.png")
dev.off()


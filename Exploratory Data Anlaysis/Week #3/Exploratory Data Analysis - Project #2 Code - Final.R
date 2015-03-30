## Exploratory Data Analysis - Taylor Corbett - Project #2

## Loading Data
NEI = readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question #1 - Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

Year = c(1999,2002,2005,2008)
US_PM2.5_emissions = tapply(NEI$Emissions, NEI$year, sum)
c2 = data.frame(US_PM2.5_emissions)
plot(Year, c2$US_PM2.5_emissions, type = "b", ylab = "Total PM2.5 emissions", main = "Total PM2.5 emissions by Year")

## Question #2 - Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

BaltimoreData = subset(NEI, fips == "24510")
Baltimore_PM2.5_emissions = tapply(BaltimoreData$Emissions, BaltimoreData$year, sum)
b2 = data.frame(Baltimore_PM2.5_emissions)
plot(Year, b2$Baltimore_PM2.5_emissions, type = "b", ylab = "Total PM2.5 emissions", main = "Total PM2.5 emissions by Year in Baltimore")

## Question #3 - Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?

library(ggplot2)
BaltimoreData = subset(NEI, fips == "24510")
qplot(year, Emissions, data=BaltimoreData, stat="summary", fun.y="sum", facets= .~type)
######## OR ########
qplot(year, Emissions, data=BaltimoreData, stat="summary", fun.y="sum", col=type, geom = "line")


## Question #4 - Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(ggplot2)
library(plyr)
Coal = grepl("Coal", SCC$Short.Name)
SCC2 = cbind(SCC, Coal)
plyr_test = join(NEI,SCC2, by = "SCC")
coal_data = subset(plyr_test, plyr_test$Coal == TRUE)
qplot(year, Emissions, data=coal_data, stat="summary", fun.y="sum", geom = "line")


## Question #5 - How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(ggplot2)
library(plyr)
BaltimoreData = subset(NEI, fips == "24510")
Road = grepl("Onroad", SCC$Data.Category)
SCC2 = cbind(SCC, Road)
plyr_test = join(BaltimoreData,SCC2, by = "SCC")
BalRoadData = subset(plyr_test, plyr_test$Road == TRUE)
qplot(year, Emissions, data=BalRoadData, stat="summary", fun.y="sum", geom = "line")


## Question #6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County.
library(ggplot2)
library(plyr)
BaltimoreData = subset(NEI, fips == "24510")
Road = grepl("Onroad", SCC$Data.Category)
SCC2 = cbind(SCC, Road)
plyr_test = join(BaltimoreData,SCC2, by = "SCC")
BalRoadData = subset(plyr_test, plyr_test$Road == TRUE)

LAData = subset(NEI, fips == "06037")
plyr_test = join(LAData,SCC2, by = "SCC")
LARoadData = subset(plyr_test, plyr_test$Road == TRUE)

LA_vs_BAL = rbind(BalRoadData,LARoadData)
qplot(year, Emissions, data=LA_vs_BAL, stat="summary", fun.y="sum", geom = "line", facets = .~fips)





str(plyr_test)
?plyr














SCC_Coal = subset(SCC2, Coal == TRUE)
SCC_Coal2 = list(SCC_Coal$SCC)
test = match(SCC_Coal2, NEI$SCC)
Coal_Data = subset(NEI, match(SCC_Coal$SCC, NEI$SCC))

CoalData = subset(NEI, (if(grepl("Coal", SCC$Short.Name))==TRUE))

agecount <- function(age = NULL) {
  age2 <- 0:110
  txt <- paste(age,"years old", sep=" ")
  test <- (age %in% age2)
  if(test == FALSE) {
    stop("invalid cause", sep="")
  } else {
    homicides <- readLines("homicides.txt")
    tot <- length(grep(txt, homicides))
    print(tot)
  }}



coal_test = function()
  if(NEI$SCC == ) {
    NEI$Coal == TRUE
  } else {
    NEI$Coal == FALSE
  }







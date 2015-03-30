## Exploratory Data Analysis - Project #2 - Question #4

## Load Data - Ensure"summarySCC_PM25.rds" & "Source_Classification_Code.rds" are in your working directory
NEI = readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question #4 - Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(ggplot2)
library(plyr)
Coal = grepl("Coal", SCC$Short.Name)
SCC2 = cbind(SCC, Coal)
plyr_test = join(NEI,SCC2, by = "SCC")
coal_data = subset(plyr_test, plyr_test$Coal == TRUE)
qplot(year, Emissions, data=coal_data, stat="summary", fun.y="sum", geom = "line", main = "Coal Combustion Emissions in the US by Year")
dev.copy(png, file = "plot4.png")
dev.off()

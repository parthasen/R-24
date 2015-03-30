## Exploratory Data Analysis - Project #2 - Other student code

##### Student #2 ##############

## get_data.R
## Holds logic for retrieving data, if needed
get_data <- function() {
  zip <- "NEI_data.zip"
  if(!file.exists(zip)) {
    message("downloading file")
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url=url,destfile=zip,method="curl")
  } 
  
  ## Holds logic for extracting archive file
  extract_archive <- function() {
    pm25 <- "summarySCC_PM25.rds"
    scct <- "Source_Classification_Code.rds"
    if(!(file.exists(pm25) && file.exists(scct))) {
      message("unzip archive file")
      unzip(zip)
    }
  }
  extract_archive()
}

######################################################################################################
## plot1.R
source("get_data.R")

plot1 <- function() {
  get_data() ## Retrieving data 
  
  ## This first line will likely take a few seconds. Be patient!
  ## SCC data are not needed for this plot
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  agg_sums <- aggregate(Emissions ~ year,NEI, sum)
  barplot(
    agg_sums$Emissions,
    names.arg=agg_sums$year,
    col="steelblue",
    xlab="Year",
    ylab="PM2.5 Emissions"
  )
  title(main="Total PM2.5 Emissions in the United States")
  
  ## Create png file
  dev.copy(png, file="plot1.png")
  dev.off()
}

plot1()

## code for get_data.R is in the first answer.

## Plot #2
source("get_data.R")

plot2 <- function() {
  get_data() ## Retrieving data 
  
  ## This first line will likely take a few seconds. Be patient!
  ## SCC data are not needed for this plot
  NEI <- readRDS("summarySCC_PM25.rds")
  #SCC <- readRDS("Source_Classification_Code.rds")
  
  ## Subset NEI to Baltimore City
  baltimore = NEI[NEI$fips=="24510",]
  
  agg_sums <- aggregate(Emissions ~ year,baltimore, sum)
  barplot(
    agg_sums$Emissions,
    names.arg=agg_sums$year,
    col="steelblue",
    xlab="Year",
    ylab="PM2.5 Emissions"
  )
  title(main="Total PM2.5 Emissions in Baltimore City")
  
  ## Create png file
  dev.copy(png, file="plot2.png")
  dev.off()
}

plot2()

### Plot #3

## code for get_data.R is in the first answer.

source("get_data.R")

plot3 <- function() {
  get_data() ## Retrieving data s
  
  ## This first line will likely take a few seconds. Be patient!
  ## SCC data are not needed for this plot
  NEI <- readRDS("summarySCC_PM25.rds")
  #SCC <- readRDS("Source_Classification_Code.rds")
  
  ## Subset NEI to Baltimore City
  baltimore = NEI[NEI$fips=="24510",]
  
  library(ggplot2)
  
  g <- ggplot(data=baltimore, aes(x=year, y=Emissions, fill=type)) + 
    geom_bar(stat="identity") + 
    facet_grid(.~type) + 
    labs(x="Year", y="PM2.5 Emissions", title="Total PM2.5 Emissions in Baltimore City by source type")
  print(g)
  
  ## Create png file
  dev.copy(png, file="plot3.png")
  dev.off()
}

plot3()

### plot #4

## code for get_data.R is in the first answer.
source("get_data.R")

plot4 <- function() {
  get_data() ## Retrieving data 
  
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  coal <- grep("coal", SCC$EI.Sector, ignore.case = TRUE)
  coal_scc <- SCC[coal,]$SCC
  coal_nei <- NEI[NEI$SCC %in% coal_scc,]
  
  library(ggplot2)
  
  g <- ggplot(data=coal_nei, aes(x=year, y=Emissions)) + 
    geom_bar(stat="identity", fill="steelblue") + 
    labs(x="Year", y="PM2.5 Emissions", title="Total PM2.5 Emissions from Coal Combustion in the United States")
  print(g)
  
  ## Create png file
  dev.copy(png, file="plot4.png")
  dev.off()
}

plot4()

### Plot #5

# code for get_data.R is in the first answer.
source("get_data.R")

plot5 <- function() {
  get_data() ## Retrieving data 
  
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  ## Subset NEI to Baltimore City
  baltimore = NEI[NEI$fips=="24510",]
  
  vehicles <- grep("vehicles", SCC$EI.Sector, ignore.case = TRUE)
  vehicles_scc <- SCC[vehicles,]$SCC
  vehicles_baltimore <- baltimore[baltimore$SCC %in% vehicles_scc,]
  
  library(ggplot2)
  
  g <- ggplot(data=vehicles_baltimore, aes(x=year, y=Emissions)) + 
    geom_bar(stat="identity", fill="steelblue") + 
    labs(x="Year", y="PM2.5 Emissions", title="Total PM2.5 Emissions from Motor Vehicle Source in Baltimore City")
  print(g)
  
  ## Create png file
  dev.copy(png, file="plot5.png")
  dev.off()
  
}

plot5()

### Plot #6

## code for get_data.R is in the first answer.
source("get_data.R")

plot6 <- function() {
  get_data() ## Retrieving data 
  
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  ## Subset NEI to Baltimore City
  baltimore = NEI[NEI$fips=="24510",]
  ## Subset NEI to Los Angeles County
  los_angeles = NEI[NEI$fips=="06037",]
  
  vehicles <- grep("vehicles", SCC$EI.Sector, ignore.case = TRUE)
  vehicles_scc <- SCC[vehicles,]$SCC
  
  vehicles_baltimore <- baltimore[baltimore$SCC %in% vehicles_scc,]
  vehicles_los_angeles <- los_angeles[los_angeles$SCC %in% vehicles_scc,]
  
  vehicles_combined <- rbind(vehicles_baltimore, vehicles_los_angeles)
  
  library(ggplot2)
  
  ## Returns nice city name instead of fips code for facet label
  custom_label <- function(variable, value) {
    cities = list(
      '06037'="Los Angeles County",
      '24510'="Baltimore City"
    ) 
    return(cities[value])
  }
  
  g <- ggplot(data=vehicles_combined, aes(x=year, y=Emissions, fill=fips)) + 
    geom_bar(stat="identity") + 
    facet_grid(.~fips, labeller=custom_label) + 
    labs(x="Year", y="PM2.5 Emissions", title="Total PM2.5 Emissions, Baltimore City vs Los Angeles County")
  print(g)
  
  ## Create png file
  dev.copy(png, file="plot6.png")
  dev.off()
}

plot6()



################## Student #3 ######################


#### Plot #1 #####

SCC <- readRDS("NEI_data\\Source_Classification_Code.rds")
NEI <- readRDS("NEI_data\\summarySCC_PM25.rds")

agg1 <- aggregate(NEI$Emissions, by=list(year = NEI$year), FUN=sum )
agg1$year <- as.factor(agg1$year)

png(filename="plot1.png",width=480,height=480)
plot(agg1$year, agg1$x, xlab="Year", ylab="Total amount of emissions") 
dev.off()

##### Plot #2 ##### 

SCC <- readRDS("NEI_data\\Source_Classification_Code.rds")
NEI <- readRDS("NEI_data\\summarySCC_PM25.rds")

NEIBaltimore = subset(NEI, fips== "24510")

agg1 <- aggregate(NEIBaltimore$Emissions, by=list(year = NEIBaltimore$year), FUN=sum )
agg1$year <- as.factor(agg1$year)

png(filename="plot2.png",width=480,height=480)
plot(agg1$year, agg1$x,  xlab="Year", ylab="Total amount of emissions in Baltimore") 
dev.off()


#### Plot #3 ########

# set working directory
setwd("G:\\DataScience\\4-Exploratory\\Assignment2")

SCC <- readRDS("NEI_data\\Source_Classification_Code.rds")
NEI <- readRDS("NEI_data\\summarySCC_PM25.rds")

NEIBaltimore = subset(NEI, fips== "24510")

agg1 <- aggregate(NEIBaltimore$Emissions, by=list(year = NEIBaltimore$year, type=NEIBaltimore$type), FUN=sum )
agg1$year <- as.factor(agg1$year)


####
library(ggplot2)

png(filename="plot3.png",width=480,height=480)
q = ggplot(agg1, aes(year, x )) + 
  geom_point() + 
  facet_grid(type ~ .) +   
  xlab("Year") + 
  ylab( "Total amount of emissions in Baltimore")

print(q)

dev.off()


########### Plot #4 ##############

# set working directory
setwd("G:\\DataScience\\4-Exploratory\\Assignment2")

SCC <- readRDS("NEI_data\\Source_Classification_Code.rds")
NEI <- readRDS("NEI_data\\summarySCC_PM25.rds")

Coals <- SCC[grep("Comb.*Coal", SCC$Short.Name), ]
NEICoals  = subset(NEI, SCC %in% Coals$SCC)

agg1 <- aggregate(NEICoals$Emissions, by=list(year = NEICoals$year), FUN=sum )
agg1$year <- as.factor(agg1$year)

png(filename="plot4.png",width=480,height=480)

####
library(ggplot2)

q = ggplot(agg1, aes(year, x )) + 
  geom_point() + 
  #facet_grid(type ~ .) + 
  #scale_x_datetime(labels = date_format("%H:%M") ) + 
  xlab("Year") + 
  ylab( "Combustion related Emissions from Coal")

print(q)

dev.off()

########## Plot #5 ##############

# set working directory
setwd("G:\\DataScience\\4-Exploratory\\Assignment2")

SCC <- readRDS("NEI_data\\Source_Classification_Code.rds")
NEI <- readRDS("NEI_data\\summarySCC_PM25.rds")

NEIBaltimore = subset(NEI, fips== "24510")

MotorVehicles <- SCC[which(SCC$Data.Category == "Onroad"),]

NEIMotorVehicles  = subset(NEIBaltimore, SCC %in% MotorVehicles$SCC)

agg1 <- aggregate(NEIMotorVehicles$Emissions, by=list(year = NEIMotorVehicles$year), FUN=sum )
agg1$year <- as.factor(agg1$year)

png(filename="plot5.png",width=480,height=480)

####
library(ggplot2)

q = ggplot(agg1, aes(year, x )) + 
  geom_point() + 
  #facet_grid(type ~ .) + 
  #scale_x_datetime(labels = date_format("%H:%M") ) + 
  xlab("Year") + 
  ylab( "Emissions from Motor Vehicle sources in Baltimore")

print(q)

dev.off()

######## Plot #6 ############

# set working directory
setwd("G:\\DataScience\\4-Exploratory\\Assignment2")

SCC <- readRDS("NEI_data\\Source_Classification_Code.rds")
NEI <- readRDS("NEI_data\\summarySCC_PM25.rds")

NEIBaltimore = subset(NEI, fips== "24510" | fips== "06037")

MotorVehicles <- SCC[which(SCC$Data.Category == "Onroad"),]
NEIMotorVehicles  = subset(NEIBaltimore, SCC %in% MotorVehicles$SCC)

agg1 <- aggregate(NEIMotorVehicles$Emissions, by=list(year = NEIMotorVehicles$year, city = NEIMotorVehicles$fips), FUN=sum )
agg1$year <- as.factor(agg1$year)

agg1$city[which(agg1$city == "06037")] = "LA County"
agg1$city[which(agg1$city == "24510")] = "Baltimore"


png(filename="plot6.png",width=480,height=480)

####
library(ggplot2)
q = ggplot(agg1, aes(year, x )) + 
  geom_point() + 
  facet_grid(city ~ .) + 
  #scale_x_datetime(labels = date_format("%H:%M") ) + 
  xlab("Year") + 
  ylab( "Emissions from motor vehicle sources")

print(q)
dev.off()


############ Student #4 ###########

## TASK 1.
## Plot total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 2008

# Set working directory
setwd("C:/Users/Áðèãàäà/Downloads/New/ExploratoryDataAnalysis/ExploratoryDataAnalysisProject2")

# Download and open data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile ="./data/exdata-data-NEI_data.zip")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)

# Aggregate data
set1 <- select(NEI, Emissions, year)
set1 <- group_by(set1, year)
x <- tapply(set1$Emissions, set1$year, sum)

# Plot bar graph and save to png file
png('plot1.png')
barplot(x, col = "skyblue", xlab="Year", ylab=expression('Total PM'[2.5]*' emission'), main = expression('Total PM'[2.5]*' emissions by year'))
dev.off()

## TASK 2.
## Total emissions from PM2.5 in the Baltimore City, Maryland

# Set working directory
setwd("C:/Users/Áðèãàäà/Downloads/New/ExploratoryDataAnalysis/ExploratoryDataAnalysisProject2")

# Download and open data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile ="./data/exdata-data-NEI_data.zip")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
names(NEI)

# Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Aggregate data
# Select intrested columns
set2 <- select(NEI, fips, Emissions, year)
# Group by year
set2 <- group_by(set2, year)
# Filter Baltimor City
set2 <- filter(set2, fips == "24510")
# Find total emissions in different years
set2 <- summarise(set2, SumEmissions = sum(Emissions), Year = unique(year))
set2 <- select(set2, Year, SumEmissions)

# Plot bar graph and save to png file
png('plot2.png')
barplot(height = set2$SumEmissions, names.arg = set2$Year, col = "skyblue", xlab = "Year", ylab=expression('Total PM'[2.5]*' emission'), main = expression('Total PM'[2.5]*' emission in the Baltimore City'))
dev.off()

## TASK 3.
## Total emissions from PM2.5 in the Baltimore City, Maryland by Source of emission

# Set working directory
setwd("")

# Download and open data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile ="./data/exdata-data-NEI_data.zip")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

# Aggregate data
set3 <- select(NEI, fips, Emissions, type, year)
set3 <- filter(set3, fips == "24510")
set3 <- group_by(set3, type, year)
set3 <- summarise(set3, SumEmissions = sum(Emissions))

# Plot with ggplot function and save to png file
png('plot3.png')
g <- ggplot(set3, aes(year, SumEmissions, color = type))
summary(g)
g <- g + geom_line() + xlab("Year") + ylab(expression("Total PM"[2.5]*" emissions")) + ggtitle(expression("Total PM"[2.5]*" emissions in Baltimore City by sources"))
print(g)
dev.off()

## TASK 4.
## Total coal combustion-related sources emissions

# Set working directory
setwd("C:/Users/Áðèãàäà/Downloads/New/ExploratoryDataAnalysis/ExploratoryDataAnalysisProject2")

# Download and open data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile ="./data/exdata-data-NEI_data.zip")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
names(SCC)

library(lattice)
library(dplyr)

SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

set4 <- group_by(NEI.coal, year)
set4 <- summarise(set4, SumEmissions = sum(Emissions))
set4

library(ggplot2)

# Plot with ggplot function and save to png file
png('plot4.png')
g <- ggplot(set4, aes(year, SumEmissions))
summary(g)
g <- g  + geom_line() + geom_point(colour = "steelblue", size = 4) + xlab("Year") + ylab(expression("Total PM"[2.5]*" emissions by coal combustion-related sources")) + ggtitle(expression("Total PM"[2.5]*" emissions by coal combustion-related sources"))
print(g)
dev.off()

## TASK 5.
## Total motor vehicle emissions in Baltimore City

# Set working directory
setwd("C:/Users/Áðèãàäà/Downloads/New/ExploratoryDataAnalysis/ExploratoryDataAnalysisProject2")

# Download and open data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile ="./data/exdata-data-NEI_data.zip")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(dplyr)

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

set5 <- select(NEI.motor, fips, SCC, Emissions, year)
set5 <- filter(set5, fips == "24510")
set5 <- group_by(set5, year)
set5 <- summarise(set5, SumEmissions = sum(Emissions))

# Plot with ggplot function and save to png file
png('plot5.png')
g <- ggplot(set5, aes(year, SumEmissions))
summary(g)
g <- g  + geom_line() + geom_point(colour = "steelblue", size = 4) + xlab("Year") + ylab(expression("Total PM"[2.5]*" emissions by Motor Vehicle")) + ggtitle(expression("Total emissions by Motor Vehicle in Baltimore"))
print(g)
dev.off()

## TASK 6.
## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County

# Set working directory
setwd("C:/Users/Áðèãàäà/Downloads/New/ExploratoryDataAnalysis/ExploratoryDataAnalysisProject2")

# Download and open data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile ="./data/exdata-data-NEI_data.zip")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

library(dplyr)

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

set6 <- select(NEI.motor, fips, SCC, Emissions, year)
set6 <- filter(set6, fips == "24510" | fips == "06037" )
set6 <- group_by(set6, year, fips)
set6 <- summarise(set6, SumEmissions = sum(Emissions))
set6$fips <- as.factor(set6$fips) 
levels(set6$fips) <- list("Baltimore"="24510", "Los Angeles"="06037")


# Plot with ggplot function and save to png file
png('plot6.png')
g <- ggplot(set6, aes(year, SumEmissions, color = fips))
summary(g)
g <- g  + geom_line() + geom_point(colour = "steelblue", size = 4) + xlab("Year") + ylab(expression("Total PM"[2.5]*" emissions by Motor Vehicle")) + ggtitle(expression("Comparassion of emissions in LA and Baltimore"))
print(g)
dev.off()



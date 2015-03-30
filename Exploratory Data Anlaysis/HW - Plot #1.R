## Taylor Corbett - Exploratory Data Analysis - Week #1 Homework - Plot #1

## Step #1 - Set working directory to folder with "household_power_consumption.txt" file

## Step #2 - Read in and subset data
data = read.table("household_power_consumption.txt", head = FALSE, sep =";", skip = 66637, nrows = 2880)

## Step #3 - Contruct the and export the Plot
png("plot1.png", width = 480, height = 480)
par(mfrow = c(1,1), mar = c(5,4,1,1))
hist(data$V3, col="red", breaks = 12, xlab ="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

## Step #4 - Go to working directory to view the plot


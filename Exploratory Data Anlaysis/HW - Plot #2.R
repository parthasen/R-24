## Taylor Corbett - Exploratory Data Analysis - Week #1 Homework - Plot #2

## Step #1 - Set working directory to folder with "household_power_consumption.txt" file

## Step #2 - Read in and subset data
data = read.table("household_power_consumption.txt", head = FALSE, sep =";", skip = 66637, nrows = 2880)

## Step #3 - Contruct the and export the Plot
png("plot2.png", width = 480, height = 480)
plot(data$V3, type = "l",xaxt = "n", xlab = "",ylab = "Global Active Power (kilowatts)")
axis(1, at = c(0,1440,2880) , labels = c("Thu","Fri","Sat"))
dev.off()

## Step #4 - Go to working directory to view the plot

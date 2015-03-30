## Taylor Corbett - Exploratory Data Analysis - Week #1 Homework - Plot #3

## Step #1 - Set working directory to folder with "household_power_consumption.txt" file

## Step #2 - Read in and subset data
data = read.table("household_power_consumption.txt", head = FALSE, sep =";", skip = 66637, nrows = 2880)

## Step #3 - Contruct the and export the Plot
png("plot3.png", width = 480, height = 480)
plot(data$V7, type = "l", xaxt = "n", xlab = "",ylab = "Energy sub metering")
lines(data$V8, col = "red")
lines(data$V9, col = "blue")
axis(1, at = c(0,1440,2880) , labels = c("Thu","Fri","Sat"))
legend("topright", lty = 1, col=c("black","blue","red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

## Step #4 - Go to working directory to view the plot


## Exloratory Data Analysis - Week #1 Code
## Reading in Data
pollution = read.csv("avgpm25.csv", colClasses = c ("numeric", "character", "factor", "numeric", "numeric"))
head(pollution)
summary(pollution)
summary(pollution$pm25)

## 1 Dimentional Plots in R
boxplot(pollution$pm25, col = "blue")
hist(pollution$pm25, col = "green", breaks = 120)
rug(pollution$pm25, col = "blue")
abline(h=12)
abline(v=12, lwd = 4)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")

## 2 Dimentional Plots in R
boxplot(pm25 ~ region, data = pollution, col = "red")
par(mfrow = ????? ## Need to complete
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "red")
with(pollution, plot (latitude, pm25, col = region))
par(mfrow = c(1,2), mar = c(5,4,2,1))
with(subset(pollution, region == "west"), plot (latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot (latitude, pm25, main = "East"))

## Base plot system in R
?par #gives details on graphical parametters using in the Base Plot system
library(datasets)
hist(airquality$Ozone) ## Histogram
with(airquality, plot(Wind,Ozone)) ## Scatterplot
airquality = transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)") ## Boxplot
colors() ## list of all the colors you can call by name
http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

## Scatterplot of Ozone and Wind in New York City
par(mfrow = c(1,1))
with(airquality, plot(Wind,Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month==5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month !=5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col=c("blue","red"), legend = c("May", "Other Months"))

## Regession line of Ozone and Wind in New York City
model = lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

## Multiple plots in one window
par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})


## Base Plotting Demonstration
x = rnorm(100)
hist(x)
y = rnorm(100)
plot(x,y)
par(mar = c(2,2,1,1))
plot(x,y)
plot(x,y, pch = 20)
plot(x,y, pch = 19)
plot(x,y, pch = 2)
plot(x,y, pch = 4)
plot(x,y, pch = 18)
plot(x,y, pch = 14)
example(points) ##Chart of symbols included here

x = rnorm(100)
y = rnorm(100)
plot(x,y, pch = 20)
title("Scatterplot")
text(-2,-2, "Labels")
legend("topleft", legend = "Data", pch = 20)
fit = lm(y ~ x)
abline(fit, lwd = 2, col = "red")

z = rpois(100,2)
par(mfrow = c(2,1))
plot(x,y, pch = 20)
plot(x,z, pch = 20)
par("mar")
par(mfrow = c(1,2))
plot(x,y, pch = 20)
plot(x,z, pch = 20)
par(mfrow = c(2,2))
plot(x,y, pch = 20)
plot(x,z, pch = 20)
plot(z,x, pch = 20)
plot(y,x, pch = 20)

par(mfrow = c(1,1))
x = rnorm(100)
y = x + rnorm(100)
g <- gl(2, 50, labels = c("Male", "Female"))
str(g)
plot(x,y)
plot(x,y, type = "n") ##plots empty plot
points(x[g=="Male"], y[g == "Male"], col = "green")
points(x[g=="Female"], y[g == "Female"], col = "blue", pch = 19)

## Exploring graphic using different graphics package
pdf(file = "myplot.pdf") ##Open PDF Device; create 'myplot.pdf' in my working directory
## Create plot and send to a file (no plot appears on the screen)
with(faithful, plot(eruptions,waiting))
title(main = "Old Faithful Geyser data") ## Annotate plot with nothing still on the screen
dev.off()
dev.cur()

## Copying a screen plot to a graphics device
library(datasets)
with(faithful, plot(eruptions,waiting))
title(main = "Old Faithful Geyser data")
dev.copy(png, file = "geyserplot.png")
dev.off()

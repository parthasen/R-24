## Exloratory Data Analysis - Week #2 Code
## Lattice Plot System

##Video #1
library(lattice)
library(datasets)
## Simple Scatterplot
xyplot(Ozone ~ Wind, data = airquality)

## Convert 'Month' to a factor variable - print 5 seperate plots
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality)

##Video #2
set.seed(10)
x <- rnorm(100)
f = rep(0:1, each =50)
y = x + f - f * x + rnorm(100, sd = 0.5)
f = factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2,1))

##Custom panel function
xyplot(y ~ x | f, panel = function(x,y, ...) {
  panel.xyplot(x,y,...)
  panel.abline(h=median(y),lty=2)
})

xyplot(y ~ x | f, panel = function(x,y, ...) {
  panel.xyplot(x,y,...)
  panel.lmline(x,y,col=2)
})

##Video #4

library(ggplot2)
str(mpg)
?str
qplot(mpg$displ, mpg$hwy)
qplot(displ, hwy, data = mpg)

## Disaggregate by Drivetrain Variable
qplot(displ, hwy, data = mpg, col = drv)

## Add Lowes Trend Curve for one group
qplot(displ, hwy, data = mpg, geom = c("point","smooth"))

## Add Lowes Trend Curve for multiple groups
qplot(displ, hwy, data = mpg, col = drv, geom = c("point","smooth"))

## Histogram using qplot
qplot(hwy,data = mpg,fill=drv)

## Facets - Similar to Pannels in Lattice - Formatting left of ~ = columns, right of ~ = rows
qplot(displ, hwy, data = mpg, facets = drv~.)
qplot(displ, hwy, data = mpg, facets = .~drv)

qplot(hwy,data=mpg, facets = drv ~., binwidth = 2)

## Smoothed Density Plot - Total Sample
qplot(hwy, data=mpg, geom = "density")

## Smoothed Density Plot -  Sample Subsets
qplot(hwy, data=mpg, geom = "density", col = drv)

## Add Lowes Trend Curve for multiple groups - broken down by facet with linear model trendline
qplot(displ, hwy, data = mpg, method = "lm", facets = .~drv, geom = c("point","smooth"))

## Using ggplot2 - Core function - aes = asthetics
g = ggplot(mpg, aes(displ,hwy))
p = g + geom_point()
print(g)
p = g + geom_point() + geom_smooth()
print(p)
p = g + geom_point() + geom_smooth(method = "lm")
print(p)
p = g + geom_point() + facet_grid(. ~ drv) + geom_smooth(method = "lm")
print(p)
p = g + geom_point() + facet_grid(cyl ~ drv) + geom_smooth(method = "lm")
print(p)

## Change the colors of all points/geoms
p = g + geom_point() + facet_grid(. ~ drv) + geom_smooth(method = "lm") + geom_point(color = "steelblue", size = 4, alpha = 1/4)
print(p)

## Change the colors of  points/geoms based on a given variable
p = g + geom_point() + facet_grid(. ~ drv) + geom_smooth(method = "lm") + geom_point(aes(color = drv, size = 4, alpha = 1/4))
print(p)

## Modifying Labels
p = g + geom_point() + facet_grid(. ~ drv) + geom_smooth(method = "lm") + geom_point(aes(color = drv, size = 4, alpha = 1/4)) + labs(title = "Car Information Graph", x = "Car Displacement", y = "Miles Per Gallon - Highway") 
print(p)



## Summary provides you a summary of the ggplot object
summary(g)



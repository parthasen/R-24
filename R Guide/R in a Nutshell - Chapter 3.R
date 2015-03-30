############# R in a Nutshell ###############

############# Chapter #3 ###############

# Adding and Multiplying Vecotrs of Numbers
a = c(1,2,3,4)
b = c(10, 20, 30, 40)
a + b #applies a to b for all entries of a and b given that there are the same number
a*b

## # Adding and Multiplying Vecotrs with an unequal number of elements repeats
d = c(10,100)
b+d #applies a to b for all entries of a and b


## Functions ##

### Functions perform some opperation based on a set of arguments
### Examples:

exp(1)
cos(3.141593)
log(1)

## Variables

## R lets you assing variables and refer to them by name
## Define variables through the assingmetn opperator "<-" refered to as "gets"

x <- 1
y <- 2
z <- c(x,y)
z

b = c(1,2,3,4,5,6,7,8,9,10,11,12)
b[7] #fetches the 7th number in string b
b[1:6] #fetches 1-6th number in the string b
b[b %% 3 == 0] #fetechs only integrers divisable by 3
b[c(1,6,11)] #fetches items 1, 6, and 11
b[c(6,1,11)] #items can be fetched out of order
f = function(x,y) {c(x+1, y+1)}
f(1,2)

## Introduction to Data Structures

# Vectors = one dimentional data strucutres
a = c(1,2,3,4,5,5,6,7)

# Array = an array object is just a vector that's associated with a dimension attribute
a = array(c(1,2,3,4,5,6,7,8,9,10,11,12), dim=c(3,4))
a #This is what an array looks like
a[2,2] #how to refernce a cell in an array

## Array's can have more than two dimentions
a = array(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18), dim=c(3,3,2))
a

## Can specificy a call to bring up a specific part of any array
a = array(c(1,2,3,4,5,6,7,8,9,10,11,12), dim=c(3,4))
a[1,] # returns first row only
a[,1] # returns first column only
a[1:2,2:3] # can select range of rows & columns to return


## Matrix - A matrixs is just a two dimentional array
m = matrix(data = c(1,2,3,4,5,6,7,8,9,10,11,12), nrow = 3, ncol = 4)
m

# Lists 

## Lists can contain different types of components that can be called using different methods
## Lists are different than data frames in that thier vectors don't need to be the same length
e = list(thing=c("hat", "ball","fat", "kid"), size = 8.25)
e
e$thing
e$thing[2] #You can call a specific component of a list using by using [listname]$[column name]

## Lists can be nested lists include other lists

g = list("this list references another list", e)
g

# Dataframes
## you can build a dataframe from multiple vectors as long as they have the same number of elements

teams = c("PHI", "NYM", "FLA", "ATL", "WSN")
w = c(92,89,94,72,59)
l = c(70,73,77,90,102)
nleast = data.frame(teams, w, l)
nleast

##You can refer to the components of a data frame (or items in a list) by name using the $ operator

nleast$w

## To find values that match a specific operator use a logic condition
nleast$teams == "FLA"
nleast$l[nleast$teams == "FLA"] # Returns the number of FLA losses only

#Objects and Classes
## R is an object oriented language, every object in R has a type. Additionally, every object in R is a member of a class.
## You can determine the class of the object you are working with using the class() command

class(teams)
class(w)
class(nleast)
class(class)

## Generic functions - methods that are included in the Base R package that "do what you would assume they would do"
## Examples of generic functions include

17+6
as.Date("2009-09-08")+7
x = 1 + 2 + 3 + 4
x ## notice that this call actualyl generates print(x)

# Models and Formulas

## When writing models and formulas, notation is different than if you were writing the formual on paper
## y = c0 + c1x1 + c2x2 .... + cnxn + e where c is the coefficent of variable x and e is the error term
## In r this formula would be translated to:

y ~ x1 + x2 ... + xn

## As an example, let's use the cars dataset included in the R base package
cars ## dataset
cars.lm = lm(formula = dist ~ speed, data=cars)
cars.lm ## Prints coefficients
summary(cars.lm) ## prints a summary of the linear model
summary(lm(formula = dist ~ speed, data=cars)) ## Note, everything can be condensed into a single call if desired

# Charts and Graphics
# Plotting in the Base Plotting System

## Example of Plotting Real NFL Data
install.packages("nutshell")
library(nutshell)
data(field.goals)
names(field.goals)
hist(field.goals$yards) ## Histogram of field goal (attempts?) by yards
hist(field.goals$yards, breaks = 35) ##Increase the number of breaks presented in the diagram

table(field.goals$play.type)
summary(field.goals$play.type)

## create a strip chart of the number of blocked field goal attempts by yards
stripchart(field.goals[field.goals$play.type == "FG blocked",]$yards, pch=19)

## Plot the relationship between stoping distance and speed for the cars dataset
summary(cars)
plot(cars, xlab = "Speed (mph)", ylab = "Stopping Distance (ft)", las = 1, xlim = c(0,25))

# Plotting in the Latice Plotting System
## Example data looking at food consumption in the United State by year

library(nutshell)
library(lattice)
data(consumption)
dotplot(Amount~Year|Food, consumption) #Looks messy
dotplot(Amount~Year|Food, consumption, aspect = "xy", scales=list(relation="sliced", cex =.4)) #Cleaner Looking

# Getting help in R

## There are two ways to get help with a function in R - Here are examples on how to get help with the glm function

help(glm)
?glm
example(glm) ## Automatically runs the example code in the help file
help.search("regression") # Allows you to search for topics related to regressions in the help directory
??regression ## returns the same research results
library(help="grDevices") ## Gives you detialed documentation on a specific package
vignette("affy") # If a package has an executive summary or "vignette" this command will display the information
vignette(all = FALSE) #shows what vignettes are available for attached packages
vignette(all = TRUE) #shows what vignettes are available for installed packages






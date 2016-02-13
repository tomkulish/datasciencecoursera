# Week 1 Notes

pollution <- read.csv("data/avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
head(pollution)

# 1 Dimensional Plots
# Five Number Summary
summary(pollution$pm25)

#boxplot
boxplot(pollution$pm25, col="blue")

#histogram
hist(pollution$pm25, col="green")
rug(pollution$pm25)

#more breaks
hist(pollution$pm25, col="green", breaks=100)
rug(pollution$pm25)

#overlay features
boxplot(pollution$pm25, col="blue")
abline(h=12)

hist(pollution$pm25, col="green")
abline(v=12, lwd=2)
abline(v=median(pollution$pm25), col="magenta", lwd=4)

#barplot
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")

# 2 Dimensional Plots
# Multiple Boxplots
boxplot(pm25 ~ region, data = pollution, col="red")

# Multiple Histograms
par(mfrow = c(2,1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col="green")
hist(subset(pollution, region == "west")$pm25, col="green")

# Scatterplot
with(pollution, plot(latitude, pm25))
abline(h=12, lwd=2, lty=2)

# Scatterplot with Color
with(pollution, plot(latitude, pm25, col = region))
abline(h=12, lwd=2, lty=2)

# Multiple Scatterplots
par(mfrow = c(1,2), mar = c(5,4,2,1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))


# Three Core Plotting Systems
# Base Plotting System
library(datasets)
data(cars)
with(cars, plot(speed, dist))

# Lattice System
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

# ggplot2 System
library(ggplot2)
data(mpg)
qplot(displ, hwy, data=mpg)

#################################
# Base Graphics
library(datasets)
hist(airquality$Ozone)

# scatter
with(airquality, plot(Wind, Ozone))

#Boxplot
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

# par() GLOBAL settings
# Base Plot with Annotation
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col="red"))
legend("topright", pch=1, col = c("blue", "red"), legend=c("May", "Other Months"))

# Model line in trend
# pch = 20 is a small filled in circle
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd=2)

# 1 row 2 columns
par(mfrow = c(1,2))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solor.R, Ozone, main = "Ozone and Solar Radiation")
})

# Multiple rows and a title
par(mfrow=c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solor.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Solor.R, Ozone, main = "Ozone and Solar Radiation")
  mtext("Ozone and Wather in New York City", outer = TRUE)
})
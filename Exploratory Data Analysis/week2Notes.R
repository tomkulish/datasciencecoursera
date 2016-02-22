# Week 2 Notes

## GGplot2 Package
# qplot()
# workhorse function, like the plot() 
# Dataframe is important

library(ggplot2)
str(mpg)

qplot(displ, hwy, data = mpg)

qplot(displ, hwy, data = mpg, color = drv)
# Statiscal Methods
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

qplot(hwy, data = mpg, fill = drv)

# adding in different panels
qplot(displ, hwy, data = mpg, facets = . ~ drv)

qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)

## MAACS Cohort data
qplot(log(eno), data = maacs, fill=mopos)
qplot(log(eno), data = maacs, geom = "density")
qplot(log(eno), data = maacs, geom = "density", color=mopos)

# Scatterplots
qplot(log(pm25), log(eno), data=maacs)
qplot(log(pm25), log(eno), data=maacs, shape = mopos)
qplot(log(pm25), log(eno), data=maacs, color=mopos)

# Smoothing.
qplot(log(pm25), log(eno), data=maacs, color=mopos, geom=c("point", "smooth", method = "lm"))
qplot(log(pm25), log(eno), data=maacs, geom=c("point", "smooth", method = "lm"), facets = . ~ mopos)

# Analog to the plot() function
# You can save a ggplot() to g
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
summary(g)

print(g) # will fail
p <- g + geom_point()
print(p) # will work.
g + geom_point() # will work and just go to screen

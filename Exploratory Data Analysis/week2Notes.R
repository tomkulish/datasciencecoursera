# Week 2 Notes

## GGplot2 Package
# qplot()
# workhorse function, like the plot() 
# Dataframe is important

library(ggplot2)
str(mpg)

qplot(displ, hwy, data = mpg)
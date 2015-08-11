####################
# Week 3 Examples and work for Getting and Cleanning Data with R 
####################

setwd("C:\\Users\\me_000\\Documents\\GitHub\\datasciencecoursera\\Getting and Cleanning Data\\quizes")

#####################
# Creating Logical Vector
#####################

if(!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
destFile <- ".\\data\\acs_usc_2006_micro.csv"

download.file(fileUrl, destfile = destFile)
list.files(".\\data")

dateDownloaded <- date()
dateDownloaded

ascData <- read.csv(destFile)
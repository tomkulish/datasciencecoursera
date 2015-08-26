####################
# Week 4 Examples and work for Getting and Cleanning Data with R 
####################

setwd("C:\\Users\\me_000\\Documents\\GitHub\\datasciencecoursera\\Getting and Cleanning Data\\quizes")

##################
# strsplit()
##################

if(!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
destFile <- ".\\data\\acs_usc_2006_micro.csv"

download.file(fileUrl, destfile = destFile)
list.files(".\\data")

dateDownloaded <- date()
dateDownloaded

acs <- read.csv(destFile)

splitNames <- strsplit(names(acs), "wgtp")

splitNames[[123]]


#################
# Removing commas or other things.
################
# sapply on a function that removes commas
library(dplyr)

if(!file.exists("data")) {
  dir.create("data")
}

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
destFile1 <- ".\\data\\GDP.csv"

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
destFile2 <- ".\\data\\EDSTATS_Country.csv"

download.file(fileUrl1, destfile = destFile1)
download.file(fileUrl2, destfile = destFile2)

list.files(".\\data")

dateDownloaded <- date()
dateDownloaded

GDP <- read.csv(destFile1, stringsAsFactors=FALSE)
EDStats <- read.csv(destFile2)

#GDP <- read.table(destFile1, col.names = c("Country","Ranking","UK","Name","dollars","","","","",""), skip = 5)
GDP <- GDP[5:194,]
sapply(GDP, mode)
GDP <- rename(GDP, short = X, rank = Gross.domestic.product.2012, long = X.2, dollars = X.3)
GDP <- transform(GDP, rank = as.numeric(rank))
#mergedData <- merge(GDP, EDStats, by.x ="short", by.y="CountryCode")
#mergedSorted <- arrange(mergedData, desc(rank))

removeComma <- function(x) {gsub(",","", x)}
removeSpace <- function(x) {gsub(" ","", x)}

gdpNoComma <- sapply(GDP$dollars, removeComma)
gdpNoSpace <- sapply(gdpNoComma, removeSpace)

gdpClean <- as.numeric(gdpNoSpace)
mean(gdpClean)


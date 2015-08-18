####################
# Week 3 Examples and work for Getting and Cleanning Data with R 
####################

setwd("C:\\Users\\me_000\\Documents\\GitHub\\datasciencecoursera\\Getting and Cleanning Data\\quizes")

#####################
# Creating Logical Vector
#####################
install.packages("dplyr")
library(dplyr)

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

#ACR=3 greater than 10 acres
#AGS=6
#ascDataTest.LV <- filter(ascData, ACR == 3 & AGS == 6)
agricultureLogical <- ascData[(ascData$ACR == 3 & ascData$AGS == 6),]
head(ascData[which(ascData$ACR == 3 & ascData$AGS == 6),])

#######################
# JPEG
#######################
install.packages("jpeg")
library(jpeg)

if(!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg "
destFile <- ".\\data\\Fjeff.jpg"

download.file(fileUrl, destfile = destFile, mode='wb')
list.files(".\\data")

dateDownloaded <- date()
dateDownloaded

jeff <- readJPEG(destFile, native=TRUE)
head(jeff)
summary(jeff)
str(jeff)
quantile(jeff)
quantile(jeff, probs=c(0.30,0.80))

#######################
# Matching!
#######################
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
mergedData <- merge(GDP, EDStats, by.x ="short", by.y="CountryCode")
mergedSorted <- arrange(mergedData, desc(rank))


######################
# Summarize
######################
averageGDP <- group_by(mergedSorted, Income.Group)
summarize(averageGDP, averageRanking = mean(rank))

######################
# Quantile + Income Group
# How many countries in the lower middle income
# cut2
#########################
install.packages("Hmisc")
library(Hmisc)
mergedSorted$Groups = cut2(mergedSorted$rank, g=5)
table(mergedSorted$Groups)
mergedSorted$lowMidIncome = mergedSorted$Income.Group %in% c("Lower middle income")
endX <- filter(mergedSorted, Groups == "[  1, 39)" & lowMidIncome == "TRUE")


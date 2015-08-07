#########
# Week 1 Examples and work for Getting and Cleanning Data with R
# 
#########

setwd("C:\\Users\\me_000\\Documents\\GitHub\\datasciencecoursera\\Getting and Cleanning Data\\quizes")

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

# First we are looking at the VAL column. 24 means over 1million
ascData[,'VAL']
values = ascData[,'VAL']
values <- values[!is.na(values)]

# Now its a vector of ints. Just do a filter on 24
propertyValueOver1M <- values[values == 24]

#####################################################
#Checking the Frequency of FES column
FES <- ascData$FES
FES.freq = table(FES)
FES.freq

# I think the combining of household and job is bad. 

#####################################################
# Want to read in a specific set of columns.
install.packages("xlsx") # Make sure you have Java 8 x64 installed. if you are using RStudio x64. 
library(xlsx)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
destFile <- ".\\data\\FDATA.xlsx"
download.file(fileUrl, destfile = destFile, mode='wb') # Annoyingly you must use the mode='wb' because .xlsx reader below is looking for it to be in binary format. Which makes sense when you think of it.
list.files(".\\data")

dateDownloaded <- date()
dateDownloaded

sheetIndex <- 1
colIndex <- 7:15
rowIndex <- 18:23

ngapData <- read.xlsx(destFile, sheetIndex)

dat <- read.xlsx(destFile, sheetIndex, rowIndex = rowIndex, colIndex = colIndex)

#####################################################
# Reading XML
install.packages("XML")
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
destFile <- ".\\data\\BmoreRestaurants.xml"

download.file(fileUrl, destfile = destFile)
list.files(".\\data")
dateDownloaded <- date()
dateDownloaded

doc <- xmlTreeParse(destFile, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
zipCodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
zipCodes21231 <- zipCodes[zipCodes == "21231"]
length(zipCodes21231)

####################################################
# FRead
install.packages("data.table")
library("data.table")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
destFile <- ".\\data\\ss0pid.csv"

download.file(fileUrl, destfile = destFile)
list.files(".\\data")
dateDownloaded <- date()
dateDownloaded

DT <- fread(destFile)
DT[,mean(pwgtp15),by=SEX] 

####################
# Week 2 Examples and work for Getting and Cleanning Data with R 
####################

setwd("C:\\Users\\me_000\\Documents\\GitHub\\datasciencecoursera\\Getting and Cleanning Data\\quizes")

############################################################
#  Talk to the GitHub API
############################################################
install.packages("RCurl")
install.packages("devtools")
install.packages("ROAuth")
install.packages("httr")
install.packages("httpuv")
library(RCurl)
library(devtools)
library(ROAuth)
library(httr)
library(httpuv)


# https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

oauth_endpoints("github")
myapp = oauth_app("github", key = "###", secret = "###")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
json2[6,] # looking for created_at


#########################################################
# Download some CSV and run some SQL commands on it
###################################################
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
install.packages("sqldf")
library(sqldf)
if(!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
destFile <- ".\\data\\acs_usc_2006_micro.csv"

download.file(fileUrl, destfile = destFile)
list.files(".\\data")

dateDownloaded <- date()
dateDownloaded

acs <- read.csv(destFile)
sqldf("SELECT * FROM acs")
sqldf("select pwgtp1 from acs where AGEP < 50")
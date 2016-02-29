#########################################
# Project 2 - PM2.5 Review
# 27 Feb 2016
# NOTE: This has been created to work on a Windows machine (notice backslashes)
# Assumption that the two files are in data/
#########################################


###############
# Loading Data
##############
print("Loading data")
pmData <- readRDS("./data/summarySCC_PM25.rds")
head(pmData)
summary(pmData)
sccData <- readRDS("./data/Source_Classification_Code.rds")
head(sccData)
summary(sccData)


##############
# Plot 1
#############
aggPmDataByYear <- aggregate(Emissions ~ year,pmData, sum)

png("plot1.png",width=480,height=480,units="px",bg="transparent")

barplot(
  (aggPmDataByYear$Emissions)/10^6,
  names.arg=aggPmDataByYear$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All Sources"
)

dev.off()

###############
# Plot 2
###############
# Subset pmData data by Baltimore
baltimorepmData <- pmData[pmData$fips=="24510",]

# Aggregate using sum the Baltimore emissions data by year
aggPmDataByBaltimore <- aggregate(Emissions ~ year, baltimorepmData,sum)

# Create plot2.png graph
png("plot2.png",width=480,height=480,units="px",bg="transparent")

# Create barplot
barplot(
  aggPmDataByBaltimore$Emissions,
  names.arg=aggPmDataByBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (in Tons)",
  main="Total PM2.5 Emissions From all Baltimore City"
)

# Save barplot 
dev.off()
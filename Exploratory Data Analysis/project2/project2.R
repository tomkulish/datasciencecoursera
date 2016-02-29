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

###############
# Plot 3
###############
library(ggplot2)
# Subset pmData data by Baltimore
baltimorepmData <- pmData[pmData$fips=="24510",]

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot3.png", width = 480, height = 480, units = "px")
g <- ggplot(baltimorepmData, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y = "sum") + ylab( " Total 2.5 Emissions") +  ggtitle("Total Emissions in Baltimore City from 1999 to 2008")
dev.off()


##############
# Plot 4
##############
library(ggplot2)

# Subset coal combustion related NEI data
combustionTogether <- grepl("comb", sccData$SCC.Level.One, ignore.case=TRUE)
coalTogether <- grepl("coal", sccData$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionTogether & coalTogether)
combustionSCC <- sccData[coalCombustion,]$SCC
combustionpmData <- pmData[pmData$SCC %in% combustionSCC,]

png("plot4.png",width=480,height=480,units="px",bg="transparent")

ggp <- ggplot(combustionpmData,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y="Total PM Emission (10^6 Tons)") + 
  labs(title="PM Coal Combustion Source Emissions Across US from 1999-2008")

print(ggp)

dev.off()

###############
# Plot 5 
##############
library(ggplot2)

# Combine the two datasets
#pmDatawithScc <- merge(pmData, sccData, by="SCC")

subsetpmData <- pmData[pmData$fips=="24510" & pmData$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetpmData, sum)

png("plot5.png", width=840, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") + ylab("Total PM 2,5 Emissions") + ggtitle('Total Emissions pmData in Baltimore from 1999 to 2008')
print(g)
dev.off()

##################
# Plot 6
#################
# Get only things with the vechnical data
vehicles <- grepl("vehicle", sccData$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- sccData[vehicles,]$SCC
vehiclespmData <- pmData[pmData$SCC %in% vehiclesSCC,]

# create the datasets for each city
vehiclesBaltimorepmData <- vehiclespmData[vehiclespmData$fips=="24510",]
vehiclesBaltimorepmData$city <- "Baltimore"

vehiclesLApmData <- vehiclespmData[vehiclespmData$fips=="06037",]
vehiclesLApmData$city <- "Los Angeles County"

# put the two datasets together to do analysis on.
bothpmData <- rbind(vehiclesBaltimorepmData,vehiclesLApmData)

png("plot6.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(bothpmData, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y="Total PM Emission (Kilo-Tons)") + 
  labs(title="PM Motor Vehicle Source Emissions in Baltimore & LA, (years: 1999-2008)")

print(ggp)

dev.off()
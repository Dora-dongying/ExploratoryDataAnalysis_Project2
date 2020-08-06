## Q6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
## in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?
############################ A5: Los Angeles. #######################################

## Download the ZIP file and then unzip it. Check if the files exist before processing.
zipname <- "exdata_data_NEI_data.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists(zipname)){
        download.file(fileURL, zipname, method = "curl")
}
unzip(zipname)

## Read the data into R as data.frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset for motorcycle and calculate the sum emission for separate years.
Baltimore_LAMotor <- subset(NEI, NEI$fips %in% c("24510", "06037")  & NEI$type == "ON-ROAD")
Sum_Baltimore_LAMotor <- aggregate(Emissions ~ year + fips, Baltimore_LAMotor, sum)
Sum_Baltimore_LAMotor$fips <- gsub("24510", "Baltimore", Sum_Baltimore_LAMotor$fips)
Sum_Baltimore_LAMotor$fips <- gsub("06037", "Los Angeles", Sum_Baltimore_LAMotor$fips)

## Make the plot and save in a .png file
png(file="./plot6.png", width = 400, height = 360)
library(ggplot2)
p <- ggplot(Sum_Baltimore_LAMotor, aes(year, Emissions, col = fips))
p + geom_line() + geom_point() + facet_grid(rows = vars(fips)) + 
        ggtitle("Total Baltimore/LA PM2.5 Motor Vehicle Emission by Year") +
        xlab("Year") + ylab("Baltimore/LA PM2.5 Coal Emission")

dev.off()

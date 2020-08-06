## Q5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
############################ A5: Decreases. #######################################

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
BaltimoreMotor <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
Sum_BaltimoreMotor <- aggregate(Emissions ~ year, BaltimoreMotor, sum)

## Make the plot and save in a .png file
png(file="./plot5.png", width = 400, height = 360)
library(ggplot2)
p <- ggplot(Sum_BaltimoreMotor, aes(year, Emissions))
p + geom_line() + geom_point() +
        ggtitle("Total Baltimore PM2.5 Motor Vehicle Emission by Year") +
        xlab("Year") + ylab("Baltimore PM2.5 Coal Emission")

dev.off()
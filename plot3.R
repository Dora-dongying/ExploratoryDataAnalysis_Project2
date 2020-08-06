## Q3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
################### A3: All decrease except "point". #######################################

## Use the ggplot2 plotting system to make a plot answer this question.

## Download the ZIP file and then unzip it. Check if the files exist before processing.
zipname <- "exdata_data_NEI_data.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists(zipname)){
        download.file(fileURL, zipname, method = "curl")
}
unzip(zipname)

## Read the data into R as data.frames
NEI <- readRDS("summarySCC_PM25.rds")

## Subset for Maryland and calculate the sum emission for separate years and define the year vector.
BaltimoreData <- subset(NEI, NEI$fips == "24510")
Baltimore_byType <- aggregate(Emissions ~ year + type, BaltimoreData, sum) ## Aggregate 

## Make the plot and save in a .png file
png(file="./plot3.png", width = 360, height = 400)
library(ggplot2)
p <- ggplot(Baltimore_byType, aes(year, Emissions, col = type))
p + geom_point() + geom_line() + facet_grid(rows = vars(type)) + 
        ggtitle("Total Baltimore PM2.5 Emissions by Type and Year") +
        ylab("Total Baltimore PM2.5 Emissions") + xlab("Year")
dev.off()
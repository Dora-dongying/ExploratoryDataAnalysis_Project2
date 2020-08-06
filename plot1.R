## Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
############################## A1: Yes #######################################

## Using the base plotting system, make a plot showing the total PM2.5 emission from all 
## sources for each of the years 1999, 2002, 2005, and 2008.

## Download the ZIP file and then unzip it. Check if the files exist before processing.
zipname <- "exdata_data_NEI_data.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists(zipname)){
        download.file(fileURL, zipname, method = "curl")
}
unzip(zipname)

## Read the data into R as data.frames
NEI <- readRDS("summarySCC_PM25.rds")
## Calculate the sum emission for separate years and define the year vector. 
SumbyYear_NEI <- sapply(split(NEI$Emissions, as.factor(NEI$year)), sum)
Year <- c(1999, 2002, 2005, 2008)

## Make the plot and save in a .png file
png(file="./plot1.png", width = 400, height = 360)
plot(Year, SumbyYear_NEI, 
     xlab = "Year", ylab = "Total PM2.5 emission", main = "Total PM2.5 emission vs. Year",
     col = "black")
## Add a linear fitting to show the trend, decreasing.
trend <- lm(SumbyYear_NEI ~ Year)
abline(trend, col = "blue")

dev.off()

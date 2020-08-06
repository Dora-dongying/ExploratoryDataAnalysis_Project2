## Q2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? 
############################## A2: Yes #######################################

##Use the base plotting system to make a plot answering this question.

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
SumbyYear_Baltimore <- sapply(split(BaltimoreData$Emissions, as.factor(BaltimoreData$year)), sum)
Year <- c(1999, 2002, 2005, 2008)

## Make the plot and save in a .png file
png(file="./plot2.png", width = 400, height = 360)
plot(Year, SumbyYear_Baltimore, 
     xlab = "Year", ylab = "Total PM2.5 emission", main = "Total PM2.5 emission vs. Year in Baltimore",
     col = "red")
## Add a linear fitting to show the trend, decreasing.
trend <- lm(SumbyYear_Baltimore ~ Year)
abline(trend, col = "blue")

dev.off()
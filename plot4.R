## Q4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
########### A4: In general decreasing, slightly different trends within types. ###########

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

## Subset and calculate the sum emission for separate years.
SCC_Coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
NEI_Coal <- NEI[NEI$SCC %in% SCC_Coal$SCC,]
total_Coal <- aggregate(Emissions ~ year + type, NEI_Coal, sum)

## Make the plot and save in a .png file
png(file="./plot4.png", width = 400, height = 360)
library(ggplot2)
p <- ggplot(total_Coal, aes(year, Emissions, col = type))
p + geom_line() + geom_point() + facet_grid(rows = vars(type)) +
        ggtitle("Total US PM2.5 Coal Emission by Type and Year") +
        xlab("Year") + ylab("US PM2.5 Coal Emission")

dev.off()

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

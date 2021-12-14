## Download and unzip the zip dataset:
if (!file.exists("thefile.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, "thefile.zip", method="curl")
}
if (!file.exists("household_power_consumption.txt")) {
  unzip("thefile.zip")
}

## Read the dataset
library(data.table)
library(dplyr)
Data<-fread("household_power_consumption.txt")
Data$Date<-as.Date(Data$Date, "%d/%m/%Y")

## Filter the dates desired
Data <- filter(Data, Date == "2007-02-01" | Date == "2007-02-02")
Data$Global_active_power<-as.numeric(Data$Global_active_power)

hist(Data$Global_active_power, col="red",xlab="Global active power (kilowatts)",main="Global active power")
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off()

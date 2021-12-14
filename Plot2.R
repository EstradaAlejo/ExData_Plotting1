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
Data$Voltage<-as.numeric(Data$Voltage)
Data$Global_intensity<-as.numeric(Data$Global_intensity)
Data$Sub_metering_1<-as.numeric(Data$Sub_metering_1)
Data$Sub_metering_2<-as.numeric(Data$Sub_metering_2)
Data$Sub_metering_3<-as.numeric(Data$Sub_metering_3)
Data <- as.data.frame(mutate(Data,full_time=strptime(paste(Data$Date,Data$Time), format="%Y-%m-%d %H:%M:%S")))

## Make the plot
with(Data, plot(full_time, Global_active_power, type="l",ylab="Global active power (kilowatts)",xlab=NA))
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off()

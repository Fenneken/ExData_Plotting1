#Exploratory Data Anlaysis - Course Project 1
#Read the file Electric Power Consumption 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# It contains a txt file household_power_consumption
# Only use data of 2007-02-01 and 2007-02-02
# Make date/time variables 
# Replace missing values ? by NA

#Download the zipfile
#first makesure that the directory data exists
if (!file.exists("data")){
     dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/HouseholdPowerConsumption.zip",method="curl")
unzip("./data/HouseholdPowerConsumption.zip",exdir="./data") #unzip the file
setwd("./data") # move to the directory of the data
# read the txt file
household_power_consumption <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings="?")
#filter only the rows of required dates
library(dplyr)
household_power_consumption <- filter(household_power_consumption, Date %in% c("1/2/2007","2/2/2007"))

#create a datetime column
household_power_consumption$DateTime <- paste(household_power_consumption$Date,household_power_consumption$Time,sep = " ")
#convert to datetime
household_power_consumption$DateTime <- strptime(household_power_consumption$DateTime, "%d/%m/%Y %H:%M:%S")
household_power_consumption$Date <- as.Date(household_power_consumption$Date,"%d/%m/%Y")


# Plot 3 Energy submetering 1/2/3
par(mfrow=c(1,1),mar=c(4,4,1,1))
with(household_power_consumption, {
     plot(DateTime,Sub_metering_1,type = "l",ylab="Global Active Power (kilowatts)",xlab=NA)
     lines(DateTime,Sub_metering_2,col="red")
     lines(DateTime,Sub_metering_3,col="blue")
})
legend("topright", col=c(1,"red","blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=1)
#copy plot to png
dev.copy(png,file="plot3.png")
dev.off()

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
###This code is for Checking whether data file exists. If not, it will unzip the file
#setwd("./data") # move to the directory of the data

if (!file.exists("./data/household_power_consumption.txt")) { 
     fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
     download.file(fileUrl, destfile = "./data/HouseholdPowerConsumption.zip",method="curl")
     unzip("HouseholdPowerConsumption.zip",exdir="./data") #unzip the file
}

# read the txt file
household_power_consumption <- read.table("./data/household_power_consumption.txt", sep=";", header = TRUE, na.strings="?")
#filter only the rows of required dates
library(dplyr)
household_power_consumption <- filter(household_power_consumption, Date %in% c("1/2/2007","2/2/2007"))

#create a datetime column
household_power_consumption$DateTime <- paste(household_power_consumption$Date,household_power_consumption$Time,sep = " ")
#convert to datetime
household_power_consumption$DateTime <- strptime(household_power_consumption$DateTime, "%d/%m/%Y %H:%M:%S")
household_power_consumption$Date <- as.Date(household_power_consumption$Date,"%d/%m/%Y")

#Plot 2 Global active Power (time vs kilowatts)
par(mfrow=c(1,1),mar=c(4,4,1,1))
with(household_power_consumption,plot(DateTime,Global_active_power,type = "l",ylab="Global Active Power (kilowatts)",xlab=NA))
#copy plot to png
dev.copy(png,file="plot2.png",width = 480, height = 480)
dev.off()
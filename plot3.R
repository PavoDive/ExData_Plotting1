# Script to produce the plots required by project 1 of Exploratory Data Analysis

# File downloading and unzipping
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
unzip("household_power_consumption.zip","household_power_consumption.txt")

# Reading file into environment
hpc<- read.table("household_power_consumption.txt",header = T,sep = ";",na.strings = "?")

# loading required libraries 
library(lubridate)  # for Date / time manipulation

# Converting text dates / times into POSIXct objects
hpc$Date<- dmy(hpc$Date)
hpc$Time<- hms(hpc$Time)

# Subsetting for 1st and 2nd of februrary, as indicated
j<-which(hpc$Date==dmy(01022007) | hpc$Date==dmy(02022007),arr.ind = T)
working_hpc<-hpc[j,]

# Creating a new column of date:time
working_hpc$DateTime<- ymd_hms(paste(Date,Time))

# To simplify writing, attach the working variable into environment
attach(working_hpc)

# ================ PRODUCE THIRD PLOT ========================#

# Open the device
png("plot3.png",480,480)

# Use matplot to plot several lines at a time. As matplot works only for numeric variables, we need to turn off the x-axis (xaxt="n"). We'll later fix it
matplot(DateTime,working_hpc[,7:9],type = "l",xaxt="n",ylab = "Energy sub metering")

# Re-format the axis, so it shows dates/times
axis.POSIXct(1,DateTime)

# Introduce the legend
legend("topright",legend = colnames(working_hpc)[7:9],col=1:3,pch=1)

# Close the device
dev.off()
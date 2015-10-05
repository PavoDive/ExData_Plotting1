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

# ================ PRODUCE FIRST PLOT ========================#

# Open png file and define its attributes (name, width, height)
png(filename = "plot1.png",width = 480,height = 480)

# Actual plot of the histogram, defining main title, x-label and color of the plot)
hist(Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",col = "red")

# Close de device
dev.off()


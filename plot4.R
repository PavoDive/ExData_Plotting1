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

# ================ PRODUCE FOURTH PLOT ========================#

# Open the device
png("plot4.png",480,480)

# Define a 2 by 2 plotting board
par(mfrow=c(2,2))

# Produce first plot (staring from top-left and going clockwise)
plot(DateTime,Global_active_power,"l",xlab="",ylab="Global Active Power (kilowatts)")

# Produce second plot
plot(DateTime,Voltage,"l",xlab="datetime")

# Produce third plot. In the "legend" command, please notice the use of cex=.5 to reduce the size of text, and of bty="n" to eliminate the sorrounding box
matplot(DateTime,working_hpc[,7:9],type = "l",xaxt="n",ylab = "Energy sub metering")
axis.POSIXct(1,DateTime)
legend("topright",legend = colnames(working_hpc)[7:9],col=1:3,pch=1,cex=.5,bty="n")

# Produce fourth plot
plot(DateTime,Global_reactive_power,"l")

# And close the device!
dev.off()

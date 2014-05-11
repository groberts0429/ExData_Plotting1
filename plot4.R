################################ plot4.R #########################################
# (you should already be in the "project_root" directory if you have just run any of the other scripts. If not, then migrate there before running "plot 2". 
# If you are running the scripts sequentially, the first line of code will take you back to the "project_root" directory. Comment this line out if you are already in the "project_root" directory.
# Files will be output to "George_Roberts_png" which will be located in the "project_root" directory
#################################################################################
setwd("exdata-data-household_power_consumption") 
hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
setwd("..") # reenter "project_root" and then create the output directory
if (!file.exists("George_Roberts_png"))
  dir.create("George_Roberts_png")
setwd("George_Roberts_png")
hpc$Date <- strptime(hpc$Date, "%d/%m/%Y")
hpc <- hpc[hpc$Date == strptime("2007-02-01", "%Y-%m-%d") | hpc$Date == strptime("2007-02-02", "%Y-%m-%d"), ]
dtime <- strptime(paste(hpc$Date, hpc$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
wdays <- weekdays(hpc$Date)
hpc  <- cbind(hpc, dtime, wdays)
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1)) #convert factors to numeric
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
png("plot4.png")
par(mfrow=c(2,2))
plot(hpc$dtime, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)") #1

plot(hpc$dtime, hpc$Voltage            , type="l", xlab="datetime", ylab="Voltage") #2

plot(hpc$dtime,  hpc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black") #3
lines(hpc$dtime, hpc$Sub_metering_2, col="red")
lines(hpc$dtime, hpc$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), cex=0.85, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) #cex=0.7 makes the legend exactly the width depicted in the instructions

plot(hpc$dtime, hpc$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power") #4
dev.off()
setwd("..")



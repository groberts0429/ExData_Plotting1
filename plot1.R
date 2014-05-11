#################################################################################
# Run thie plot1 script from the directory that contains the "exdata-data-household_power_consumption" directory (hereafter "project_root").
# Subsequent scripts will work automatically if you run the "plot1" script first. If you run scripts 2-4 without running "plot
# Files will be output to "George_Roberts_png" which will be located in the "project_root" directory
################################ plot1.R #########################################
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
png("plot1.png")
hist(hpc$Global_active_power, breaks=seq(0, 7.5, by=0.5), main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
setwd("..")


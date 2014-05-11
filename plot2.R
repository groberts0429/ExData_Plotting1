################################ plot2.R #########################################
# (you should already be in the "project_root" directory if you have just run "plot1.R". If not, then migrate there before running "plot 2". 
# If you are running the scripts sequentially, the first line of code will take you back to the "project_root" directory. Comment this line out if you are already in the "project_root" directory.
# Files will be output to "George_Roberts_png" which will be located in the "project_root" directory
#################################################################################
setwd("exdata-data-household_power_consumption") # you should be in the directory that contains the "exdata-data-houshold-power-consumption" directory at this point. If not, setwd() to that directory and then start running code from this line.
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
png("plot2.png")
plot(hpc$dtime, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
setwd("..")



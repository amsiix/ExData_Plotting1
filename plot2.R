library(sqldf)

# If the file doesn't exist, download and unzip it
if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "household_power_consumption.zip")
    unzip("household_power_consumption.zip")
}

# Only read the records for 01-Feb-2007 and 02-Feb-2007
d <- read.csv.sql("household_power_consumption.txt", sep=";",header=TRUE,
                  sql="select * from file where Date in ('1/2/2007','2/2/2007')")

d$Time = paste( d$Date, d$Time ) # create full datetime character
d$Time <- strptime(d$Time, format="%d/%m/%Y %H:%M:%S") # change class to POSIXlt

png("plot2.png", width = 480, height = 480)

#make sure the device is set up for a single plot
par(mfrow=c(1,1))

plot( d$Time, d$Global_active_power, 
      type="l", 
      xlab="",
      ylab="Global Active Power (kilowatts)")

dev.off()
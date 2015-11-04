library(sqldf)

if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "household_power_consumption.zip")
    unzip("household_power_consumption.zip")
}

d <- read.csv.sql("household_power_consumption.txt", sep=";",header=TRUE,
                    sql="select * from file where Date in ('1/2/2007','2/2/2007')")

d$Time = paste( d$Date, d$Time ) # create full datetime character
d$Time <- strptime(d$Time, format="%d/%m/%Y %H:%M:%S") # change class to POSIXlt

#### Todo
## change setwd logic

png("plot1.png", width=480, height=480)
par(mfrow=c(1,1))

hist( d$Global_active_power, 
      main="Global Active Power", 
      xlab="Global Active Power (kilowatts)", 
      ylab="Frequency",
      #ylim=c(0,1300),
      col="red")

dev.off()

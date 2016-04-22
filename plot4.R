#Load in file if required
if (!file.exists("household_power_consumption.zip")) {
        download.file(
                "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "household_power_consumption.zip"
        )
}
#Read data
data <- read.table(unz("household_power_consumption.zip", 
                       "household_power_consumption.txt"), 
                   sep = ";", 
                   header = TRUE, 
                   colClasses = 
                           c("factor", "factor", "numeric", "numeric", "numeric",
                             "numeric", "numeric", "numeric", "numeric"),
                   na.strings = "?")
#Add datetime column
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
#Subset data
data <- subset(data, 
               DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                       DateTime <= as.POSIXct("2007-02-02 23:59:59"))
png("plot4.png")
#Plot 4x4 grid
par(mfcol = c(2,2))
#Plot 1
with(subset(data, 
            DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                    DateTime <= as.POSIXct("2007-02-02 23:59:59")),
     plot(DateTime, Global_active_power, type = "l", 
          ylab = "Global Active Power (kilowatts)",
          xlab = "",
          xaxt='n'))
axis(1,
     at=c(
             as.POSIXct("2007-02-01 00:00:00"),
             as.POSIXct("2007-02-02 00:00:00"),
             as.POSIXct("2007-02-02 23:59:59")),
     labels=c("Thu", "Fri", "Sat"))
#Plot 2
with(data,
     plot(DateTime, Sub_metering_1, type = "n", 
          ylab = "Energy sub metering",
          xlab = "",
          xaxt='n'))
axis(1,
     at=c(
             as.POSIXct("2007-02-01 00:00:00"),
             as.POSIXct("2007-02-02 00:00:00"),
             as.POSIXct("2007-02-02 23:59:59")),
     labels=c("Thu", "Fri", "Sat"))
lines(data$DateTime, data$Sub_metering_1, col = "black")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1),
       lwd=c(2.5,2.5),col=c("black", "red", "blue"))
#Plot 3
with(subset(data, 
            DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                    DateTime <= as.POSIXct("2007-02-02 23:59:59")),
     plot(DateTime, Voltage, type = "l", 
          ylab = "Voltage",
          xaxt='n'))
axis(1,
     at=c(
             as.POSIXct("2007-02-01 00:00:00"),
             as.POSIXct("2007-02-02 00:00:00"),
             as.POSIXct("2007-02-02 23:59:59")),
     labels=c("Thu", "Fri", "Sat"))
#Plot 4
with(subset(data, 
            DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                    DateTime <= as.POSIXct("2007-02-02 23:59:59")),
     plot(DateTime, Global_reactive_power, type = "l", 
          xaxt='n'))
axis(1,
     at=c(
             as.POSIXct("2007-02-01 00:00:00"),
             as.POSIXct("2007-02-02 00:00:00"),
             as.POSIXct("2007-02-02 23:59:59")),
     labels=c("Thu", "Fri", "Sat"))
dev.off()
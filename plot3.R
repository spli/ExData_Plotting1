#Load in file if required
if (!file.exists("household_power_consumption.zip")) {
        download.file(
                "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "household_power_consumption.zip"
        )
}
#Read in data
data <- read.table(unz("household_power_consumption.zip", 
                       "household_power_consumption.txt"), 
                   sep = ";", 
                   header = TRUE, 
                   colClasses = 
                           c("factor", "factor", "numeric", "numeric", "numeric",
                             "numeric", "numeric", "numeric", "numeric"),
                   na.strings = "?")
#Create date time column
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
#Subset data to what we need
data <- subset(data, 
               DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                       DateTime <= as.POSIXct("2007-02-02 23:59:59"))
png("plot3.png")
#Empty plot
with(data,
     plot(DateTime, Sub_metering_1, type = "n", 
          ylab = "Energy sub metering",
          xlab = "",
          xaxt='n'))
#Add custom axis
axis(1,
     at=c(
             as.POSIXct("2007-02-01 00:00:00"),
             as.POSIXct("2007-02-02 00:00:00"),
             as.POSIXct("2007-02-02 23:59:59")),
     labels=c("Thu", "Fri", "Sat"))
#Add lines for sub_metering data
lines(data$DateTime, data$Sub_metering_1, col = "black")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
#add legend
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1),
       lwd=c(2.5,2.5),col=c("black", "red", "blue"))
dev.off()
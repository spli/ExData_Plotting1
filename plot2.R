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
#Create date time column from date and time
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
#Set up PNG for writing
png("plot2.png")
#Create line plot
with(subset(data, 
            DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                    DateTime <= as.POSIXct("2007-02-02 23:59:59")),
     plot(DateTime, Global_active_power, type = "l", 
          ylab = "Global Active Power (kilowatts)",
          xlab = "",
          xaxt='n'))
#Insert custom axis
axis(1,
     at=c(
             as.POSIXct("2007-02-01 00:00:00"),
             as.POSIXct("2007-02-02 00:00:00"),
             as.POSIXct("2007-02-02 23:59:59")),
     labels=c("Thu", "Fri", "Sat"))
dev.off()
#Load in file if required
if (!file.exists("household_power_consumption.zip")) {
        download.file(
                "https://d396qusza40orc.cloudfront.net/" +
                "exdata%2Fdata%2Fhousehold_power_consumption.zip",
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
#Convert date column to date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#set up png for writing
png("plot1.png")
#Plot histogram
hist(subset(data, Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")
#Close device
dev.off()
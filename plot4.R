## Reads the "Individual household electric power consumption Data Set" from the
## UC Irvine ML repository, and plots 4 different data series in a grid.

library(data.table)
library(dplyr)

fd <- fread(input = "household_power_consumption.txt", na.strings = "?")

# subset data into range of interest

fd.sub <- filter(fd, Date == "1/2/2007" | Date == "2/2/2007")

# add a date time column
fd.sub <- mutate(fd.sub, 
                 datetime = as.POSIXct(strptime(paste(Date, " ", Time), 
                                                "%d/%m/%Y    %H:%M:%S")))
# open PNG device
png(filename = "plot4.png", width = 480, height = 480)

# set locale to english for correct day names
cloc <- Sys.getlocale("LC_TIME")

# set locale on windows systems
Sys.setlocale("LC_TIME", "English_US")

# set 2x2 plotting grid
par(mfrow = c(2,2))

# plot 1 - global active power
plot(fd.sub$datetime, fd.sub$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# plot 2 - voltage
plot(fd.sub$datetime, fd.sub$Voltage, 
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

# plot 3 - sub metering
plot(fd.sub$datetime, fd.sub$Sub_metering_1, 
     type = "l",
     col = "black",
     ylab = "Energy sub metering",
     xlab = "")
lines(fd.sub$datetime, fd.sub$Sub_metering_2,
      type = "l",
      col = c("red"))
lines(fd.sub$datetime, fd.sub$Sub_metering_3,
      type = "l",
      col = c("blue"))
legend(x = "topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1, lwd = 1, bty = "n")

# plot 4 - global reactive power
plot(fd.sub$datetime, fd.sub$Global_reactive_power, 
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

Sys.setlocale("LC_TIME", cloc)

# shut down PNG device, saves file
dev.off()
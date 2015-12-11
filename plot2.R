## Reads the "Individual household electric power consumption Data Set" from the
## UC Irvine ML repository, and plots global active power over a time period.

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
png(filename = "plot2.png", width = 480, height = 480)

# set locale to english for correct day names
cloc <- Sys.getlocale("LC_TIME")

# set locale on windows systems
Sys.setlocale("LC_TIME", "English_US")

# draw graph of power over time
plot(fd.sub$datetime, fd.sub$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

Sys.setlocale("LC_TIME", cloc)

# shut down PNG device, saves file
dev.off()
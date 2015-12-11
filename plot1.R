## Reads the "Individual household electric power consumption Data Set" from the
## UC Irvine ML repository, and plots a histogram of global active power.

library(data.table)
library(dplyr)

fd <- fread(input = "household_power_consumption.txt", na.strings = "?")

# subset data immediatly

fd.sub <- filter(fd, Date == "1/2/2007" | Date == "2/2/2007")

# open PNG device
png(filename = "plot1.png", width = 480, height = 480)

# Draw histogram of global active power
hist(fd.sub$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     col = c("red"))

# shut down PNG device, saves file
dev.off()

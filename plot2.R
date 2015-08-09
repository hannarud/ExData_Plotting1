# Workspace config
# setwd("/home/hannarud/Documents/ExploratoryDataAnalysis/ExData_Plotting1/")

library(lubridate)

Sys.setlocale("LC_TIME", "C")

# The example content of file household_power_consumption.txt:
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
# 16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
# 16/12/2006;17:26:00;5.374;0.498;233.290;23.000;0.000;2.000;17.000

# Compute number of rows we want to skip (from beginning to 2007-02-01)
init_date = dmy_hms("16/12/2006 17:23:00")
print(init_date)

start_date = dmy_hms("01/02/2007 00:00:00")
print(start_date)

to_skip = difftime(start_date, init_date, units="mins")
print(to_skip)

# Compute number of rows we want to read (2-day period from 2007-02-01 to 2007-02-02)
end_date = dmy_hms("03/02/2007 00:00:00")
print(end_date)

to_read = difftime(end_date, start_date, units="mins")
print(to_skip)

# Read the necessary data from file
sample <- read.table("./household_power_consumption.txt",
                     header=TRUE, sep=";", quote="", comment.char="",
                     nrows=10)
classes <- sapply(sample,class)
header <- read.table("./household_power_consumption.txt", nrows = 1, header = FALSE,
                     sep =';', stringsAsFactors = FALSE)
plotdata <- read.csv("./household_power_consumption.txt", header = FALSE, sep = ";", 
                     skip = to_skip, nrows = to_read, na.strings = "?",
                     stringsAsFactors = FALSE, colClasses = classes)
colnames(plotdata) <- unlist(header)

plotdata$DateTime <- as.POSIXct(paste(plotdata$Date, plotdata$Time), format="%d/%m/%Y %H:%M:%S")

head(plotdata)
tail(plotdata)

# OK, data is ready, let's make plot2.png

png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot(plotdata$DateTime, plotdata$Global_active_power, type= "l", lwd=1,
     ylab= "Global Active Power (kilowatts)", xlab="")

dev.off()

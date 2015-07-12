library(dplyr)
library(lubridate)
library(data.table)

# first load the data from the "data" directory in the working directory
df <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings='?')

# formate the date
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

# get the subset of data for 2 days 
df <- subset(df, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# format date and time and add column
temp <- paste(as.character(df$Date), as.character(df$Time),sep=" ")
temp <- strptime(temp, format="%Y-%m-%d %H:%M")
df$DateTime <- temp

# create the graph # 4
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
# top left
plot(df$DateTime, df$Global_active_power, ylab='Global Active Power', xlab='', type='l')
# top right
plot(df$DateTime, df$Voltage, xlab='datetime', ylab='Voltage', type='l')
# bottom left
plot(df$DateTime, df$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
lines(df$DateTime, df$Sub_metering_2, col='red')
lines(df$DateTime, df$Sub_metering_3, col='blue')
legend('topright',  
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), 
       lty=c(1,1,1), bty = "n")
# bottom right
plot(df$DateTime, df$Global_reactive_power, xlab='datetime', ylab='Global_reactive_power', type='l')
dev.off()
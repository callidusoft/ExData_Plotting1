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

# create the graph # 2
png("plot2.png", width = 480, height = 480)
plot(df$DateTime, df$Global_active_power, ylab="Global Active Power (kilowatts)", type="l", xlab="")
dev.off()
install.packages("plyr")
install.packages("dplyr")
install.packages("stringr")
install.packages("readr")
install.packages("lubridate")
library(plyr)
library(dplyr)
library(stringr)
library(readr)
library(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
unzip(temp)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

remove(temp)

## dates are d/m/yyyy

data_subset <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

data_subset$Date <- dmy(data_subset$Date) #correct format of date

data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)

data_subset$day <- wday(data_subset$Date, label = TRUE, abbr = TRUE)
data_subset$day <- as.character(data_subset$day)

data_subset$datetime <- paste(data_subset$Date, data_subset$Time, sep = " ")
data_subset$datetime <- ymd_hms(data_subset$datetime)

png(filename = "plot3.png") #default w x h = 480 x 480 px

with(data_subset, plot(Sub_metering_1 ~ datetime, 
                       type = "l",
                       xlab = "",
                       ylab = "Energy sub metering"))

with(data_subset, lines(Sub_metering_2 ~ datetime, col = "red"))
with(data_subset, lines(Sub_metering_3 ~ datetime, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 2)

dev.off()




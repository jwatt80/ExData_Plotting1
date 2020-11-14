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
data_subset$Date <- as.Date(data_subset$Date)
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)

png(filename = "plot1.png") #default w x h = 480 x 480 px

hist(data_subset$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()



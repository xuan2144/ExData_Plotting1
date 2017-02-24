##check the file names under zip file
unzip("project01.zip", list = T)

#read txt data
df <- read.table(unz("project01.zip","household_power_consumption.txt"), na.strings = "?", quote = "", header = T, sep = ";")

#subset data from the dates 2007-02-01 and 2007-02-02
library(dplyr)
library(lubridate)
df_subset <- filter(df, as.character(Date)=="1/2/2007" | as.character(Date)=="2/2/2007")

#add new column (will be used as x axis) to data
df_subset02 <- mutate(df_subset, x_value = paste(as.character(df_subset$Date),as.character(df_subset$Time)))

#subset and melt data in order to prepare y axis
df_subset03 <- melt(select(df_subset02, x_value, Sub_metering_1, Sub_metering_2, Sub_metering_3), id=c("x_value"))

#create png file
png(filename = "plot3.png", width = 480, height = 480)

#plot
with(df_subset03, plot(dmy_hms(df_subset03$x_value), value, type = "n",ylab = "Energy sub metering"), xlab = "")
with(subset(df_subset03, variable == "Sub_metering_1"), points(dmy_hms(x_value), value, type = "l"))
with(subset(df_subset03, variable == "Sub_metering_2"), points(dmy_hms(x_value), value, type = "l", col = "red"))
with(subset(df_subset03, variable == "Sub_metering_3"), points(dmy_hms(x_value), value, type = "l", col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close file device
dev.off()
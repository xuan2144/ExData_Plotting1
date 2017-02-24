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

#create png file
png(filename = "plot2.png", width = 480, height = 480)

#plot
with(df_subset02, plot(dmy_hms(df_subset02$x_value), Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab=""))

#close file device
dev.off()
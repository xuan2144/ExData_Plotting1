##check the file names under zip file
unzip("project01.zip", list = T)

#read txt data
df <- read.table(unz("project01.zip","household_power_consumption.txt"), na.strings = "?", quote = "", header = T, sep = ";")

#subset data from the dates 2007-02-01 and 2007-02-02
library(dplyr)
df_subset <- filter(df, as.character(Date)=="1/2/2007" | as.character(Date)=="2/2/2007")

#create png file
png(filename = "plot1.png", width = 480, height = 480)

#hist plot
hist(df_subset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

#close file device
dev.off()
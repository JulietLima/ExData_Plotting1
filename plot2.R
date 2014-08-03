#I like to use data tables instead of data frames
library("data.table")

##Read in the file
data <- fread("household_power_consumption.txt", na.strings="?")
#Subset
data <- data <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]
#Format date
datetime <- as.POSIXlt(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")
data <- cbind(data,data.frame(datetime))
data[,Date:=NULL]
data[,Time:=NULL]
#Format rest of the data
data[,Global_active_power:=as.double(Global_active_power)]
data[,Global_reactive_power:=as.double(Global_reactive_power)]
data[,Voltage:=as.double(Voltage)]
data[,Global_intensity:=as.double(Global_intensity)]
data[,Sub_metering_1:=as.double(Sub_metering_1)]
data[,Sub_metering_2:=as.double(Sub_metering_2)]
data[,Sub_metering_3:=as.double(Sub_metering_3)]


## Code for plotting
par(mar=c(1,1,2,1), ps=12, pin=c(5,5))
plot(data$datetime, data$Global_active_power, type="n",
     ylab = "Global Active Power (kilowatts)", xlab="")
lines(data$datetime, data$Global_active_power)

#Output
dev.copy(png, file = "./plot2.png")
dev.off()
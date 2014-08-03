#I like to use data tables instead of data frames
library("data.table")

##Read in the file
data <- fread("household_power_consumption.txt", na.strings="?")
#Subset
data <- data <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]
#Format date
data[,datetime:=paste(Date,Time)]
data[,datetime:=as.Date(strptime(datetime, "%d/%m/%Y %H:%M:%S"))]
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
par(mar=c(3,1,2,1), ps=12, pin=c(5,5))
hist(data$Global_active_power, col="Red", main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)", yaxt="n")
axis(2,at=c(0,200,400,600,800,1000,1200))
#Output
dev.copy(png, file = "./plot1.png")
dev.off()

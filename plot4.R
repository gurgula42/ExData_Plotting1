url1<-("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
download.file(url1, "./data/household_power_consumption.zip", method="curl")
unzip("./data/household_power_consumption.zip")
power <- read.table("household_power_consumption.txt", header = T, sep=";", comment.char="%", stringsAsFactors=FALSE, na.strings="?") 
library(lubridate)
power$Date<-dmy(power$Date)
power12<-subset(power, power$Date >= "2007-01-31" & power$Date <= "2007-02-02")
power12$Global_active_power<-as.numeric(power12$Global_active_power)
power12 <- transform(power12, timestamp=as.POSIXct(paste(Date, Time)), "%Y-%m-%d %H:%M:%S")

par(mfrow=c(2,2), mar=c(5,5,2,2), oma=c(0,0,2,0))

plot(power12$timestamp, power12$Global_active_power, xlab="", ylab="Global Active Power", type="l")

plot(power12$timestamp, power12$Voltage, xlab="datetime", ylab="Voltage", type="l")

plot(power12$timestamp, power12$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(power12$timestamp, power12$Sub_metering_2, type="l", col="red")
lines(power12$timestamp, power12$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1 ","Sub_metering_2 ", "Sub_metering_3 "),lty=c(1,1), bty="n", cex=.5)

plot(power12$timestamp, power12$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.copy(png, file="plot4.png")
dev.off()
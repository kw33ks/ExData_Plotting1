# Download file

if (!file.exists("data.zip")) {
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./data.zip")
  unzip("./data.zip")
}

fulldata <- read.csv("./household_power_consumption.txt",na.strings = "?",sep = ";",stringsAsFactors = FALSE)

data = subset(fulldata, Date %in% c("1/2/2007","2/2/2007"))

#Combine date and time columns

datetime <- paste(data$Date,data$Time, sep = " ")
newdatetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S",tz="GMT")

#Add cleaned datetime column to old data

power <- cbind(newdatetime,data[,3:9])


# - - - - - - - - - - - - - - - - - - - - - - - - 


# Open PNG Device
png(file="plot4.png",width=480,height=480)

par(mfrow=c(2,2))

with(power, {

#plot top left
  
  plot(power$Global_active_power, type = "l", main="",ylab = "Global Active Power",xaxt='n',xlab= "")
  axis(1, at=c(1,nrow(data)/2,nrow(data)),labels=c("Thu","Fri","Sat"))

#plot top right

  plot(power$Voltage, type = "l", main="",ylab = "Voltage",xaxt='n',yaxt='n',xlab= "datetime")
  axis(2, at=c(234,236,238,240,242,244,246),labels=c("234","","238","","242","","246"))
  axis(1, at=c(1,nrow(data)/2,nrow(data)),labels=c("Thu","Fri","Sat"))
  
#plot bottom left 

  plot(power$Sub_metering_1, type = "l", main="",ylab = "Energy sub metering",xaxt='n',xlab= "")
  lines(power$Sub_metering_2, type = "l", col = "red", main="",ylab = "Energy sub metering",xaxt='n',xlab= "")
  lines(power$Sub_metering_3, type = "l", col = "blue", main="",ylab = "Energy sub metering",xaxt='n',xlab= "")
  axis(1, at=c(1,nrow(data)/2,nrow(data)),labels=c("Thu","Fri","Sat"))
  legend("topright", bty = "n", lty = 1,col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#plot bottom right

  plot(power$Global_reactive_power, type = "l", main="",ylab = "Global_reactive_power",xaxt='n',xlab= "datetime")
  axis(1, at=c(1,nrow(data)/2,nrow(data)),labels=c("Thu","Fri","Sat"))

})

# Close PNG file device
dev.off()
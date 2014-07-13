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
png(file="plot3.png",width=480,height=480)

# Plot submetering 1 
plot(power$Sub_metering_1, type = "l", main="",ylab = "Energy sub metering",xaxt='n',xlab= "")

# Plot submetering 2
lines(power$Sub_metering_2, type = "l", col = "red", main="",ylab = "Energy sub metering",xaxt='n',xlab= "")

# Plot submetering 3
lines(power$Sub_metering_3, type = "l", col = "blue", main="",ylab = "Energy sub metering",xaxt='n',xlab= "")

axis(1, at=c(1,nrow(data)/2,nrow(data)),labels=c("Thu","Fri","Sat"))

legend("topright", lty = 1,col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Close PNG file device
dev.off()
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
png(file="plot1.png",width=480,height=480)

# Create plot and send it to file
hist(power$Global_active_power, col="red", main="Global Active Power",xlab = "Global Active Power (kilowatts)")

# Close PNG file device
dev.off()
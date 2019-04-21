if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip(filename) 
}

#load Dataset 

Dataset <- read.delim("exdata_data_household_power_consumption/household_power_consumption.txt", stringsAsFactors = FALSE, 
                      sep = ";", na.strings = "?", header = TRUE)%>%
  filter(Date %in% c("1/2/2007", "2/2/2007"))
#Convert Date and time to Date class 

DateData <- paste(Dataset$Date, Dataset$Time)
Dataset$DateData <- strptime(DateData, "%d/%m/%Y %H:%M:%S")

#plot Figure
par(mfrow=c(2,2), mar=c(4,4,0,2), oma=c(0,0,2,0))
with(Dataset, {
  plot(DateData, Global_active_power, type="l", 
       ylab="Global Active Power", xlab="")
  plot(DateData, Voltage, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(DateData, Sub_metering_1, type="l", 
       ylab="Energy sub mereting", xlab="")
  lines(DateData, Sub_metering_2,col='Red')
  lines(DateData, Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6)
  plot(DateData, Global_reactive_power, type="l", 
       ylab="Global_rective_power",xlab="datetime")
})

png("plot4.png", height=480, width=480)
dev.off()

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

with(Dataset, {
  plot(DateData,Sub_metering_1, type="l",
       ylab="Energy sub metering", xlab="")
  lines(DateData, Sub_metering_2,col='Red')
  lines(DateData, Sub_metering_3,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

png("plot3.png", height=480, width=480)
dev.off()
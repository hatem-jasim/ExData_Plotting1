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
  plot(DateData, Global_active_power, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
})

png("plot2.png", height=480, width=480)
dev.off()
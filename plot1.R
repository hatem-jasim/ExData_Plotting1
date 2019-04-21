#load dplyr for filtre data and make pipline
library(dplyr)

#Download DataSet
filename <- "exdata_data_household_power_consumption.zip"

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
#plot figure

hist(Dataset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

png("plot1.png", width=480, height=480)
dev.off()

#To run the code make sure household_power_consumption.txt is
#in working directory

#after downlaoding exdata_data_household_power_consumption.zip 
#and extracting it gives household_power_consumption.txt
getData<-function(filepath = "household_power_consumption.txt")
{
	#assuming household_power_consumption.txt is in current Directory
	#reading the data into dataframe household
	household<-read.table(filepath,
		 header = TRUE, sep = ";",colClasses = "character")
	#subsetting the data from of date "1/2/2007" and "2/2/2007"
	HH<-subset(household, household$Date=="1/2/2007" | household$Date=="2/2/2007")
	HH
}

#getting the data of interest from file
HH<-getData()
#open the PNG device
png(file = "plot1.png")
#making histogram of Global_active_power column of HH dataframe
hist(as.numeric(HH$Global_active_power), col = "red",
	main = "Global Active Power", xlab="Global Active Power (killowatts)")
#closing the device
dev.off()


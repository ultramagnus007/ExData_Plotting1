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

#get the time data for X axis
getDateVec<-function(HH)
{
	#combining character vector Date and time and 
	#creating a character vector which has data and time combined
	#like "1/2/2007 00:00:00", "1/2/2007 00:01:00"...
	datestr <- paste(HH$Date, HH$Time)

	#converting datestr vector into POSIXlt vector named date
	date <- strptime(datestr, "%d/%m/%Y %H:%M:%S")
	date
}

#plotting the graph
Plot<-function(date, HH)
{
	#ploting date on axis and Global_active_power on y axis
	plot(date , as.numeric(HH$Global_active_power), type = "l",xlab ="",
		ylab = "Global Active Power (killowatts)")
}
#getting the data of interest from file
HH<-getData()
#get the time data for X axis
date<-getDateVec(HH)
#open the PNG device
png(file = "plot2.png")
#plotting the graph
Plot(date, HH)
#closing the device
dev.off()


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
	#setting the mfrow in par for 2 rows and 2 columns 
	#for ploting area of subsequent plots
	par(mfrow = c(2,2))

	#first plot, date vs Global_active_power
	plot(date , as.numeric(HH$Global_active_power),
			type = "l", xlab = "", ylab = "Global Active Power")
	#second plot, date vs Voltage
	plot(date , as.numeric(HH$Voltage),
		type = "l", xlab = "datetime", ylab = "Voltage")
	#Third plot date vs each of 3 Sub_metering
	plot(date, as.numeric(HH$Sub_metering_1),
		type = "n", xlab = "",ylab = "Energy sub metering")
	lines(date , as.numeric(HH$Sub_metering_1), type = "l" , col = "black")
	lines(date , as.numeric(HH$Sub_metering_2), type = "l", col = "red")
	lines(date , as.numeric(HH$Sub_metering_3), type = "l", col = "blue")
	#adding legend on topright
	legend("topright",  col = c("black", "blue", "red"),
		legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
		lty=c(1,1,1))
	#fourth plot, date vs Global_reactive_power
	plot(date , as.numeric(HH$Global_reactive_power), type = "l",
		xlab = "datetime", ylab = "Global_reactive_power")
}


#getting the data of interest from file
HH<-getData()
#get the time data for X axis
date<-getDateVec(HH)

#open the PNG device
png(file = "plot4.png")
#plotting the graph
Plot(date, HH)
#closing the device
dev.off()





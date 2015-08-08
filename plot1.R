plot1<-function(){
        #read data into R 
        data<-read.table("../household_power_consumption.txt", na.strings="?", sep=";", skip=1, stringsAsFactors = FALSE,
                         col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        #format dates
        data$Date<-as.Date(data$Date, format="%d/%m/%Y")
        #format time
        data$Time<-strptime(data$Time, format="%H:%M:%S")
        #remove the false dates created
        data$Time<-format(data$Time, format="%H:%M:%S")
       
        #subset the data to create only dates for 2007-02-01 and 2007-02-02
        data<-subset(data,Date=="2007-02-01" | Date=="2007-02-02")
        #make histogram for Global Active Power
        hist(data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main = "Global Active Power")
        #save this to png (this saves as 480x480)
        dev.copy(png,"plot1.png")
        dev.off()
}

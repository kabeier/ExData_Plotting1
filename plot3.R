plot3<-function(){
        
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
        
        #merge my date and times into one col for plotting (this really makes the previous 3 steps(not the date grabbing) unnecessary but just oging to leave it this way
        
        data$dt <- paste(data$Date, data$Time, sep=" ")
        data$dt<-strptime(data$dt, format="%Y-%m-%d %H:%M:%S")
        
        #make sure numbers are numeric
        data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
        data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
        data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
        
        png("plot3.png", width=480, height=480)
        #make chart day/time by the 3 energy sub mettering data
        
        plot(data$dt, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(data$dt, data$Sub_metering_2, col="red")
        lines(data$dt, data$Sub_metering_3, col="blue")
        
        #make a legend
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("Black", "Red", "Blue"), lwd=1)
        
        #save to png
       
        dev.off()
}
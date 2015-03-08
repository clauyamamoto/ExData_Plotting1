
##load data from txt file
filedata <- read.table("household_power_consumption.txt", 
                       sep=";",
                       header=TRUE)


##convert to date/time
filedata$Time<-strptime(
  paste(
    as.character(filedata$Date),
    as.character(filedata$Time)
  ), 
  "%d/%m/%Y%H:%M:%S"
)

##convert to date
filedata$Date<-as.Date(
  as.character(filedata$Date), 
  "%d/%m/%Y"
)


##filter data based on date range
datafilter <- subset(filedata, 
                     Date >= as.Date("2007-02-01") & 
                       Date <= as.Date("2007-02-02"))

##convert  to numeric
datafilter$Global_active_power<- as.numeric(as.character(datafilter$Global_active_power))
datafilter$Global_reactive_power<- as.numeric(as.character(datafilter$Global_reactive_power))
datafilter$Voltage<- as.numeric(as.character(datafilter$Voltage))
datafilter$Sub_metering_1<- as.numeric(as.character(datafilter$Sub_metering_1))
datafilter$Sub_metering_2<- as.numeric(as.character(datafilter$Sub_metering_2))
datafilter$Sub_metering_3<- as.numeric(as.character(datafilter$Sub_metering_3))

png('plot4.png',height= 480,width=480)

##create histogram on Global_active_power
par(mar=c(4,4,2,2), mfcol=c(2,2), ask=FALSE)

#Plot1
plot(datafilter$Time,
     datafilter$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power")
#Plot2
plot(datafilter$Time,
     datafilter$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(datafilter$Time,
      datafilter$Sub_metering_2,
      col="red")
lines(datafilter$Time,
      datafilter$Sub_metering_3,
      col="blue")
legend("topright", 
       col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1),
       bty="n",cex=1)
#Plot3
plot(datafilter$Time,
     datafilter$Voltage, 
     type="l", 
     xlab="datetime", 
     ylab="Voltage")

#Plot4
plot(datafilter$Time,
     datafilter$Global_reactive_power, 
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")

##save histogram as png file

dev.off()



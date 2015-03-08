
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

##convert Global_active_power to numeric
datafilter$Global_active_power<- as.numeric(datafilter$Global_active_power)
datafilter$Global_active_power<- datafilter$Global_active_power/500

png('plot2.png',height= 480,width=480)

##create histogram on Global_active_power
par(mar=c(2,4,2,2), mfcol=c(1,1), ask=FALSE)

plot.default(datafilter$Time, 
             datafilter$Global_active_power,
             type="l", lty=1, lwd=1,
             ylab="Global Active Power (kilowatts)", 
             xlab="")

##save plot as png file
dev.off()
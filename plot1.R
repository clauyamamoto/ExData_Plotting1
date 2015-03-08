
##load data from txt file
filedata <- read.table("household_power_consumption.txt", 
                       sep=";",
                       header=TRUE)

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
globactpower<- as.numeric(datafilter$Global_active_power)
globactpower<- globactpower/500

png('plot1.png',height= 480,width=480)

##create histogram on Global_active_power
par(mar=c(4,4,2,2), mfcol=c(1,1), ask=FALSE)

hist(globactpower, 
     breaks=16, 
     main="Global Active Power",
     col="red", 
     ylim=c(0,1200), 
     xlab="Global Active Power (kilowatts)")

##save histogram as png file
dev.off()
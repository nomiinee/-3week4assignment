setwd("C:/Users/Jirawech/Documents/#4assignment1")
data<-read.csv("household_power_consumption.txt", sep= ";")
ydata<-subset(data, Date == "1/2/2007" | Date == "2/2/2007")
ydata<-transform(ydata, Date= strptime(ydata$Date, format ='%d/%m/%Y') )
ydata$Date.time<-strptime(paste(ydata$Date, ydata$Time, sep="/"), format ='%Y-%m-%d/%H:%M:%S') 
png(filename="plot1.png", width = 480 , height = 480)

#strptime(x, "%m/%d/%y %H:%M:%S")
#ydata<-subset(xdata, xdata$Date == "2007-02-01" | xdata$Date == "2007-02-02")
y1<-as.numeric(ydata$Global_active_power)
x1<-ydata$Date.time


plot(x1,y1, ylab="Global Active Power (kilowatts)", pch=' ', type = 'o')
dev.off()


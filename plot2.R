setwd("C:/Users/Jirawech/Documents/#4assignment1")
data<-read.csv("household_power_consumption.txt", sep= ";")
ydata<-subset(data, Date == "1/2/2007" | Date == "2/2/2007")
ydata<-transform(ydata, Date= strptime(ydata$Date, format ='%d/%m/%Y') )
ydata$Date.time<-strptime(paste(ydata$Date, ydata$Time, sep="/"), format ='%Y-%m-%d/%H:%M:%S') 
png(filename="plot2.png", width = 480 , height = 480)

x1<-ydata$Date.time
ysub1<-as.numeric(as.character(ydata$Sub_metering_1))
ysub2<-as.numeric(as.character(ydata$Sub_metering_2))
ysub3<-as.numeric(as.character(ydata$Sub_metering_3))

plot(x1,ysub1, ylab="Energy sub metering", pch=' ', type = 'o')
points(x1,ysub2,pch=' ', type = 'o', col = 'red')
points(x1,ysub3,pch=' ', type = 'o', col = 'blue')

legend("topright", pch = 1, col=c("black", "red", "blue"), legend=c("Sub metering_1", "Sub metering_2", "Sub metering_3"))

dev.off()
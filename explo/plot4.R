library(downloader) #for https
urlAdd<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" #source
download(urlAdd,"tmp.zip") #download
unzip("tmp.zip") #unzip

#read table from file, dealing with unusual seps and nas
hh<-read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?") 

#convert date, time; take subset for right dates
hh$Date<-as.Date(hh$Date,"%d/%m/%Y")
hh$Time<-strptime(hh$Time,"%H:%M:%S")
rightDays<-hh$Date==as.Date("1/2/2007","%d/%m/%Y")|hh$Date==as.Date("2/2/2007","%d/%m/%Y") 
hhSub<-subset(hh,rightDays)

#plot 4 - 4 plots in 1
#plot 4.1
par(mfrow=c(2,2)) # Split canvas
plot(hhSub$Global_active_power,xaxt="n",type="s",ylab="Global Active Power",xlab="")
axis(1, at=c(0,1441,2900),labels=c("Thu", "Fri", "Sat"))  
#plot 4.2
plot(hhSub$Voltage,type="s",xaxt="n",ylab="Voltage",xlab="datetime")
axis(1, at=c(0,1441,2900),labels=c("Thu", "Fri", "Sat"))  
#plot 4.3
plot(hhSub$Sub_metering_1,xaxt="n",type="s",ylab="Energy sub metering",xlab="")
lines(hhSub$Sub_metering_2,type="s",col="red") 
lines(hhSub$Sub_metering_3,type="s",col="blue")
axis(1, at=c(0,1441,2900),labels=c("Thu", "Fri", "Sat"))  
legend("topright",c("sub_metering_1","sub_metering_2","sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
#plot 4.4
plot(hhSub$Global_reactive_power,xaxt="n",type="s",xlab="datetime")
axis(1, at=c(0,1441,2900),labels=c("Thu", "Fri", "Sat"))  
#To file
dev.copy(png,file="plot4.png") # Opens PNG file
dev.off() # closes graphic device
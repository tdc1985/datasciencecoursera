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

#Plot 2
par(mfrow=c(1,1))
plot(hhSub$Global_active_power,type="s",xaxt="n",ylab="Global Active Power (kilowatts)",xlab="")
axis(1, at=c(0,1441,2900),labels=c("Thu", "Fri", "Sat"))
#To file
dev.copy(png,file="plot2.png")
dev.off()

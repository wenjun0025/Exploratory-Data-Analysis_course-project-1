#1 import data
library(lubridate)
library(stringr)
library(dplyr)

energy=read.table("exdata_data_household_power_consumption/household_power_consumption.txt",
                  header=T,sep=";",na.strings ="?")

energy_sub=energy %>% 
  filter(Date=="1/2/2007"|Date=="2/2/2007") 

energy_sub=energy_sub %>% 
  mutate(Datetime=str_c(Date,Time,sep=" ")) %>% 
  mutate(Datetime=dmy_hms(Datetime))
energy_sub=energy_sub %>% 
  select(Datetime,everything(),-Date,-Time)

#plot 4
opar=par(no.readonly = T)
png("plot4.png",width = 960, height = 960)
par(mfrow=c(2,2),mar=c(4,4,1,1),cex=0.75)
#plot 4.1
with(energy_sub,plot(Datetime,Global_active_power,type="l",
                     xlab="",ylab="Global Active Power(kilowatts)"))
#plot 4.2
with(energy_sub,plot(Datetime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
#plot 4.3
with(energy_sub,plot(Datetime,Sub_metering_1,col="black",type="l",
                     xlab="",ylab="Energy Sub Metering"))
with(energy_sub,points(Datetime,Sub_metering_2,col="red",type="l"))
with(energy_sub,points(Datetime,Sub_metering_3,col="blue",type="l"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1,1),cex=0.5,border="white",fill="white")
#plot 4.4
with(energy_sub,plot(Datetime,Global_reactive_power,type="l",xlab="datetime",ylab="Global Reactive Power"))
dev.off()
par(opar)

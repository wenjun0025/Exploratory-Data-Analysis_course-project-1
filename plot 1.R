#1 import data
energy=read.table("exdata_data_household_power_consumption/household_power_consumption.txt",
                  header=T,sep=";",na.strings ="?")

library(dplyr)
str(energy)
energy_sub=energy %>% 
  filter(Date=="1/2/2007"|Date=="2/2/2007") 
library(lubridate)
energy_sub$Date=dmy(energy_sub$Date)

# plot 1
png("plot1.png",width = 480, height = 480)
hist(energy_sub$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)",ylab="Frequency")
dev.off()


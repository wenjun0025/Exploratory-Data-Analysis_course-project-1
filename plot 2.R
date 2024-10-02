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


# plot 2
png("plot2.png",width = 480, height = 480)
with(energy_sub,plot(Datetime,Global_active_power,type="l",
                     xlab="",ylab="Global Active Power(kilowatts)"))
dev.off()
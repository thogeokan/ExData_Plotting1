getwd()
#setwd("Documents/Programming/R/exploratory")

library(dplyr)
library(lubridate)

fileName <- "household_power_consumption.txt"

# we only need a part of it, otherwise nrows = 2075260
surv <- read.csv(fileName, nrows = 575260, sep=";", as.is = TRUE, na.string = "NA")
surv  <- tbl_df(surv)

GAP <- surv %>% 
  select(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3, 
                      Global_active_power, Global_reactive_power,
                      Voltage) %>%
  mutate(Date2 = as.Date(Date,"%d/%m/%Y"))%>% 
  filter((ymd("2007-02-02") == ymd(Date2))|(ymd("2007-02-01") == ymd(Date2)))%>% 
  mutate(DateTime = paste(Date,Time)) %>%
  mutate(DateTime = as.POSIXct(strptime(DateTime, format="%d/%m/%Y %H:%M:%S"))) %>%
  mutate(Sub_metering_1 = as.numeric(as.character(Sub_metering_1) )) %>%
  mutate(Sub_metering_2 = as.numeric(as.character(Sub_metering_2) )) %>%
  mutate(Sub_metering_3 = as.numeric(as.character(Sub_metering_3) )) %>%
  mutate(Global_active_power = as.numeric(as.character(Global_active_power) ))%>%
  mutate(Global_reactive_power = as.numeric(as.character(Global_reactive_power) ))%>%
  mutate(Voltage = as.numeric(as.character(Voltage) ))


par(mfcol=c(2,2))
par(mar = c(4, 4, 2, 2))

plot(GAP$DateTime, GAP$Sub_metering_1, 
     type   = "l",
     ylab   = "Energy sub metering", 
     xlab   = "")

points(GAP$DateTime, GAP$Sub_metering_2, 
       type   = "l",
       col    = "red")

points(GAP$DateTime, GAP$Sub_metering_3, 
       type   = "l",
       col    = "blue")

legend("topright", 
       lwd=1, # width of line
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_1","Sub_metering_1"),
       cex=0.9,
       bty = "n",
       seg.len=2  # length of line 
       )   



plot(GAP$DateTime, GAP$Global_active_power, 
     type   = "l",
     ylab   = "Global Active Power (kilowatts)", 
     xlab   = "")


plot(GAP$DateTime, GAP$Voltage, 
     type   = "l",
     ylab   = "Voltage", 
     xlab   = "datetime")

plot(GAP$DateTime, GAP$Global_reactive_power, 
     type   = "l",
     ylab   = "Global_reactive_power (kilowatts)", 
     xlab   = "datetime")

dev.copy(png, file = "plot4.png")
dev.off()

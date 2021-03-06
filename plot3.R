getwd()
#setwd("Documents/Programming/R/exploratory")

library(dplyr)
library(lubridate)

fileName <- "household_power_consumption.txt"

# we only need a part of it, otherwise nrows = 2075260
surv <- read.csv(fileName, nrows = 575260, sep=";", as.is = TRUE, na.string = "NA")
surv  <- tbl_df(surv)

GAP <- surv %>% 
  select(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
  mutate(Date2 = as.Date(Date,"%d/%m/%Y"))%>% 
  filter((ymd("2007-02-02") == ymd(Date2))|(ymd("2007-02-01") == ymd(Date2)))%>% 
  mutate(DateTime = paste(Date,Time)) %>%
  mutate(DateTime = as.POSIXct(strptime(DateTime, format="%d/%m/%Y %H:%M:%S"))) %>%
  mutate(Sub_metering_1 = as.numeric(as.character(Sub_metering_1) )) %>%
  mutate(Sub_metering_2 = as.numeric(as.character(Sub_metering_2) )) %>%
  mutate(Sub_metering_3 = as.numeric(as.character(Sub_metering_3) ))





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

par(mar = c(4.1, 5.1, 4.1, 2.1))

dev.copy(png, file = "plot3.png")
dev.off()

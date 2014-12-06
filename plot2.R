getwd()
#setwd("Documents/Programming/R/exploratory")

library(dplyr)
library(lubridate)

fileName <- "household_power_consumption.txt"

# we only need a part of it, otherwise nrows = 2075260
surv <- read.csv(fileName, nrows = 575260, sep=";", as.is = TRUE, na.string = "NA")
surv  <- tbl_df(surv)

GAP <- surv %>% 
  select(Date, Time, Global_active_power) %>%
  mutate(Date2 = as.Date(Date,"%d/%m/%Y"))%>% 
  filter((ymd("2007-02-02") == ymd(Date2))|(ymd("2007-02-01") == ymd(Date2)))%>% 
  mutate(DateTime = paste(Date,Time)) %>%
  mutate(DateTime = as.POSIXct(strptime(DateTime, format="%d/%m/%Y %H:%M:%S"))) %>%
  mutate(Global_active_power = as.numeric(as.character(Global_active_power) ))



plot(GAP$DateTime, GAP$Global_active_power, 
     type   = "l",
     ylab   = "Global Active Power (kilowatts)", 
     xlab   = "")


par(mar = c(5.1, 5.1, 4.1, 2.1))

dev.copy(png, file = "plot2.png")
dev.off()

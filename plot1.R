getwd()
#setwd("Documents/Programming/R/exploratory")
#Sys.setlocale("LC_TIME", 'en_GB.UTF-8')

library(dplyr)
library(lubridate)

fileName <- "household_power_consumption.txt"

# we only need a part of it, otherwise nrows = 2075260
surv <- read.csv(fileName, nrows = 1075260, sep=";", as.is = TRUE, na.string = "NA")
surv  <- tbl_df(surv)

GAP <- surv %>% 
  select(Date, Global_active_power) %>%
  mutate(Date = as.Date(Date,"%d/%m/%Y"))%>% 
  #filter(!is.na(Global_active_power)) %>%
  filter((ymd("2007-02-02") == ymd(Date))|(ymd("2007-02-01") == ymd(Date)))


# converted to numeric, so we can use the values for our histogram
GAP_con <- as.numeric(as.character(GAP$Global_active_power))
par(mfcol=c(1,1))
par(mar = c(5.1, 5.1, 4.1, 2.1))
hist(GAP_con, 
     breaks = 12, 
     col    = "red",  
     ylab   = "fequency", 
     xlab   = "Global Active Power (kilowatts)",
     main   = "Global Active Power", 
     axes   = FALSE)

# setting the size of the labels and the annotation
par(cex.lab = 1.20)
par(cex.axis = 0.70)



#draw the axis
axis(side=1, at=seq(0, 6, by=2))
axis(side=2, at=seq(0, 1200, by=200))

dev.copy(png, file = "plot1.png")
dev.off()

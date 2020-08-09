library("data.table")


#Reads in data from file (folder named datos)
datos <- data.table::fread(input = "datos/household_power_consumption.txt"
                             , na.strings="?")

#enable POSIXct being filtered by time of day
datos[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
datos2 <- datos[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)


plot(x = datos2[, dateTime]
     , y = datos2[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

library("data.table")

#Reads in data from file (file in folder named datos)
datos <- data.table::fread(input = "datos/household_power_consumption.txt"
                             , na.strings="?"
)

 #enable POSIXct being filtered by time of day
datos[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
datos2 <- datos[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(datos2[, dateTime], datos2[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(datos2[, dateTime], datos2[, Sub_metering_2],col="red")
lines(datos2[, dateTime], datos2[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
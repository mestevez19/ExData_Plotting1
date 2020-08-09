library("data.table")

#Reads in data from file (located on folder named datos)
datos <- data.table::fread(input = "datos/household_power_consumption.txt"
                             , na.strings="?"
)

#enable POSIXct being filtered by time of day
datos[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
datosfiltrados <- datos[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(datosfiltrados[, dateTime], datosfiltrados[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(datosfiltrados[, dateTime],datosfiltrados[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(datosfiltrados[, dateTime], datosfiltrados[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(datosfiltrados[, dateTime], datosfiltrados[, Sub_metering_2], col="red")
lines(datosfiltrados[, dateTime], datosfiltrados[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(datosfiltrados[, dateTime], datosfiltrados[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
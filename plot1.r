library("data.table")



#Reads in data from file (already in folder named datos)
datos <- data.table::fread(input = "datos/household_power_consumption.txt"
                             , na.strings="?"
)


# Change Date Type

datos[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
datosfiltrado <- datos[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(datosfiltrado[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
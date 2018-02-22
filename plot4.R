# reading the data from the working directory
# note that Feb 01 2007 starts at row number 66638 while 
# Feb 02 2007 ends in row number 69517
pow <- read.table("household_power_consumption.txt", 
        header = F,skip = 66637, nrows = 2880, sep = ";")
names(pow) <- c("Date", "Time", "Global_active_power","Global_reactive_power",
                "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                "Sub_metering_3")

# pasting the Date and Time variables together, then converting it to a date object
pow$Date_Time <- strptime(paste(pow$Date, pow$Time, sep = "-"),"%d/%m/%Y-%H:%M:%S")

# converting other variables as numeric
for(i in 3:9){pow[,i] <- as.numeric(pow[,i])}

# generating plot1 and saving it to a .png file with specified dimensions
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(pow, plot(Date_Time,Global_active_power, type = "l", xlab = "",
         ylab = "Global Active Power"))
with(pow, plot(Date_Time, Voltage, type = "l", xlab = "datetime",
          ylab = "Voltage"))
with(pow, {plot(Date_Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    lines(Date_Time, Sub_metering_1, col = "black")
    lines(Date_Time, Sub_metering_2, col = "red")
    lines(Date_Time, Sub_metering_3, col = "blue")
    legend("topright", col = c("black","red","blue"),lty = c(1,1,1), cex = 0.9,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
})
with(pow,plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime",
          ylab = "Global_reactive_power"))
dev.off()

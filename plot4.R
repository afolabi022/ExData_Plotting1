data <- read.table("C:/Users/user/Desktop/household_power_consumption.txt")
data
data <- read.table("C:/Users/user/Desktop/household_power_consumption.txt", 
                   header = TRUE,      # The file has a header row
                   sep = ";",          # Columns are separated by semicolons
                   na.strings = "?",   # Treat "?" as missing values
                   stringsAsFactors = FALSE) # Prevent automatic factor conversion
data
getwd()
y <- filtered_data$frequency
x <-filtered_data$Global_reactive_power
#we need to check the structure of the datasetn
str(data)
#we need to convert the date coloumn  into the date format using as.date 
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset the date for the period requested
filtered_data  <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
library(data.table)
sum (is.na(filtered_data$Global_reactive_power))
names(filtered_data)
filtered_data$Date <- as.Date(filtered_data$Date, format = "%d/%m/%Y")  # Convert to Date format
filtered_data$datetime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), format = "%Y-%m-%d %H:%M:%S")


str(filtered_data$datetime)       # Ensure it's a POSIXct object
str(filtered_data$Sub_metering_1) # Ensure these are numeric
str(filtered_data$Sub_metering_2)
str(filtered_data$Sub_metering_3)
# Convert Sub_metering columns to numeric, handling missing values
filtered_data$Sub_metering_1 <- as.numeric(filtered_data$Sub_metering_1)
filtered_data$Sub_metering_2 <- as.numeric(filtered_data$Sub_metering_2)
filtered_data$Sub_metering_3 <- as.numeric(filtered_data$Sub_metering_3)

# Save the plot as a PNG
png("plot4.png", width = 480, height = 480)

# Set up a 2x2 layout
par(mfrow = c(2, 2))

# 1. Top-left: Global Active Power vs. Time
plot(filtered_data$datetime, filtered_data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)", 
     main = "")

# 2. Top-right: Voltage vs. Time
plot(filtered_data$datetime, filtered_data$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage", 
     main = "")

# 3. Bottom-left: Energy Submetering vs. Time
plot(filtered_data$datetime, filtered_data$Sub_metering_1, 
     type = "l", 
     col = "black", 
     xlab = "", 
     ylab = "Energy Submetering")

lines(filtered_data$datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$datetime, filtered_data$Sub_metering_3, col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, 
       bty = "n")  # No border for the legend

# 4. Bottom-right: Global Reactive Power vs. Time
plot(filtered_data$datetime, filtered_data$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global Reactive Power", 
     main = "")

# Close the PNG device
dev.off()
filtered_data$Date <- as.Date(filtered_data$Date, format = "%d/%m/%Y")  # Convert to Date format
filtered_data$datetime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), format = "%Y-%m-%d %H:%M:%S")

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
# Display the structure of the required columns
str(filtered_data$datetime)       # Ensure it's a POSIXct object
str(filtered_data$Sub_metering_1) # Ensure these are numeric
str(filtered_data$Sub_metering_2)
str(filtered_data$Sub_metering_3)
# Convert Sub_metering columns to numeric, handling missing values
filtered_data$Sub_metering_1 <- as.numeric(filtered_data$Sub_metering_1)
filtered_data$Sub_metering_2 <- as.numeric(filtered_data$Sub_metering_2)
filtered_data$Sub_metering_3 <- as.numeric(filtered_data$Sub_metering_3)


head(filtered_data$datetime)
filtered_data$Date <- as.Date(filtered_data$Date, format = "%d/%m/%Y")  # Convert to Date format
filtered_data$datetime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time), format = "%Y-%m-%d %H:%M:%S")
head(filtered_data$datetime)  # Display the first few datetime values
str(filtered_data$datetime)   # Confirm the class is POSIXct

png("plot3.png", width = 480, height = 480)
plot(filtered_data$datetime,filtered_data$Sub_metering_1, 
     type = "l", 
     col = "black", 
     xlab = "Time", 
     ylab = "Energy Submetering", 
     main = "Energy Submetering Over Time")

# Add Sub_metering_2 in red
lines(filtered_data$datetime, filtered_data$Sub_metering_2, col = "red")

# Add Sub_metering_3 in blue
lines(filtered_data$datetime, filtered_data$Sub_metering_3, col = "blue")


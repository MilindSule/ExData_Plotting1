# Module4W1 - Peer graded exercise-Project1
# Data Source: http://archive.ics.uci.edu/ml/index.php
# Code Book: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

# Loading data
# Conditional reading code>

# Read complete data file
# Note that in this dataset missing values are coded as "?".

ds <- read.csv(file="household_power_consumption.txt", header=TRUE,sep=";", na.strings = "?"
        ,colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# You may find it useful to convert the Date and Time variables to Date/Time classes in R
# using the strptime() and as.Date() functions.
str(ds)
ds$Date <- as.Date(ds$Date, "%d/%m/%Y")
str(ds)
#We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#One alternative is to read the data from just those dates rather than reading in the entire dataset and 
#subsetting to those dates.

ds1<- subset(ds, (ds$Date>=as.Date("2007-02-01") & ds$Date<=as.Date("2007-02-02")))

# Remove "NA"
# ds1 <- ds1[!is.na(ds1),]
# Extract complete dataset to eleminate NA's
# ds2 <- ds1[complete.cases(ds1),]

## Combine Date and Time column into dateTime using mutate function
library(dplyr)
names(ds1)
DateTime <- paste(ds1$Date, ds1$Time)
ds2 <- mutate(ds1, DateTime)
names(ds2)
ds2 <- ds2[,c(10,3,4,5,6,7,8,9)]
str(ds2)

ds2$DateTime <- as.POSIXct(DateTime)

## Making Plots

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
# Create a separate R code file (plot1.R, plot2.R etc.) that constructs the corresponding plot,
# i.e. code in plot1.R constructs the plot1.png. Your code file should include code for reading the data 
# so that the plot can be fully reproduced. You must also include the code that creates the PNG file.

# Add the PNG file and R code file to the top-level folder of your git repository (no need for separate sub-folders)

# Plot3
png(filename = "plot3.png",width = 480, height = 480, units = "px")

with(ds2, {
        plot(Sub_metering_1~DateTime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() ## Close the png file device

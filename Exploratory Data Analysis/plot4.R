#Exploratory Data Analysis Peer Review Project 1 plot 4

rm(list=ls())
getwd()

setwd("C:/Users/Daniel Slyngstad/Documents/R Working Directory/RMOOC2")

#reading in data
?read.table
df <- read.table('household_power_consumption.txt', sep = ';', header = TRUE)
head(df)
View(df)
dim(df)

?strptime

#subsetting for desired dates
df_sub <- subset(df, Date == '1/2/2007' | Date == '2/2/2007')


df_sub$Sub_metering1 <- as.numeric(as.character(df_sub$Sub_metering_1))
df_sub$Sub_metering2 <- as.numeric(as.character(df_sub$Sub_metering_2))
df_sub$Sub_metering3 <- as.numeric(as.character(df_sub$Sub_metering_3))

df_sub$voltageRec <- as.numeric(as.character(df_sub$Voltage))

head(df_sub)

#______________________________________________________________________________________
#plot4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

#plot2
plot(x = df_sub$datetime, y = df_sub$Global_active_power, type = 'l', xlab="", ylab="Global Active Power (kilowatts)")

#new topright plot
plot(x = df_sub$datetime, y = df_sub$voltageRec, type = 'l', xlab="", ylab="Global Active Power (kilowatts)")


#plot3
plot(df_sub$datetime, df_sub$Sub_metering1, type="l", ylab="Energy Submetering", xlab="")
lines(df_sub$datetime, df_sub$Sub_metering2, type="l", col="red")
lines(df_sub$datetime, df_sub$Sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#new bottomright plot
plot(x = df_sub$datetime, y = df_sub$Global_reactive_power, type = 'l', xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
